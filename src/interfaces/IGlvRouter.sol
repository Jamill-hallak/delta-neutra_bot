// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {GlvDepositUtils} from "../types/GlvDepositUtils.sol";
import {GlvWithdrawalUtils} from "../types/GlvWithdrawalUtils.sol";
import {OracleUtils} from "../types/OracleUtils.sol";
import {IMulticall} from "./IMulticall.sol";
import {IBaseRouter} from "./IBaseRouter.sol";

interface IGlvRouter is IMulticall, IBaseRouter {
    function createGlvDeposit(
        GlvDepositUtils.CreateGlvDepositParams calldata params
    ) external payable returns (bytes32);
    function cancelGlvDeposit(bytes32 key) external;
    function simulateExecuteGlvDeposit(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory simulatedOracleParams
    ) external payable;
    function simulateExecuteLatestGlvDeposit(
        OracleUtils.SimulatePricesParams memory simulatedOracleParams
    ) external payable;
    function createGlvWithdrawal(
        GlvWithdrawalUtils.CreateGlvWithdrawalParams calldata params
    ) external payable returns (bytes32);
    function cancelGlvWithdrawal(bytes32 key) external;
    function simulateExecuteGlvWithdrawal(
        bytes32 key,
        OracleUtils.SimulatePricesParams memory simulatedOracleParams
    ) external payable;
    function simulateExecuteLatestGlvWithdrawal(
        OracleUtils.SimulatePricesParams memory simulatedOracleParams
    ) external payable;
    function makeExternalCalls(
        address[] memory externalCallTargets,
        bytes[] memory externalCallDataList,
        address[] memory refundTokens,
        address[] memory refundReceivers
    ) external payable;
}
