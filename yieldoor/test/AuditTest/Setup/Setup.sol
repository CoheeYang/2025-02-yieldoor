// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";
import {ERC20Mock} from "../../utils/MockERC20.sol";
import {Leverager} from "../../../src/Leverager.sol";
import {LendingPool} from "../../../src/LendingPool.sol";
import {Strategy} from "../../../src/Strategy.sol";
import {Vault} from "../../../src/Vault.sol";
import {PriceFeed} from "../../../src/PriceFeed.sol";
import {yToken} from "../../../src/yToken.sol";
import {UniswapV3Factory} from "../../../lib/v3-core/contracts/UniswapV3Factory.sol";
import {IUniswapV3Pool} from "../../../src/interfaces/IUniswapV3Pool.sol";
import {SwapRouter} from "../../../lib/v3-periphery/contracts/SwapRouter.sol";
import {UniswapSetUp} from "./UniswapSetUp.sol";
import {MockOracle} from "../../utils/MockOracle.sol";

contract  Setup is UniswapSetUp, CryticAsserts {
    //yiedoor
    Leverager leverager;
    LendingPool lendingPool;
    Strategy strategy;
    Vault vault;
    PriceFeed priceFeed;
    MockOracle token1_Oracle;
    MockOracle token0_Oracle;
    yToken yWETH;
    yToken yUSDC;


    address yWeth;
    address yUsdc;

    //actors
    address liquidator = address(0x888);
    address borrower1 = address(0x777);
    address borrower2 = address(0x7777);
    address borrower3 = address(0x77777);
    address depositor1 = address(0x666);
    address depositor2 = address(0x6666);
    address depositor3 = address(0x66666);
    address lender1 = address(0x555);
    address lender2 = address(0x5555);
    address lender3 = address(0x55555);
    address rebalancer = address(0x444);
    address recipient = address(0x333);

    address[] borrowers = [borrower1, borrower2, borrower3]; //who open leveraged position
    address[] depositors = [depositor1, depositor2, depositor3]; //who deposit to vault
    address[] lenders = [lender1, lender2, lender3]; //who deposit to lending pool
    address[] actors = [
        borrower1,
        borrower2,
        borrower3,
        depositor1,
        depositor2,
        depositor3,
        lender1,
        lender2,
        lender3
    ];

    modifier useDepositors(uint256 actorIndexSeed) {
       address currentDepositor = depositors[
            between(actorIndexSeed, 0, depositors.length - 1)
        ];
        vm.startPrank(currentDepositor);
        _;
        vm.stopPrank();
    }

    modifier useBorrowers(uint256 actorIndexSeed) {
       address currentBorrower = borrowers[
            between(actorIndexSeed, 0, borrowers.length - 1)
        ];
        vm.startPrank(currentBorrower);
        _;
        vm.stopPrank();
    }

    modifier useLenders(uint256 actorIndexSeed) {
       address currentLender = lenders[between(actorIndexSeed, 0, lenders.length - 1)];
        vm.startPrank(currentLender);
        _;
        vm.stopPrank();
    }

    modifier useActors(uint256 actorIndexSeed) {
      address currentActor = actors[between(actorIndexSeed, 0, actors.length - 1)];
        vm.startPrank(currentActor);
        _;
        vm.stopPrank();
    }

    function setup() internal  {
        vm.startPrank(owner); //start prank
        //new instances
        lendingPool = new LendingPool();
        leverager = new Leverager("", "", address(lendingPool));
        vault = new Vault(address(token0), address(token1));
        strategy = new Strategy(
            address(uniswapV3Pool),
            address(vault),
            rebalancer,
            recipient
        );
        priceFeed = new PriceFeed(); // TODO: Add parameters here
        token1_Oracle = new MockOracle();
        token0_Oracle = new MockOracle();

        //initialization
        ///lendingPool
        lendingPool.initReserve(address(token0));
        lendingPool.initReserve(address(token1));
        lendingPool.setLeverager(address(leverager));

        ///leverager
        leverager.setPriceFeed(address(priceFeed));
        leverager.setSwapRouter(address(swapRouter));
        /////_maxUsdLeverage, _maxTimesLeverage, collatPct, _maxCumulativeBorrowUSD
        leverager.initVault(address(vault), 1_000_000e18, 5e18, 0.1e18, 1e27);

        ///PriceFeed & Oracle
        priceFeed.setChainlinkPriceFeed(
            address(token0),
            address(token0_Oracle),
            604800
        );
        priceFeed.setChainlinkPriceFeed(
            address(token1),
            address(token1_Oracle),
            604800
        );
        token0_Oracle.setPrice(2500e18); //weth
        token1_Oracle.setPrice(1e18); //usdc

        ///vault
        vault.setStrategy(address(strategy));
        vm.stopPrank(); //stop prank

  


        yWeth = lendingPool.getYTokenAddress(address(token0));
        yUsdc = lendingPool.getYTokenAddress(address(token1));

        yWETH = yToken(yWeth);
        yUSDC = yToken(yUsdc);


        ///approve
        for (uint i = 0; i < actors.length; i++) {
            AprroveTokens(i);
        }

        vault_setDepositFee(10);
        strategy_setRebalanceInterval(0);//to relax restrictions of rebalance

        leverager_setLiquidationFee(5000);//5000/10_000 = 50%
    }

    function AprroveTokens(uint256 actor) internal {
        address selectedActor = actors[actor];
        vm.startPrank(selectedActor);
        token0.approve(address(vault), type(uint256).max);
        token1.approve(address(vault), type(uint256).max);

        token0.approve(address(leverager), type(uint256).max);
        token1.approve(address(leverager), type(uint256).max);

        yWETH.approve(address(lendingPool), type(uint256).max);
        yUSDC.approve(address(lendingPool), type(uint256).max);

        vm.stopPrank();
    }

    function vault_setDepositFee(uint256 _fee) internal {
        _fee = between(_fee, 0, 10);
        vm.prank(owner); //prank
        vault.setDepositFee(_fee);
    }

    function strategy_setRebalanceInterval(uint256 _rebalanceInterval) internal{
        vm.prank(owner); //prank
        strategy.setRebalanceInterval(_rebalanceInterval);
    }


      function leverager_setLiquidationFee(uint256 newFee) internal {
         leverager.setLiquidationFee(newFee) ;
    }

}
