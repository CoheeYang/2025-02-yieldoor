// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";
import {UniswapV3Factory} from "../../../lib/v3-core/contracts/UniswapV3Factory.sol";
import {UniswapV3Pool} from "../../../lib/v3-core/contracts/UniswapV3Pool.sol";
import {SwapRouter} from "../../../lib/v3-periphery/contracts/SwapRouter.sol";
import {ERC20Mock} from "../../utils/MockERC20.sol";
contract UniswapSetUp {

    //erc20
    ERC20Mock token0;//weth
    ERC20Mock token1;//usdc

    //uniswap
    UniswapV3Factory factory;
    UniswapV3Pool uniswapV3Pool;
    SwapRouter swapRouter;

    address owner = address(0x999);

    uint160 START_PRICE = 3000;
    uint24 FEE = 3000;

    constructor() {
        token0 = new ERC20Mock(8); //mock erc20 with 8 decimals weth
        token1 = new ERC20Mock(6); //mock erc20 with 6 decimals usdc

        vm.prank(owner);
        factory = new UniswapV3Factory(); 
        
        uniswapV3Pool = UniswapV3Pool(factory.createPool(address(token0), address(token1), FEE));
        uniswapV3Pool.initialize(START_PRICE);
        swapRouter = new SwapRouter(address(factory),address(token0)); 
    }
    

}


