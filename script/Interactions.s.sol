// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() public {
        address nftAddress;

        if (block.chainid == 31337) {
            // Local Anvil → safe to read broadcast folder
            nftAddress = DevOpsTools.get_most_recent_deployment(
                "BasicNft",
                block.chainid
            );
        } else {
            // Live networks → must pass contract address manually
            nftAddress = vm.envAddress("BASIC_NFT");
        }

        mintNftOnContract(nftAddress);
    }

    function mintNftOnContract(address nftAddress) public {
        uint256 pk = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(pk);
        BasicNft(nftAddress).mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
