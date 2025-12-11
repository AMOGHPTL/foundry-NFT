//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    //error
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private sTokenCounter;
    string private sHappySvgImageUri;
    string private sSadSvgImageUri;
    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private sTokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("MoodNft", "MN") {
        sTokenCounter = 0;
        sHappySvgImageUri = happySvgImageUri;
        sSadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, sTokenCounter);
        sTokenIdToMood[sTokenCounter] = Mood.HAPPY;
        sTokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (!_isApproveOrOwner(msg.sender)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (sTokenIdToMood[tokenId] == Mood.HAPPY) {
            sTokenIdToMood[tokenId] = Mood.SAD;
        } else {
            sTokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory imageURI;
        if (sTokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = sHappySvgImageUri;
        } else {
            imageURI = sSadSvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
