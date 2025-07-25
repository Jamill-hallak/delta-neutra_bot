// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

library ShiftUtils {
    struct CreateShiftParams {
        address receiver;
        address callbackContract;
        address uiFeeReceiver;
        address fromMarket;
        address toMarket;
        uint256 minMarketTokens;
        uint256 executionFee;
        uint256 callbackGasLimit;
    }
}
