// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {Price} from "./Price.sol";

library OracleUtils {
    struct SetPricesParams {
        address[] tokens;
        address[] providers;
        bytes[] data;
    }

    struct SimulatePricesParams {
        address[] primaryTokens;
        Price.Props[] primaryPrices;
        uint256 minTimestamp;
        uint256 maxTimestamp;
    }

    struct ValidatedPrice {
        address token;
        uint256 min;
        uint256 max;
        uint256 timestamp;
        address provider;
    }
}
