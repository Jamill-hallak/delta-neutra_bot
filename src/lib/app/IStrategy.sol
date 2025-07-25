// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IStrategy {
    function totalValueInToken() external view returns (uint256);
    function increase(uint256 wethAmount)
        external
        payable
        returns (bytes32 orderKey);
    function decrease(uint256 wethAmount, address withdrawCallback)
        external
        payable
        returns (bytes32 orderKey);
    function cancel(bytes32 orderKey) external;
    function claim() external;
    function transfer(address src, uint256 amount) external;
}
