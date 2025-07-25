// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

library Shift {
    struct Props {
        Addresses addresses;
        Numbers numbers;
    }

    struct Addresses {
        address account;
        address receiver;
        address callbackContract;
        address uiFeeReceiver;
        address fromMarket;
        address toMarket;
    }

    struct Numbers {
        uint256 marketTokenAmount;
        uint256 minMarketTokens;
        uint256 updatedAtTime;
        uint256 executionFee;
        uint256 callbackGasLimit;
    }
}
