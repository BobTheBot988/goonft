// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, ERC2981, Ownable {
    uint256 public nextTokenId;
    string private _baseTokenURI;

    constructor(
        string memory name_,
        string memory symbol_,
        string memory baseURI_,
        address royaltyReceiver,
        uint96 royaltyFeeBps
    )
        ERC721(name_, symbol_)
        Ownable(msg.sender) // OZ v5: set initial owner
    {
        _baseTokenURI = baseURI_;
        _setDefaultRoyalty(royaltyReceiver, royaltyFeeBps); // e.g., 500 = 5%
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
    }

    function mint(address to) external onlyOwner {
        uint256 tokenId = ++nextTokenId; // starts at 1
        _safeMint(to, tokenId);
    }

    function supportsInterface(bytes4 iid)
        public
        view
        override(ERC721, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(iid);
    }
}
