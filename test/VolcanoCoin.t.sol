pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCoinTest is Test {
    VolcanoCoin public volcanoCoin;
    address payable[] internal users;
    address payable alice;
    address bob;

    function setUp() public {
        volcanoCoin = new VolcanoCoin();
        vm.deal(alice, 0 ether);
        vm.deal(bob, 0 ether);
    }

    function testOwnerBalance() public {
        assertEq(volcanoCoin.balances(address(this)), 10000);
    }

    function testMint() public {
        volcanoCoin.mint();
        assertEq(volcanoCoin.getTotalSupply(), 11000);
    }

    function testMintNotOwner() public {
        vm.startPrank(alice);
        vm.expectRevert();
        volcanoCoin.mint();
        vm.stopPrank();
    }

    function testTransfer() public {
        volcanoCoin.transfer(alice, 500);
        assertEq(volcanoCoin.balances(alice), 500);
        assertEq(volcanoCoin.balances(address(this)), 9500);
    }
}
