// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {SetFunctions} from "./SetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
contract VaultPro is SetFunctions {

    function vault_deposit(
        uint256 amount0,
        uint256 amount1,
        uint256 index
    ) public useDepositors(index){
        uint256 token0_Balance_before = token0.balanceOf(msg.sender);
        uint256 token1_Balance_before = token1.balanceOf(msg.sender); 
        uint256 shares_before = vault.balanceOf(msg.sender);
        //precondition
        require(token0_Balance_before >= amount0, "Insufficient balance0");
        require(token1_Balance_before >= amount1, "Insufficient balance1");




        //action
        (uint256 shares,uint256 depositAmount0,uint256 depositAmount1) =vault.deposit(amount0, amount1, 0, 0);

       
        uint256 token0_Balance_after = token0.balanceOf(msg.sender);
        uint256 token1_Balance_after = token1.balanceOf(msg.sender);
        uint256 shares_after = vault.balanceOf(msg.sender);

        //postcondition
        //0.sanity check
        assert(shares_after-shares_before == shares);
        assert(token0_Balance_before-token0_Balance_after == depositAmount0);
        assert(token1_Balance_before-token1_Balance_after == depositAmount1);


    }

    function vault_withdraw(
        uint256 shares
    ) public {
        uint256 shares_before = vault.balanceOf(msg.sender);
        uint256 token0_Balance_before = token0.balanceOf(msg.sender);
        uint256 token1_Balance_before = token1.balanceOf(msg.sender);
        //precondition
        require(shares_before >= shares, "Insufficient shares");




        uint256 withdrawAmount0;
        uint256 withdrawAmount1;
        //action
        try vault.withdraw(shares, 0, 0) returns (
            uint256 _WithdrawAmount0,
            uint256 _WithdrawAmount1
        ) {
            withdrawAmount0 = _WithdrawAmount0;
            withdrawAmount1 = _WithdrawAmount1;
        } catch {
            t(false, "vault_withdraw_failed");//Invariant:withdraw never fails
        }

        uint256 shares_after = vault.balanceOf(msg.sender);
        uint256 token0_Balance_after = token0.balanceOf(msg.sender);
        uint256 token1_Balance_after = token1.balanceOf(msg.sender);

        //postcondition
        //0.sanity check
        assert(shares_before - shares_after == shares);
        assert(token0_Balance_after - token0_Balance_before == withdrawAmount0);
        assert(token1_Balance_after - token1_Balance_before == withdrawAmount1);


    }

    function vault_addVestingPosition(
        uint256 amount0,
        uint256 amount1
    ) public {
        uint256 ownerBalance0_before = token0.balanceOf(owner);
        uint256 ownerBalance1_before = token1.balanceOf(owner);


        //precondition
        require(ownerBalance0_before >= amount0, "Insufficient balance0");  
        require(ownerBalance1_before >= amount1, "Insufficient balance1");


        //action
        vm.prank(owner);
        token0.approve(address(vault), amount0);
        token1.approve(address(vault), amount1);
        vault.addVestingPosition(amount0, amount1, 0);//set duration to 0. 
                                                        //if failed,means checkPoolActivity failed
      
    
        uint256 ownerBalance0_after = token0.balanceOf(owner);
        uint256 ownerBalance1_after = token1.balanceOf(owner);
        //postcondition
        //0.sanity check
        assert(ownerBalance0_before - ownerBalance0_after == amount0);
        assert(ownerBalance1_before - ownerBalance1_after == amount1);
    
    }





    // function vault_approve(address spender, uint256 value) public {
    //     bool value0;
    //     try vault.approve(spender, value) returns (bool tempValue0) {
    //         value0 = tempValue0;
    //     } catch {
    //         t(false, "vault_approve");
    //     }
    // }

    // function vault_checkPoolActivity() public {
    //     bool value0;
    //     try vault.checkPoolActivity() returns (bool tempValue0) {
    //         value0 = tempValue0;
    //     } catch {
    //         t(false, "vault_checkPoolActivity");
    //     }
    // }

    // function vault_renounceOwnership() public {
    //     try vault.renounceOwnership() {} catch {
    //         t(false, "vault_renounceOwnership");
    //     }
    // }

    // function vault_setDepositFee(uint256 _fee) public {
    //     try vault.setDepositFee(_fee) {} catch {
    //         t(false, "vault_setDepositFee");
    //     }
    // }

    // function vault_setStrategy(address _newstrategy) public {
    //     try vault.setStrategy(_newstrategy) {} catch {
    //         t(false, "vault_setStrategy");
    //     }
    // }



    // function vault_transferFrom(
    //     address from,
    //     address to,
    //     uint256 value
    // ) public {
    //     bool value0;
    //     try vault.transferFrom(from, to, value) returns (bool tempValue0) {
    //         value0 = tempValue0;
    //     } catch {
    //         t(false, "vault_transferFrom");
    //     }
    // }

    // function vault_transferOwnership(address newOwner) public {
    //     try vault.transferOwnership(newOwner) {} catch {
    //         t(false, "vault_transferOwnership");
    //     }
    // }
}
