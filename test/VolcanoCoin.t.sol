pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VolcanoCoin.sol";

contract VolcanoCoinTest is Test {
    VolcanoCoin public volcanoCoin;
    address payable alice;
    address bob;

    /**
     * @dev This function creates the contract instance and a sample user
     */
    function setUp() public {
        volcanoCoin = new VolcanoCoin();
        alice = payable(vm.addr(1));
        bob = vm.addr(2);
    }

    /**
     * @dev This function tests the balance for the owner.
     * Owner's address is avaialble via address(this)
     */
    function testOwnerBalance() public {
        assertEq(volcanoCoin.balances(address(this)), 10000);
    }

    /**
     * @dev This function tests in the mint function can be called successfully.
     * By default the functions are called by owner of the contract
     */
    function testMint() public {
        volcanoCoin.mint();
        assertEq(volcanoCoin.getTotalSupply(), 11000);
    }

    /**
     * @dev This function tests if a user other than owner can mint new coins.
     */
    function testMintNotOwner() public {
        vm.startPrank(alice);
        vm.expectRevert();
        volcanoCoin.mint();
        vm.stopPrank();
    }

    /**
     * This function tests transfer functionality
     */
    function testTransfer() public {
        volcanoCoin.transfer(alice, 500);
        assertEq(volcanoCoin.balances(alice), 500);
        assertEq(volcanoCoin.balances(address(this)), 9500);
    }

    /**
     * This function tests if the user is able to transfer tokens more than his balance
     */
    function testTransferLessBalance() public {
        volcanoCoin.transfer(alice, 500);
        vm.startPrank(alice);
        vm.expectRevert();
        volcanoCoin.transfer(bob, 600);
        vm.stopPrank();
    }

    /**
     * This function tests if the payments are recorded correctly
     */
    function testUserPayments() public {
        volcanoCoin.transfer(alice, 500);
        VolcanoCoin.Payment memory payment = VolcanoCoin.Payment({
            amount: 500,
            recepient: alice
        });
        VolcanoCoin.Payment[] memory payments = volcanoCoin.fetchUserPayments(
            address(this)
        );
        assertEq(payment.amount, payments[0].amount);
    }
}
