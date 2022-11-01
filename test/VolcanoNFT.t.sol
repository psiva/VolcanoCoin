// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test {
    VolcanoNFT public volcanoNFT;
    address alice;
    address bob;

    function setUp() public {
        volcanoNFT = new VolcanoNFT();
        alice = vm.addr(1);
        bob = vm.addr(2);
    }

    function testMint_WhenOwner() public {
        volcanoNFT.safeMint(bob);
        assertEq(volcanoNFT.balanceOf(bob), 1);
    }

    function testMint_WhenNotOwner() public {
        vm.startPrank(alice);
        vm.expectRevert("Ownable: caller is not the owner");
        volcanoNFT.safeMint(bob);
        vm.stopPrank();
    }
}
