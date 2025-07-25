// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import "../types/EventUtils.sol";
import "../types/Order.sol";

interface IOrderCallbackReceiver {
    function afterOrderExecution(
        bytes32 key,
        Order.Props memory order,
        EventUtils.EventLogData memory eventData
    ) external;
    function afterOrderCancellation(
        bytes32 key,
        Order.Props memory order,
        EventUtils.EventLogData memory eventData
    ) external;
    function afterOrderFrozen(
        bytes32 key,
        Order.Props memory order,
        EventUtils.EventLogData memory eventData
    ) external;
}
