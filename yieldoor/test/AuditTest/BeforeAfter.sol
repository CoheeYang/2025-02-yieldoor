
// SPDX-License-Identifier: GPL-2.0
// pragma solidity ^0.8.0;

// import {Setup} from "./Setup/Setup.sol";

// abstract contract BeforeAfter is Setup {

//     // struct Vars {
//     //     uint256 __IGNORE_AVOID_COMPILE_ERROR;
//     //     uint256 leverager_balanceOf;

//     //     address leverager_feeRecipient;

//     //     address leverager_getApproved;

//     //     tuple leverager_getPosition;

//     //     bool leverager_isApprovedForAll;

//     //     bool leverager_isLiquidateable;

//     //     string leverager_name;

//     //     address leverager_owner;

//     //     address leverager_ownerOf;

//     //     address leverager_pricefeed;

//     //     bool leverager_supportsInterface;

//     //     address leverager_swapRouter;

//     //     string leverager_symbol;

//     //     string leverager_tokenURI;
//     //     uint256 lendingPool_borrowingRateOfReserve;

//     //     uint256 lendingPool_exchangeRateOfReserve;

//     //     uint256 lendingPool_getCurrentBorrowingIndex;

//     //     address lendingPool_getYTokenAddress;

//     //     address lendingPool_leverager;

//     //     address lendingPool_owner;

//     //     bool lendingPool_paused;

//     //     uint256 lendingPool_totalBorrowsOfReserve;

//     //     uint256 lendingPool_totalLiquidityOfReserve;

//     //     uint256 lendingPool_utilizationRateOfReserve;
//     //     bool strategy_checkPoolActivity;

//     //     address strategy_feeRecipient;

//     //     tuple strategy_getMainPosition;

//     //     tuple strategy_getSecondaryPosition;

//     //     tuple strategy_getVestingPosition;

//     //     uint256 strategy_lastRebalance;

//     //     int24 strategy_maxObservationDeviation;

//     //     bool strategy_ongoingVestingPosition;

//     //     address strategy_owner;

//     //     address strategy_pool;

//     //     uint24 strategy_positionWidth;

//     //     uint256 strategy_price;

//     //     uint256 strategy_protocolFee;

//     //     uint256 strategy_rebalanceInterval;

//     //     address strategy_rebalancer;

//     //     int24 strategy_tickSpacing;

//     //     int24 strategy_tickTwapDeviation;

//     //     address strategy_token0;

//     //     address strategy_token1;

//     //     uint32 strategy_twap;

//     //     uint256 strategy_twapPrice;

//     //     int24 strategy_twapTick;

//     //     address strategy_vault;
//     //     uint256 vault_allowance;

//     //     uint256 vault_balanceOf;

//     //     uint8 vault_decimals;

//     //     uint256 vault_depositFee;

//     //     string vault_name;

//     //     address vault_owner;

//     //     uint256 vault_price;

//     //     address vault_strategy;

//     //     string vault_symbol;

//     //     address vault_token0;

//     //     address vault_token1;

//     //     uint256 vault_totalSupply;

//     //     uint256 vault_twapPrice;
//     //     uint256 priceFeed_getPrice;

//     //     bool priceFeed_hasPriceFeed;

//     //     address priceFeed_owner;
//     //     uint256 ytoken_allowance;

//     //     uint256 ytoken_balanceOf;

//     //     uint8 ytoken_decimals;

//     //     address ytoken_lendingPool;

//     //     string ytoken_name;

//     //     string ytoken_symbol;

//     //     uint256 ytoken_totalSupply;

//     //     address ytoken_underlyingAsset;

//     // }

//     // Vars internal _before;
//     // Vars internal _after;

//     // function __before() internal {
//     //     _before.leverager_balanceOf = leverager.balanceOf();
//     //     _before.leverager_feeRecipient = leverager.feeRecipient();
//     //     _before.leverager_getApproved = leverager.getApproved();
//     //     _before.leverager_getPosition = leverager.getPosition();
//     //     _before.leverager_isApprovedForAll = leverager.isApprovedForAll();
//     //     _before.leverager_isLiquidateable = leverager.isLiquidateable();
//     //     _before.leverager_name = leverager.name();
//     //     _before.leverager_owner = leverager.owner();
//     //     _before.leverager_ownerOf = leverager.ownerOf();
//     //     _before.leverager_pricefeed = leverager.pricefeed();
//     //     _before.leverager_supportsInterface = leverager.supportsInterface();
//     //     _before.leverager_swapRouter = leverager.swapRouter();
//     //     _before.leverager_symbol = leverager.symbol();
//     //     _before.leverager_tokenURI = leverager.tokenURI();

//     //     _before.lendingPool_borrowingRateOfReserve = lendingPool.borrowingRateOfReserve();
//     //     _before.lendingPool_exchangeRateOfReserve = lendingPool.exchangeRateOfReserve();
//     //     _before.lendingPool_getCurrentBorrowingIndex = lendingPool.getCurrentBorrowingIndex();
//     //     _before.lendingPool_getYTokenAddress = lendingPool.getYTokenAddress();
//     //     _before.lendingPool_leverager = lendingPool.leverager();
//     //     _before.lendingPool_owner = lendingPool.owner();
//     //     _before.lendingPool_paused = lendingPool.paused();
//     //     _before.lendingPool_totalBorrowsOfReserve = lendingPool.totalBorrowsOfReserve();
//     //     _before.lendingPool_totalLiquidityOfReserve = lendingPool.totalLiquidityOfReserve();
//     //     _before.lendingPool_utilizationRateOfReserve = lendingPool.utilizationRateOfReserve();

//     //     _before.strategy_checkPoolActivity = strategy.checkPoolActivity();
//     //     _before.strategy_feeRecipient = strategy.feeRecipient();
//     //     _before.strategy_getMainPosition = strategy.getMainPosition();
//     //     _before.strategy_getSecondaryPosition = strategy.getSecondaryPosition();
//     //     _before.strategy_getVestingPosition = strategy.getVestingPosition();
//     //     _before.strategy_lastRebalance = strategy.lastRebalance();
//     //     _before.strategy_maxObservationDeviation = strategy.maxObservationDeviation();
//     //     _before.strategy_ongoingVestingPosition = strategy.ongoingVestingPosition();
//     //     _before.strategy_owner = strategy.owner();
//     //     _before.strategy_pool = strategy.pool();
//     //     _before.strategy_positionWidth = strategy.positionWidth();
//     //     _before.strategy_price = strategy.price();
//     //     _before.strategy_protocolFee = strategy.protocolFee();
//     //     _before.strategy_rebalanceInterval = strategy.rebalanceInterval();
//     //     _before.strategy_rebalancer = strategy.rebalancer();
//     //     _before.strategy_tickSpacing = strategy.tickSpacing();
//     //     _before.strategy_tickTwapDeviation = strategy.tickTwapDeviation();
//     //     _before.strategy_token0 = strategy.token0();
//     //     _before.strategy_token1 = strategy.token1();
//     //     _before.strategy_twap = strategy.twap();
//     //     _before.strategy_twapPrice = strategy.twapPrice();
//     //     _before.strategy_twapTick = strategy.twapTick();
//     //     _before.strategy_vault = strategy.vault();

//     //     _before.vault_allowance = vault.allowance();
//     //     _before.vault_balanceOf = vault.balanceOf();
//     //     _before.vault_decimals = vault.decimals();
//     //     _before.vault_depositFee = vault.depositFee();
//     //     _before.vault_name = vault.name();
//     //     _before.vault_owner = vault.owner();
//     //     _before.vault_price = vault.price();
//     //     _before.vault_strategy = vault.strategy();
//     //     _before.vault_symbol = vault.symbol();
//     //     _before.vault_token0 = vault.token0();
//     //     _before.vault_token1 = vault.token1();
//     //     _before.vault_totalSupply = vault.totalSupply();
//     //     _before.vault_twapPrice = vault.twapPrice();

//     //     _before.priceFeed_getPrice = priceFeed.getPrice();
//     //     _before.priceFeed_hasPriceFeed = priceFeed.hasPriceFeed();
//     //     _before.priceFeed_owner = priceFeed.owner();

//     //     _before.ytoken_allowance = ytoken.allowance();
//     //     _before.ytoken_balanceOf = ytoken.balanceOf();
//     //     _before.ytoken_decimals = ytoken.decimals();
//     //     _before.ytoken_lendingPool = ytoken.lendingPool();
//     //     _before.ytoken_name = ytoken.name();
//     //     _before.ytoken_symbol = ytoken.symbol();
//     //     _before.ytoken_totalSupply = ytoken.totalSupply();
//     //     _before.ytoken_underlyingAsset = ytoken.underlyingAsset();
//     // }

//     // function __after() internal {
//     //     _after.leverager_balanceOf = leverager.balanceOf();
//     //     _after.leverager_feeRecipient = leverager.feeRecipient();
//     //     _after.leverager_getApproved = leverager.getApproved();
//     //     _after.leverager_getPosition = leverager.getPosition();
//     //     _after.leverager_isApprovedForAll = leverager.isApprovedForAll();
//     //     _after.leverager_isLiquidateable = leverager.isLiquidateable();
//     //     _after.leverager_name = leverager.name();
//     //     _after.leverager_owner = leverager.owner();
//     //     _after.leverager_ownerOf = leverager.ownerOf();
//     //     _after.leverager_pricefeed = leverager.pricefeed();
//     //     _after.leverager_supportsInterface = leverager.supportsInterface();
//     //     _after.leverager_swapRouter = leverager.swapRouter();
//     //     _after.leverager_symbol = leverager.symbol();
//     //     _after.leverager_tokenURI = leverager.tokenURI();

//     //     _after.lendingPool_borrowingRateOfReserve = lendingPool.borrowingRateOfReserve();
//     //     _after.lendingPool_exchangeRateOfReserve = lendingPool.exchangeRateOfReserve();
//     //     _after.lendingPool_getCurrentBorrowingIndex = lendingPool.getCurrentBorrowingIndex();
//     //     _after.lendingPool_getYTokenAddress = lendingPool.getYTokenAddress();
//     //     _after.lendingPool_leverager = lendingPool.leverager();
//     //     _after.lendingPool_owner = lendingPool.owner();
//     //     _after.lendingPool_paused = lendingPool.paused();
//     //     _after.lendingPool_totalBorrowsOfReserve = lendingPool.totalBorrowsOfReserve();
//     //     _after.lendingPool_totalLiquidityOfReserve = lendingPool.totalLiquidityOfReserve();
//     //     _after.lendingPool_utilizationRateOfReserve = lendingPool.utilizationRateOfReserve();

//     //     _after.strategy_checkPoolActivity = strategy.checkPoolActivity();
//     //     _after.strategy_feeRecipient = strategy.feeRecipient();
//     //     _after.strategy_getMainPosition = strategy.getMainPosition();
//     //     _after.strategy_getSecondaryPosition = strategy.getSecondaryPosition();
//     //     _after.strategy_getVestingPosition = strategy.getVestingPosition();
//     //     _after.strategy_lastRebalance = strategy.lastRebalance();
//     //     _after.strategy_maxObservationDeviation = strategy.maxObservationDeviation();
//     //     _after.strategy_ongoingVestingPosition = strategy.ongoingVestingPosition();
//     //     _after.strategy_owner = strategy.owner();
//     //     _after.strategy_pool = strategy.pool();
//     //     _after.strategy_positionWidth = strategy.positionWidth();
//     //     _after.strategy_price = strategy.price();
//     //     _after.strategy_protocolFee = strategy.protocolFee();
//     //     _after.strategy_rebalanceInterval = strategy.rebalanceInterval();
//     //     _after.strategy_rebalancer = strategy.rebalancer();
//     //     _after.strategy_tickSpacing = strategy.tickSpacing();
//     //     _after.strategy_tickTwapDeviation = strategy.tickTwapDeviation();
//     //     _after.strategy_token0 = strategy.token0();
//     //     _after.strategy_token1 = strategy.token1();
//     //     _after.strategy_twap = strategy.twap();
//     //     _after.strategy_twapPrice = strategy.twapPrice();
//     //     _after.strategy_twapTick = strategy.twapTick();
//     //     _after.strategy_vault = strategy.vault();

//     //     _after.vault_allowance = vault.allowance();
//     //     _after.vault_balanceOf = vault.balanceOf();
//     //     _after.vault_decimals = vault.decimals();
//     //     _after.vault_depositFee = vault.depositFee();
//     //     _after.vault_name = vault.name();
//     //     _after.vault_owner = vault.owner();
//     //     _after.vault_price = vault.price();
//     //     _after.vault_strategy = vault.strategy();
//     //     _after.vault_symbol = vault.symbol();
//     //     _after.vault_token0 = vault.token0();
//     //     _after.vault_token1 = vault.token1();
//     //     _after.vault_totalSupply = vault.totalSupply();
//     //     _after.vault_twapPrice = vault.twapPrice();

//     //     _after.priceFeed_getPrice = priceFeed.getPrice();
//     //     _after.priceFeed_hasPriceFeed = priceFeed.hasPriceFeed();
//     //     _after.priceFeed_owner = priceFeed.owner();

//     //     _after.ytoken_allowance = ytoken.allowance();
//     //     _after.ytoken_balanceOf = ytoken.balanceOf();
//     //     _after.ytoken_decimals = ytoken.decimals();
//     //     _after.ytoken_lendingPool = ytoken.lendingPool();
//     //     _after.ytoken_name = ytoken.name();
//     //     _after.ytoken_symbol = ytoken.symbol();
//     //     _after.ytoken_totalSupply = ytoken.totalSupply();
//     //     _after.ytoken_underlyingAsset = ytoken.underlyingAsset();
//     // }
// }
