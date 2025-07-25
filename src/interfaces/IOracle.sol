// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {OracleUtils} from "../types/OracleUtils.sol";
import {Price} from "../types/Price.sol";

interface IOracle {
    function validateSequencerUp() external view;
    function setPrices(OracleUtils.SetPricesParams memory params) external;
    function setPricesForAtomicAction(OracleUtils.SetPricesParams memory params)
        external;
    function setPrimaryPrice(address token, Price.Props memory price)
        external;
    function setTimestamps(uint256 minTimestamp, uint256 maxTimestamp)
        external;
    function clearAllPrices() external;
    function getTokensWithPricesCount() external view returns (uint256);
    function getTokensWithPrices(uint256 start, uint256 end)
        external
        view
        returns (address[] memory);
    function getPrimaryPrice(address token)
        external
        view
        returns (Price.Props memory);
    function validatePrices(
        OracleUtils.SetPricesParams memory params,
        bool forAtomicAction
    ) external returns (OracleUtils.ValidatedPrice[] memory);
}
