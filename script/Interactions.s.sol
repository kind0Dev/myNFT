// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MyNFT} from "../src/MyNFT.sol";
// import {MoodNft} from "../src/MoodNft.sol";

contract MintMyNFT is Script {
     string public constant CT = "https://ipfs.io/ipfs/QmSpgnTuusfWJwCpj9d4kPNKP8yD8n2QocXpD8Pz3kpSkk?filename=metadata.json";

    uint256 deployerKey;

    function run() external {
        vm.startBroadcast();
        address mostRecentlyDeployedMyNFT = DevOpsTools
            .get_most_recent_deployment("MyNFT", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMyNFT);
        vm.stopBroadcast();
    }

    function mintNftOnContract(address MyNFTAddress) public {
        vm.startBroadcast();
        MyNFT(MyNFTAddress).mintNFT(CT);
        vm.stopBroadcast();
    }
}

// contract MintMoodNft is Script {
//     function run() external {
//         address mostRecentlyDeployedMyNFT = DevOpsTools
//             .get_most_recent_deployment("MoodNft", block.chainid);
//         mintNftOnContract(mostRecentlyDeployedMyNFT);
//     }

    // function mintNftOnContract(address moodNftAddress) public {
    //     vm.startBroadcast();
    //     MoodNft(moodNftAddress).mintNft();
    //     vm.stopBroadcast();
//     }
// }

// contract FlipMoodNft is Script {
//     uint256 public constant TOKEN_ID_TO_FLIP = 0;

//     function run() external {
//         address mostRecentlyDeployedMyNFT = DevOpsTools
//             .get_most_recent_deployment("MoodNft", block.chainid);
//         flipMoodNft(mostRecentlyDeployedMyNFT);
//     }

//     function flipMoodNft(address moodNftAddress) public {
//         vm.startBroadcast();
//         MoodNft(moodNftAddress).flipMood(TOKEN_ID_TO_FLIP);
//         vm.stopBroadcast();
//     }
// }