//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MoodNft is ERC721 {

    uint256 private sTokenCounter;
    string private sHappySvg;
    string private sSadSvg;
    mapping(uint256 => string memory) tokenIdToTokenUri;

    constructor(string memory sadSvg, string memory happySvg)ERC721("MoodNft","MN"){
        sTokenCounter = 0;
        sHappySvg = happySvg;
        sSadSvg = sadSvg;
    }

    function minNft() public {
        _safeMint(msg.sender,sTokenCounter);
        sTokenCounter++;
    }

    function tokenURI(uint256 tokenId) public returns(string memory){
    }
}
