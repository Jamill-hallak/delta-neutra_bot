// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {GlvDepositUtils} from "../types/GlvDepositUtils.sol";
import {GlvWithdrawalUtils} from "../types/GlvWithdrawalUtils.sol";
import {OracleUtils} from "../types/OracleUtils.sol";

interface IGlvHandler {
    function createGlvDeposit(
        address account,
        GlvDepositUtils.CreateGlvDepositParams calldata params
    ) external payable returns (bytes32);
    function createGlvWithdrawal(
        address account,
        GlvWithdrawalUtils.CreateGlvWithdrawalParams calldata params
    ) external payable returns (bytes32);
    function cancelGlvDeposit(bytes32 key) external;
    function cancelGlvWithdrawal(bytes32 key) external;
    function simulateExecuteGlvDeposit(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory params
    ) external;
    function simulateExecuteGlvWithdrawal(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory params
    ) external;
    function executeGlvDeposit(
        bytes32 key,
        OracleUtils.SetPricesParams calldata oracleParams
    ) external;
    function executeGlvWithdrawal(
        bytes32 key,
        OracleUtils.SetPricesParams calldata oracleParams
    ) external;
}
