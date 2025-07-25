// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.26;

library Market {
    struct Props {
        address marketToken;
        address indexToken;
        address longToken;
        address shortToken;
    }
}
