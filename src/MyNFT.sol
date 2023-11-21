// SPDX-Licence: MIT

pragma solidity 0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {

    uint256 private s_nftTokenCounter;
    constructor() ERC721("Catty", "CT"){
        s_nftTokenCounter = 0;

    }

    function mintNFT() public {

    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return "";

    }


}