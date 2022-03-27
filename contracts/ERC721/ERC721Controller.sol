// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./PlaytipusERC721.sol";

contract ERC721Controller is Ownable {

  /* Addresses that have access to target */
  mapping(address => bool) public isApproved;

  mapping(PlaytipusERC721 => bool) public targets;

  constructor(PlaytipusERC721 target) {
    targets[target] = true;
  }

  event OwnerAdded(address indexed owner);
  event OwnerRemoved(address indexed owner);

  function addOwner(address owner) public onlyOwner {
    isApproved[owner] = true;

    emit OwnerAdded(owner);
  }

  function removeOwner(address owner) public onlyOwner {
    isApproved[owner] = false;

    emit OwnerRemoved(owner);
  }

  function addTarget(PlaytipusERC721 target) public onlyOwner {
    targets[target] = true;
  }

  function removeTarget(PlaytipusERC721 target) public onlyOwner {
    targets[target] = false;
  }

  function safeMint(PlaytipusERC721 target, address to, string memory uri) public returns (uint) {
    require(isApproved[msg.sender] || msg.sender == owner(), "not owner or approved accounts can perform this action");
    require(targets[target], "target is not controlled by this contract");

    return target.safeMint(to, uri);
  }

  function transferTargetOwnership(PlaytipusERC721 target, address owner) public onlyOwner {
    require(targets[target], "target is not controlled by this contract");
    target.transferOwnership(owner);
  }
}