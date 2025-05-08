// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {SetFunctions} from "./SetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
contract StrategyPro is SetFunctions {
    function strategy_collectFees() public {
        ///recipient should increase the balance TODO:add some white box invariants
        try strategy.collectFees() {} catch (bytes memory err) {}
    }

    function strategy_compound() public {
        vm.prank(rebalancer);
        try strategy.compound() {} catch (bytes memory err) {}
    }

    function strategy_rebalance() public {
        // action
        vm.startPrank(rebalancer);
        try strategy.rebalance() {} catch (bytes memory err) {}
        //potential fail due to checkPoolActivity ==false
        //or other uniswap shit
    }

    // bool ongoing_VestingPostion;
    // function strategy_addVestingPosition(
    //     uint256 amount0,
    //     uint256 amount1,
    //     uint256 _vestDuration
    // ) public {
    //     require(!ongoing_VestingPostion,"already have a vestingPosition")

    //     try
    //         strategy.addVestingPosition(amount0, amount1, _vestDuration)
    //     {} catch {
    //         t(false, "strategy_addVestingPosition");
    //     }
    // } only vault

    // function strategy_renounceOwnership() public {
    //   try strategy.renounceOwnership() {} catch {
    //       t(false, "strategy_renounceOwnership");
    //   }
    // }

    //     function strategy_changeFeeRecipient(address _newRecipient) public {
    //   try strategy.changeFeeRecipient(_newRecipient) {} catch {
    //       t(false, "strategy_changeFeeRecipient");
    //   }
    // }

    // function strategy_changePositionWidth(uint24 _newWidth) public {
    //   try strategy.changePositionWidth(_newWidth) {} catch {
    //       t(false, "strategy_changePositionWidth");
    //   }
    // }

    // function strategy_changeRebalancer(address newRebalancer) public {
    //   try strategy.changeRebalancer(newRebalancer) {} catch {
    //       t(false, "strategy_changeRebalancer");
    //   }
    // }

    // function strategy_setMaxObservationDeviation(uint24 _maxObservationDeviation) public {
    //   try strategy.setMaxObservationDeviation(_maxObservationDeviation) {} catch {
    //       t(false, "strategy_setMaxObservationDeviation");
    //   }
    // }

    // function strategy_setProtocolFee(uint256 _protocolFee) public {
    //   try strategy.setProtocolFee(_protocolFee) {} catch {
    //       t(false, "strategy_setProtocolFee");
    //   }
    // }

    // function strategy_setRebalanceInterval(uint256 _rebalanceInterval) public {
    //   try strategy.setRebalanceInterval(_rebalanceInterval) {} catch {
    //       t(false, "strategy_setRebalanceInterval");
    //   }
    // }

    // function strategy_setTickTwapDeviation(uint24 _tickTwapDeviation) public {
    //   try strategy.setTickTwapDeviation(_tickTwapDeviation) {} catch {
    //       t(false, "strategy_setTickTwapDeviation");
    //   }
    // }

    // function strategy_setTwap(uint32 _twap) public {
    //   try strategy.setTwap(_twap) {} catch {
    //       t(false, "strategy_setTwap");
    //   }
    // }

    // function strategy_transferOwnership(address newOwner) public {
    //   try strategy.transferOwnership(newOwner) {} catch {
    //       t(false, "strategy_transferOwnership");
    //   }
    // }

    // function strategy_uniswapV3MintCallback(uint256 amount0, uint256 amount1, bytes memory ) public {
    //   try strategy.uniswapV3MintCallback(amount0, amount1, ) {} catch {
    //       t(false, "strategy_uniswapV3MintCallback");
    //   }
    // } only Pool

    // function strategy_withdrawPartial(uint256 shares, uint256 totalSupply) public {
    //     uint256 amount0Out;
    //     uint256 amount1Out;
    //     try strategy.withdrawPartial(shares, totalSupply) returns (uint256 tempAmount0Out, uint256 tempAmount1Out) {
    //         amount0Out = tempAmount0Out;
    //         amount1Out = tempAmount1Out;
    //     } catch {
    //         t(false, "strategy_withdrawPartial");
    //     }
    // } onlyVault
}
