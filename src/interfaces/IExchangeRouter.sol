// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

import {DepositUtils} from "../types/DepositUtils.sol";
import {WithdrawalUtils} from "../types/WithdrawalUtils.sol";
import {OracleUtils} from "../types/OracleUtils.sol";
import {ShiftUtils} from "../types/ShiftUtils.sol";
import {IBaseOrderUtils} from "../types/IBaseOrderUtils.sol";
import {IMulticall} from "./IMulticall.sol";
import {IBaseRouter} from "./IBaseRouter.sol";

interface IExchangeRouter is IMulticall, IBaseRouter {
    function createDeposit(DepositUtils.CreateDepositParams calldata params)
        external
        payable
        returns (bytes32);

    function cancelDeposit(bytes32 key) external payable;

    function createWithdrawal(
        WithdrawalUtils.CreateWithdrawalParams calldata params
    ) external payable returns (bytes32);

    function cancelWithdrawal(bytes32 key) external payable;

    function executeAtomicWithdrawal(
        WithdrawalUtils.CreateWithdrawalParams calldata params,
        OracleUtils.SetPricesParams calldata oracleParams
    ) external payable;

    function createShift(ShiftUtils.CreateShiftParams calldata params)
        external
        payable
        returns (bytes32);

    function cancelShift(bytes32 key) external payable;

    function createOrder(IBaseOrderUtils.CreateOrderParams calldata params)
        external
        payable
        returns (bytes32);

    function updateOrder(
        bytes32 key,
        uint256 sizeDeltaUsd,
        uint256 acceptablePrice,
        uint256 triggerPrice,
        uint256 minOutputAmount,
        uint256 validFromTime,
        bool autoCancel
    ) external payable;

    function cancelOrder(bytes32 key) external payable;

    function claimFundingFees(
        address[] memory markets,
        address[] memory tokens,
        address receiver
    ) external payable returns (uint256[] memory);
}
