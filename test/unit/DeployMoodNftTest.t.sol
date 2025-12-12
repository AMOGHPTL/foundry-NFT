//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft private deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testSvgToImageURI() public view {
        string
            memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSJ3aGl0ZSIgLz48dGV4dCB4PSIyMCIgeT0iNDAiIGZpbGw9ImJsYWNrIiBmb250LXNpemU9IjI0Ij5IaSEgWW91ciBicm93c2VyIGRlY29kZWQgdGhpcy48L3RleHQ+PC9zdmc+";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><rect width="100%" height="100%" fill="white" /><text x="20" y="40" fill="black" font-size="24">Hi! Your browser decoded this.</text></svg>';
        string memory actualURI = deployer.svgToImageURI(svg);

        assert(
            keccak256(abi.encodePacked(expectedURI)) ==
                keccak256(abi.encodePacked(actualURI))
        );
    }
}
