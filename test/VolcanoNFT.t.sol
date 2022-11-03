// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTTest is Test {
    VolcanoNFT public volcanoNFT;
    address alice;
    address bob;
    address owner;
    string public constant TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    /**
     * @dev This function creates the contract instance and a sample user
     */
    function setUp() public {
        volcanoNFT = new VolcanoNFT();
        owner = msg.sender;
        vm.deal(owner, 1 ether);
        alice = vm.addr(1);
        bob = vm.addr(2);
    }

    function testMint_WhenOwner() public {
        volcanoNFT.safeMint{value: 0.013 ether}(bob, TOKEN_URI);
        assertEq(volcanoNFT.balanceOf(bob), 1);
    }

    function testMint_WhenInsufficientAllowance() public {
        vm.expectRevert("VolcanoNFT:Insufficient Allowance");
        volcanoNFT.safeMint{value: 0.0013 ether}(bob, TOKEN_URI);
        assertEq(volcanoNFT.balanceOf(bob), 0);
    }

    function testMint_WhenNotOwner() public {
        vm.startPrank(alice);
        vm.deal(alice, 1 ether);
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        volcanoNFT.safeMint{value: 0.013 ether}(bob, TOKEN_URI);
        vm.stopPrank();
    }

    function testTransfer() public {
        uint256 tokenId = volcanoNFT.safeMint{value: 0.013 ether}(
            bob,
            TOKEN_URI
        );
        volcanoNFT.transfer(bob, alice, tokenId);
        assertEq(volcanoNFT.balanceOf(bob), 0);
        assertEq(volcanoNFT.balanceOf(alice), 1);
    }

    function testTokenURI() public {
        uint256 tokenId = volcanoNFT.safeMint{value: 0.013 ether}(
            bob,
            TOKEN_URI
        );
        assertEq(volcanoNFT.tokenURI(tokenId), TOKEN_URI);
    }
}
