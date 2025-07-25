// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Price} from "../types/Price.sol";
import {Glv} from "../types/Glv.sol";
import {GlvDeposit} from "../types/GlvDeposit.sol";
import {GlvWithdrawal} from "../types/GlvWithdrawal.sol";
import {GlvShift} from "../types/GlvShift.sol";

interface IGlvReader {
    struct GlvInfo {
        Glv.Props glv;
        address[] markets;
    }

    function getGlvValue(
        address dataStore,
        address[] memory marketAddresses,
        Price.Props[] memory indexTokenPrices,
        Price.Props memory longTokenPrice,
        Price.Props memory shortTokenPrice,
        address glv,
        bool maximize
    ) external view returns (uint256);
    function getGlvTokenPrice(
        address dataStore,
        address[] memory marketAddresses,
        Price.Props[] memory indexTokenPrices,
        Price.Props memory longTokenPrice,
        Price.Props memory shortTokenPrice,
        address glv,
        bool maximize
    ) external view returns (uint256, uint256, uint256);
    function getGlv(address dataStore, address glv)
        external
        view
        returns (Glv.Props memory);
    function getGlvInfo(address dataStore, address glv)
        external
        view
        returns (GlvInfo memory);
    function getGlvBySalt(address dataStore, bytes32 salt)
        external
        view
        returns (Glv.Props memory);
    function getGlvs(address dataStore, uint256 start, uint256 end)
        external
        view
        returns (Glv.Props[] memory);
    function getGlvInfoList(address dataStore, uint256 start, uint256 end)
        external
        view
        returns (GlvInfo[] memory);
    function getGlvDeposit(address dataStore, bytes32 key)
        external
        view
        returns (GlvDeposit.Props memory);
    function getGlvDeposits(address dataStore, uint256 start, uint256 end)
        external
        view
        returns (GlvDeposit.Props[] memory);
    function getAccountGlvDeposits(
        address dataStore,
        address account,
        uint256 start,
        uint256 end
    ) external view returns (GlvDeposit.Props[] memory);
    function getGlvWithdrawal(address dataStore, bytes32 key)
        external
        view
        returns (GlvWithdrawal.Props memory);
    function getGlvWithdrawals(address dataStore, uint256 start, uint256 end)
        external
        view
        returns (GlvWithdrawal.Props[] memory);
    function getAccountGlvWithdrawals(
        address dataStore,
        address account,
        uint256 start,
        uint256 end
    ) external view returns (GlvWithdrawal.Props[] memory);
    function getGlvShift(address dataStore, bytes32 key)
        external
        view
        returns (GlvShift.Props memory);
    function getGlvShifts(address dataStore, uint256 start, uint256 end)
        external
        view
        returns (GlvShift.Props[] memory);
}
