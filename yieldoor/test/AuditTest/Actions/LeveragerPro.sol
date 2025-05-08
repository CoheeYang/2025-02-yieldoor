// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {SetFunctions} from "./SetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {ILeverager} from "../../../src/interfaces/ILeverager.sol";
import {IMainnetRouter} from "../../../src/interfaces/IMainnetRouter.sol";
contract LeveragerPro is SetFunctions,ILeverager {



    /**
     * @notice  Approve the ERC721 leverager position
     */
    function leverager_approve(
        uint256 actorIndex,
        uint256 to,
        uint256 tokenId
    ) public useActors(actorIndex) {
        require(msg.sender == leverager.ownerOf(tokenId), "Not the owner");

        to = between(to, 0, actors.length - 1);
        address toAddress = actors[to];

        leverager.approve(to, tokenId);
    }

    /**
     * @notice  Transfer the ERC721 leverager position
     *          The leverager also has public transferFrom function
     */
    function leverager_safeTransferFrom(
        address from,
        uint256 to,
        uint256 tokenId
    ) public {
        require(
            from == leverager.ownerOf(tokenId),
            "From is Not the owner of NFT"
        );

        to = between(to, 0, actors.length - 1);
        address toAddress = actors[to];

        leverager.safeTransferFrom(from, toAddress, tokenId);
    }

    function leverager_liquidatePosition(
        uint256 liqId,
        uint256 swapAmountIn0,
        uint256 swapAmountIn1,
        bool hasToSwap
    ) public {
        ILeverager.LiquidateParams memory liqParams;
        liqParams.id = liqId;
        liqParams.minAmount0 = 0;
        liqParams.minAmount1 = 0;
        liqParams.hasToSwap = hasToSwap;

        if (hasToSwap) {
            IMainnetRouter.ExactInputParams memory swapParams;

            swapParams.amountIn = swapAmountIn0;
            swapParams.deadline = block.timestamp;
            swapParams.path = abi.encodePacked(
                address(token0),
                uint24(3000),
                address(token1)
            );
            swapParams.recipient = liquidator;
            liqParams.swapParams1 = abi.encode(swapParams);

            swapParams.amountIn = swapAmountIn1;
            swapParams.path = abi.encodePacked(
                address(token1),
                uint24(3000),
                address(token0)
            );
            liqParams.swapParams2 = abi.encode(swapParams);
        } else {
            liqParams.swapParams1 = bytes("");
            liqParams.swapParams2 = bytes("");
        }
        vm.prank(liquidator); //prank
        leverager.liquidatePosition(liqParams);
    }

    function leverager_openLeveragedPosition(
        uint256 positionAmount0,
        uint256 positionAmount1,
        uint256 LeveragedAmount0,
        uint256 LeveragedAmount1,
        uint256 maxBorrowAmount,
        bool token1_deno,
        uint256 borrowerIndex
    ) public useBorrowers(borrowerIndex) {
        //precondition
        require(
            token0.balanceOf(msg.sender) >= positionAmount0,
            "Insufficient token0"
        );
        require(
            token1.balanceOf(msg.sender) >= positionAmount1,
            "Insufficient token1"
        );

        //before
        uint256 before_token0Bal = token0.balanceOf(msg.sender);
        uint256 before_token1Bal = token1.balanceOf(msg.sender);

        ILeverager.LeverageParams memory lp;
        lp.amount0In = positionAmount0;
        lp.amount1In = positionAmount1;
        lp.vault0In = LeveragedAmount0;
        lp.vault1In = LeveragedAmount1;
        lp.vault = vault;
        lp.maxBorrowAmount = maxBorrowAmount;
        token1_deno ? lp.denomination = address(token1) : lp.denomination = address(
            token0
        );

        //TODO record this id and other inforamtion to check invariants
        //Action
        uint256 Pos_id = leverager.openLeveragedPosition(lp);
        Position memory pos = leverager.positions(Pos_id);        
    }

    function leverager_withdraw(
        uint256 posId,
        uint256 pctWithdraw,
        bool hasToSwap,
        uint256 swapAmountIn0,
        uint256 swapAmountIn1,
        uint256 actorIndex
    ) public useActors(actorIndex) {


        ILeverager.WithdrawParams memory wp;
        wp.id = posId;
        wp.pctWithdraw = between(pctWithdraw, 0.01e18 + 1, 1e18);
        wp.hasToSwap = hasToSwap;

        if (hasToSwap) {
            IMainnetRouter.ExactInputParams memory swapParams;

            swapParams.amountIn = swapAmountIn0;
            swapParams.deadline = block.timestamp;
            swapParams.path = abi.encodePacked(
                address(token0),
                uint24(3000),
                address(token0)
            );
            swapParams.recipient = liquidator;
            wp.swapParams1 = abi.encode(swapParams);

            swapParams.amountIn = swapAmountIn1;
            swapParams.path = abi.encodePacked(
                address(token1),
                uint24(3000),
                address(token0)
            );
            wp.swapParams2 = abi.encode(swapParams);
        } else {
            wp.swapParams1 = bytes("");
            wp.swapParams2 = bytes("");
        }

        //TODO:some assertion here
        try leverager.withdraw(wp) {} catch {
            t(false, "leverager_withdraw");
        }
    }

    // //////////TODO: move these functios below to setup
    // function leverager_setApprovalForAll(
    //     address operator,
    //     bool approved
    // ) public {
    //     try leverager.setApprovalForAll(operator, approved) {} catch {
    //         t(false, "leverager_setApprovalForAll");
    //     }
    // }

    // function leverager_setMinBorrow(uint256 _minBorrow) public {
    //     try leverager.setMinBorrow(_minBorrow) {} catch {
    //         t(false, "leverager_setMinBorrow");
    //     }
    // }

    // function leverager_safeTransferFrom(
    //     address from,
    //     address to,
    //     uint256 tokenId,
    //     bytes memory data
    // ) public {
    //     try leverager.safeTransferFrom(from, to, tokenId, data) {} catch {
    //         t(false, "leverager_safeTransferFrom");
    //     }
    // }

    // function leverager_setPriceFeed(address _priceFeed) public {
    //   try leverager.setPriceFeed(_priceFeed) {} catch {
    //       t(false, "leverager_setPriceFeed");
    //   }
    // }

    // function leverager_setSwapRouter(address _swapRouter) public {
    //   try leverager.setSwapRouter(_swapRouter) {} catch {
    //       t(false, "leverager_setSwapRouter");
    //   }
    // }

    // function leverager_transferFrom(
    //     address from,
    //     address to,
    //     uint256 tokenId
    // ) public {
    //     try leverager.transferFrom(from, to, tokenId) {} catch {
    //         t(false, "leverager_transferFrom");
    //     }
    // }

    // function leverager_transferOwnership(address newOwner) public {
    //     try leverager.transferOwnership(newOwner) {} catch {
    //         t(false, "leverager_transferOwnership");
    //     }
    // }
    // function leverager_renounceOwnership() public {
    //   try leverager.renounceOwnership() {} catch {
    //       t(false, "leverager_renounceOwnership");
    //   }
    // }

    // function leverager_changeVaultMaxBorrow(
    //     address vault,
    //     uint256 maxBorrow
    // ) public {
    //     try leverager.changeVaultMaxBorrow(vault, maxBorrow) {} catch {
    //         t(false, "leverager_changeVaultMaxBorrow");
    //     }
    // }

    // function leverager_changeVaultMinCollateralPct(
    //     address vault,
    //     uint256 minColateral
    // ) public {
    //     try
    //         leverager.changeVaultMinCollateralPct(vault, minColateral)
    //     {} catch {
    //         t(false, "leverager_changeVaultMinCollateralPct");
    //     }
    // }

    // function leverager_enableTokenAsBorrowed(address asset) public {
    //     try leverager.enableTokenAsBorrowed(asset) {} catch {
    //         t(false, "leverager_enableTokenAsBorrowed");
    //     }
    // }
}
