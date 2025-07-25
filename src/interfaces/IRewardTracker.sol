// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IRewardTracker {
    function stakedAmounts(address account) external view returns (uint256);
}
