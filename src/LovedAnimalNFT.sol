// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract LovedAnimal is ERC721, Ownable {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error LovedAnimal__CantFlipAnimalIfNotOwner();

    enum NFTState {
        CAT,
        DOG
    }

    uint256 private s_tokenCounter;
    string private s_catSvgUri;
    string private s_dogSvgUri;

    mapping(uint256 => NFTState) private s_tokenIdToState;

    event CreatedNFT(uint256 indexed tokenId);

    constructor(string memory dogSvgUri, string memory catSvgUri) ERC721("LovedAnimal NFT", "LAN") Ownable(msg.sender) {
        s_tokenCounter = 0;
        s_dogSvgUri = dogSvgUri;
        s_catSvgUri = catSvgUri;
    }

    function mintNft() public {
        // how would you require payment for this NFT?
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNFT(tokenCounter);
    }

    function flipAnimal(uint256 tokenId) public {
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert LovedAnimal__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToState[tokenId] == NFTState.CAT) {
            s_tokenIdToState[tokenId] = NFTState.DOG;
        } else {
            s_tokenIdToState[tokenId] = NFTState.CAT;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        }
        string memory imageURI = s_catSvgUri;

        if (s_tokenIdToState[tokenId] == NFTState.DOG) {
            imageURI = s_dogSvgUri;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"',
                            name("Animal i love"), // You can add whatever name here
                            '", "description":"An NFT that you can flip based on which animal you love either CAT or DOG, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "lovedAnimal", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function getCatSVG() public view returns (string memory) {
        return s_catSvgUri;
    }

    function getDogSVG() public view returns (string memory) {
        return s_dogSvgUri;
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}