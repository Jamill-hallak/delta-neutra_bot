// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IPriceFeed {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            // 1e8 = 1 USD
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
    function decimals() external view returns (uint8);
}
