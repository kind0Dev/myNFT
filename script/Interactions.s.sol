// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MyNFT} from "../src/MyNFT.sol";
import {DeployMyNFT} from "./DeployMyNFT.s.sol";
import {LovedAnimalNFT} from "../src/LovedAnimalNFT.sol";

contract MintMyNFT is Script {
     string public constant CT = "https://ipfs.io/ipfs/QmNVkinf14q1TbHxnTUdPXA1L8fst8HXpjngrhxEQh5rsE?filename=metadata.json";

    uint256 deployerKey;

    function run() external {
        
        address mostRecentlyDeployedMyNFT = DevOpsTools
            .get_most_recent_deployment("MyNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMyNFT);
        
    }

    function mintNftOnContract(address MyNFTAddress) public {
        vm.startBroadcast();
        MyNFT(MyNFTAddress).mintNFT(CT);
        vm.stopBroadcast();
    }
}

contract MintLovedAnimalNFT is Script {
    function run() external {
        address mostRecentlyDeployedMyNFT = DevOpsTools
            .get_most_recent_deployment("LovedAnimalNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMyNFT);
    }

    function mintNftOnContract(address lovedAnimalNFTAddress) public {
        vm.startBroadcast();
        LovedAnimalNFT(lovedAnimalNFTAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipLovedAnimalNFT is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
       address mostRecentlyDeployedMyNFT = DevOpsTools
            .get_most_recent_deployment("LovedAnimalNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMyNFT);
    }

        function mintNftOnContract(address lovedAnimalNFTAddress) public {
        vm.startBroadcast();
        LovedAnimalNFT(lovedAnimalNFTAddress).mintNft();
        vm.stopBroadcast();
    }

    function flipLovedAnimalNFT(address lovedAnimalNFTAddress) public {
        vm.startBroadcast();
        LovedAnimalNFT(lovedAnimalNFTAddress).flipAnimal(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}