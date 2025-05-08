// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;
import {LendingPoolPro} from "./LendingPoolPro.sol";
import {VaultPro} from "./VaultPro.sol";
import {StrategyPro} from "./StrategyPro.sol";
import {LeveragerPro} from "./LeveragerPro.sol";



contract Integrator is LendingPoolPro, VaultPro, StrategyPro ,LeveragerPro
{
    //Asset part
    //1. The asset deposit through the vault
    // strategy.idleBalances();//idle balance
            //fees collected to feeRecipient from the strategy
            //tokens that transfered to the uniswap pool


    //2. The asset deposit through the lending pool
    //lenders deposit returns the yToken amount, record this one and minus the token
    // or just check the yToken total supply?






    //Liability part
    //1. The Lending pool part
    //when lender deposit, the ytoken held by lenders a liability







    /**
     * @notice  Asset=>Liability all the time?
     */
    function E2E_Asset_GT_Liability() public {
    }


}  



