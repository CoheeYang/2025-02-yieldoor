// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {SetFunctions} from "./SetFunctions.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";
import {vm} from "@chimera/Hevm.sol";
contract LendingPoolPro is SetFunctions {



    /**
     * @notice  //yToken应该作为负债的记录
     */
    function lendingPool_deposit(
        bool isUDSC,
        uint256 amount,
        uint256 index
    ) public useLenders(index) {
        
        address asset;
        isUDSC ? asset = address(token1) : asset = address(token0);
        //precondition
        uint256 lenderBalanceBefore = IERC20(asset).balanceOf(msg.sender);
        require(lenderBalanceBefore >= amount, "Insufficient balance");
        
        //before
        (,uint256 reserveBalanceBefore,) = getReserveInfo(asset);
  
              
        //action
        uint256 yTokenAmount=lendingPool.deposit(asset, amount, msg.sender);
            
  
        //postcondition
        uint256 lenderBalanceAfter = IERC20(asset).balanceOf(msg.sender);
        (,uint256 reserveBalanceAfter,) = getReserveInfo(asset);
        //1. output ytoken amount == corresponding token amount deposited
        assert(lenderBalanceBefore-lenderBalanceAfter = yTokenAmount);
        //2. reserve balance of corresponding token increased == ytoken amount
        assert(reserveBalanceAfter-reserveBalanceBefore = yTokenAmount);
    }


    /**
     * @notice  yAssetAmount：转入lendingPool被burn的yToken数量
     *          AssetTokenOut:lender通过lending获得的资产数量
     *          AssetTokenOut=reserve.yTokenToReserveExchangeRate() * yAssetAmount / PRECISION
     *          其中yTokenToReserveExchangeRate在(totalYTokens == 0 || totalLiquidity == 0)return PRECISION;
     *          否则 return totalLiquidity * PRECISION / totalYTokens;
     *          其中totalLiquidity是reserve(yToken)总资产代币数量=reserve.underlyingBalance+借出的token(带利息的)
     */
    function lendingPool_redeem(
        bool isUDSC,
        uint256 yAssetAmount,
        uint256 index
    ) public useLenders(index) {

        address underlyingAsset;
        isUDSC ? underlyingAsset = address(token1) : underlyingAsset = address(token0);
        //precondition
        (address yTokenAddress,,) = getReserveInfo(underlyingAsset);
        uint256 lender_yTokenBalance_Before = yToken(yTokenAddress).balanceOf(msg.sender);
        uint256 lender_underlyingAssetBalance_Before = IERC20(underlyingAsset).balanceOf(msg.sender);
        require(lender_yTokenBalance_Before >= yAssetAmount, "Insufficient yToken balance");



        //action
        uint256 AssetTokenOut = lendingPool.redeem(underlyingAsset, yAssetAmount, msg.sender);


        //postcondition
        uint256 lender_yTokenBalance_After = yToken(yTokenAddress).balanceOf(msg.sender);
        uint256 lender_underlyingAssetBalance_After = IERC20(underlyingAsset).balanceOf(msg.sender);
        //0.sanity check
        assert(lender_yTokenBalance_Before - lender_yTokenBalance_After == yAssetAmount);//ytoken actually transfered
        assert(lender_underlyingAssetBalance_After - lender_underlyingAssetBalance_Before == AssetTokenOut);//underlying asset actually received
        //1.AssetTokenOut >= Lender's yToken balance decreased
        assert(AssetTokenOut >= yAssetAmount);

    }
 



    //helper function
    //get reserve(yToken contract) Address
    //get reserve balance of corresponding token
    //get reserve total supply of yToken 
    function getReserveInfo(address asset) internal view returns (address reserveAddress, uint256 reserveBalance, uint256 reserveTotalSupply) {
       reserveAddress =lendingPool.getReserve(asset).yTokenAddress;
       reserveBalance = IERC20(asset).balanceOf(reserveAddress);
       reserveTotalSupply = yToken(reserveAddress).totalSupply();
    }








    //  function lendingPool_borrow(address asset, uint256 amount) public {
    //       try lendingPool.borrow(asset, amount) {} catch {
    //           t(false, "lendingPool_borrow");
    //       }
    //     } only leverager

    // function lendingPool_disableBorrowing(address asset) public {
    //   try lendingPool.disableBorrowing(asset) {} catch {
    //       t(false, "lendingPool_disableBorrowing");
    //   }
    // }

    // function lendingPool_emergencyPauseAll() public {
    //   try lendingPool.emergencyPauseAll() {} catch {
    //       t(false, "lendingPool_emergencyPauseAll");
    //   }
    // }

    // function lendingPool_enableBorrowing(address asset) public {
    //   try lendingPool.enableBorrowing(asset) {} catch {
    //       t(false, "lendingPool_enableBorrowing");
    //   }
    // }

    // function lendingPool_freezeReserve(address asset) public {
    //   try lendingPool.freezeReserve(asset) {} catch {
    //       t(false, "lendingPool_freezeReserve");
    //   }
    // }

    // function lendingPool_initReserve(address asset) public {
    //   try lendingPool.initReserve(asset) {} catch {
    //       t(false, "lendingPool_initReserve");
    //   }
    // }

    // function lendingPool_pullFunds(address asset, uint256 amount) public {
    //   try lendingPool.pullFunds(asset, amount) {} catch {
    //       t(false, "lendingPool_pullFunds");
    //   }
    // }

    // function lendingPool_pushFunds(address asset, uint256 amount) public {
    //   try lendingPool.pushFunds(asset, amount) {} catch {
    //       t(false, "lendingPool_pushFunds");
    //   }
    // }

    // function lendingPool_renounceOwnership() public {
    //   try lendingPool.renounceOwnership() {} catch {
    //       t(false, "lendingPool_renounceOwnership");
    //   }
    // }

    // function lendingPool_repay(address asset, uint256 amount) public {
    //     uint256 value0;
    //     try lendingPool.repay(asset, amount) returns (uint256 tempValue0) {
    //         value0 = tempValue0;
    //     } catch {
    //         t(false, "lendingPool_repay");
    //     }
    // }

    // function lendingPool_setBorrowingRateConfig(address asset, uint16 utilizationA, uint16 borrowingRateA, uint16 utilizationB, uint16 borrowingRateB, uint16 maxBorrowingRate) public {
    //   try lendingPool.setBorrowingRateConfig(asset, utilizationA, borrowingRateA, utilizationB, borrowingRateB, maxBorrowingRate) {} catch {
    //       t(false, "lendingPool_setBorrowingRateConfig");
    //   }
    // }

    // function lendingPool_setLeverageParams(address asset, uint256 _maxBorrow, uint256 _maxLeverage) public {
    //   try lendingPool.setLeverageParams(asset, _maxBorrow, _maxLeverage) {} catch {
    //       t(false, "lendingPool_setLeverageParams");
    //   }
    // }

    // function lendingPool_setLeverager(address _leverager) public {
    //   try lendingPool.setLeverager(_leverager) {} catch {
    //       t(false, "lendingPool_setLeverager");
    //   }
    // }

    // function lendingPool_setReserveCapacity(address asset, uint256 cap) public {
    //   try lendingPool.setReserveCapacity(asset, cap) {} catch {
    //       t(false, "lendingPool_setReserveCapacity");
    //   }
    // }

    // function lendingPool_transferOwnership(address newOwner) public {
    //   try lendingPool.transferOwnership(newOwner) {} catch {
    //       t(false, "lendingPool_transferOwnership");
    //   }
    // }

    // function lendingPool_unFreezeReserve(address asset) public {
    //   try lendingPool.unFreezeReserve(asset) {} catch {
    //       t(false, "lendingPool_unFreezeReserve");
    //   }
    // }

    // function lendingPool_unPauseAll() public {
    //   try lendingPool.unPauseAll() {} catch {
    //       t(false, "lendingPool_unPauseAll");
    //   }
    // }
}
