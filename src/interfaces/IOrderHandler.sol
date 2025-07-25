// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {IBaseOrderUtils} from "../types/IBaseOrderUtils.sol";
import {OracleUtils} from "../types/OracleUtils.sol";
import {Order} from "../types/Order.sol";

interface IOrderHandler {
    function createOrder(
        address account,
        IBaseOrderUtils.CreateOrderParams calldata params
    ) external returns (bytes32);

    function simulateExecuteOrder(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory params
    ) external;

    function updateOrder(
        bytes32 key,
        uint256 sizeDeltaUsd,
        uint256 acceptablePrice,
        uint256 triggerPrice,
        uint256 minOutputAmount,
        uint256 validFromTime,
        bool autoCancel,
        Order.Props memory order
    ) external;

    function cancelOrder(bytes32 key) external;

    function executeOrder(
        bytes32 key,
        OracleUtils.SetPricesParams calldata oracleParams
    ) external;
}
