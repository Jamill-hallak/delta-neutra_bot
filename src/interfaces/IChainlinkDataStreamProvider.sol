// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {OracleUtils} from "../types/OracleUtils.sol";

interface IChainlinkDataStreamProvider {
    function oracle() external view returns (address);
    function verifier() external view returns (address);

    struct Report {
        bytes32 feedId;
        uint32 validFromTimestamp;
        uint32 observationsTimestamp;
        uint192 nativeFee;
        uint192 linkFee;
        uint32 expiresAt;
        int192 price;
        int192 bid;
        int192 ask;
    }

    function getOraclePrice(address token, bytes memory data)
        external
        returns (OracleUtils.ValidatedPrice memory);
}
