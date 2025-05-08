// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "../Setup/Setup.sol";

contract SetFunctions is Setup {
    function MintTokens(uint128 amount, uint256 actor) public {
      
        actor = between(actor, 0, actors.length - 1);
        uint256 _amount = uint256(amount);
        address selectedActor = actors[actor];

        require(
            token0.totalSupply() + _amount < type(uint256).max,
            "Cap exceeded0"
        );
        token0.mint(selectedActor, _amount);

        require(
            token1.totalSupply() + _amount < type(uint256).max,
            "Cap exceeded1"
        );
        token1.mint(selectedActor, _amount);
    }



    
    function ytoken_transfer(bool isyUSDC,uint256 index ,uint256 to, uint256 value) public useActors(index)  {
        address toAddress = actors[between(to,0,actors.length -1)];

        if(isyUSDC){
            yUSDC.transfer(toAddress,value);
        }
        else {
            yWETH.transfer(toAddress,value);
            
        }
    }


        /**TODO ADD SOME PRECONDTION
     * @notice  Transfer vault shares
     */
    function vault_transfer(uint256 index,uint256 to, uint256 value) public useActors(index) {
        
        
        address toAddress = actors[between(to,0,actors.length -1)];

        bool value0;
        try vault.transfer(toAddress, value) returns (bool tempValue0) {
            value0 = tempValue0;
        } catch {
            t(false, "vault_transfer");
        }
    }

    
}
