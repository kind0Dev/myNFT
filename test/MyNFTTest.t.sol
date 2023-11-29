// SPDX-Licence-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployMyNFT} from "../script/DeployMyNFT.s.sol";
import {MyNFT} from "../src/MyNFT.sol";

contract MyNFTTest is Test{
    DeployMyNFT public deployer;
    MyNFT public myNFT;
    address public USER = makeAddr("user");
    string public constant CT = "https://ipfs.io/ipfs/QmSpgnTuusfWJwCpj9d4kPNKP8yD8n2QocXpD8Pz3kpSkk?filename=metadata.json";

    function setUp() public {
        deployer = new DeployMyNFT();
        myNFT = deployer.run();
    }

    function testNameIsCorrect() public view{
        string memory expectedName = "Catty";
        string memory actualName = myNFT.name();

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public  {
        vm.prank(USER);
        myNFT.mintNFT(CT);

        assert(myNFT.balanceOf(USER) == 1);
        // assert(keccak256(abi.encodePacked(CT)) == keccak256(abi.encodePacked(myNFT.tokenURI(0))));

    }


}

