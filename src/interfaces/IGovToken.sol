// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {IERC20} from "./IERC20.sol";

interface IGovToken is IERC20 {
    function delegate(address delegatee) external;
    function delegates(address account) external view returns (address);
}
