// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {LovedAnimalNFT} from "../src/LovedAnimalNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";

contract DeployAnimalNFT is Script {
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    function run() external returns (LovedAnimalNFT) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        string memory dogSvg = vm.readFile("./img/dog.svg");
        string memory catSvg = vm.readFile("./img/cat.svg");

        vm.startBroadcast(deployerKey);
        LovedAnimalNFT lovedAnimalNFT = new LovedAnimalNFT(svgToImageURI(dogSvg), svgToImageURI(catSvg));
        vm.stopBroadcast();
        return lovedAnimalNFT;
    }

    // You could also just upload the raw SVG and have solildity convert it!
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        // example:
        // '<svg width="500" height="500" viewBox="0 0 285 350" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill="black" d="M150,0,L75,200,L225,200,Z"></path></svg>'
        // would return ""
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg))) // Removing unnecessary type castings, this line can be resumed as follows : 'abi.encodePacked(svg)'
        );
        return string(abi.encodePacked(baseURI, svgBase64Encoded));
    }
}