// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {DepositUtils} from "../types/DepositUtils.sol";
import {OracleUtils} from "../types/OracleUtils.sol";

interface IDepositHandler {
    function createDeposit(
        address account,
        DepositUtils.CreateDepositParams calldata params
    ) external returns (bytes32);
    function cancelDeposit(bytes32 key) external;
    function simulateExecuteDeposit(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory params
    ) external;
    function executeDeposit(
        bytes32 key,
        OracleUtils.SetPricesParams calldata oracleParams
    ) external;
}
