// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Exchange.sol";

contract PlaytipusExchange is Exchange {

    string public constant name = "Playtipus Exchange";
    string public constant version = "1.0";
    string public constant codename = "Playtipus";

    /**
     * @dev Initialize a PlaytipusExchange instance
     * @param registryAddress Address of the registry instance which this Exchange instance will use
     * @param _erc721Controller Address of the PlaytipusERC721 controller
     * @param _protocolFee Fee transfer to protocolFeeAddress at every sale with INVERSE_BASIS_POINT
     * @param protocolFeeAddress Address to transfer protocol fees to
     */
    constructor (
        ProxyRegistry registryAddress,
        ERC721Controller _erc721Controller,
        uint _protocolFee,
        uint _creatorFee,
        address protocolFeeAddress)
    {
        registry = registryAddress;
        erc721Controller = _erc721Controller;
        protocolFee = _protocolFee;
        creatorFee = _creatorFee;
        protocolFeeRecipient = protocolFeeAddress;
    }
}