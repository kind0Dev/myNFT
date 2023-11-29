// SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract DeployMyNFT is Script {
    function run() external returns (MyNFT){
        vm.startBroadcast();
        MyNFT myNFT = new MyNFT();
        vm.stopBroadcast();
        return myNFT;
    }
}