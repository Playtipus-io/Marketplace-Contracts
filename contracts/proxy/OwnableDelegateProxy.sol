// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./OwnedUpgradeabilityProxy.sol";

contract OwnableDelegateProxy is OwnedUpgradeabilityProxy {

    constructor(address owner, address initialImplementation, bytes memory _calldata) {
        setUpgradeabilityOwner(owner);
        _upgradeTo(initialImplementation);
        (bool success, ) = initialImplementation.delegatecall(_calldata);
        require(success);
    }
}