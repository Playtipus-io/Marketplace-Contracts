// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/// @custom:security-contact tamir@playtipus.io
contract PlaytipusERC721 is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    using Counters for Counters.Counter;

    // Mapping from token ID to creator address
    mapping(uint256 => address) private _creators;

    Counters.Counter private _tokenIdCounter;
    string private baseURI;

    constructor() ERC721("Playtipus", "Moments") {}

    function safeMint(address to, string memory uri) public onlyOwner returns(uint) {
        return mint(to, uri);
    }

    function mint(address to, string memory uri) internal returns (uint) {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        _creators[tokenId] = to;
        return tokenId;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public onlyOwner {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        super._setTokenURI(tokenId, _tokenURI);
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overriden in child contracts.
     */
    function _baseURI() internal view override(ERC721) returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory newBaseURI) public onlyOwner {
        baseURI = newBaseURI;
    }

    function creatorOf(uint256 tokenId) public view returns (address) {
        address creator = _creators[tokenId];
        require(creator != address(0), "ERC721: query for nonexistent token");
        return creator;
    }
}