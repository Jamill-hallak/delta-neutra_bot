// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IChainlinkDataStreamVerifier {
    function verify(bytes calldata payload, bytes calldata parameterPayload)
        external
        payable
        returns (bytes memory verifierResponse);
}
