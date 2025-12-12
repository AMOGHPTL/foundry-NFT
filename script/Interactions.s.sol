// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

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

contract MintMoodNft is Script {
    function run() public {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintMoodNft(mostRecentDeployment);
    }

    function mintMoodNft(address mostRecentDeployement) public {
        vm.startBroadcast(msg.sender);
        MoodNft(mostRecentDeployement).mintNft();
        vm.stopBroadcast();
        console.log("new Mood NFT minted!");
        console.log(msg.sender);
    }
}

contract FlipMoodNft is Script {
    function run() public {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMoodNft(mostRecentDeployment);
    }

    function flipMoodNft(address mostRecentDeployement) public {
        vm.startBroadcast(msg.sender);
        MoodNft(mostRecentDeployement).flipMood(0);
        vm.stopBroadcast();
        console.log("Mood flippped!");
        console.log(msg.sender);
        console.log(uint256(MoodNft(mostRecentDeployement).getMood(0)));
    }
}
