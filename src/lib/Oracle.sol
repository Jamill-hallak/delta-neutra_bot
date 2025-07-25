// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IPriceFeed} from "../interfaces/IPriceFeed.sol";

contract Oracle {
    // Returns USD price with 8 decimals
    function getPrice(address provider) external view returns (uint256) {
        (, int256 answer,,,) = IPriceFeed(provider).latestRoundData();
        require(answer >= 0, "answer < 0");
        return uint256(answer);
    }
}
