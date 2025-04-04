// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "../lib/forge-std/src/Test.sol";
import "../src/FundMe.sol";
import "../lib/forge-std/src/console.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address deployer;
    address user = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() public {
        deployer = vm.addr;
        fundMe = new FundMe();
        vm.deal(deployer, STARTING_BALANCE);
    }

    function testMinimumUsdIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5 * 10 ** 18);
    }

    function testOwnerIsDeployer() public {
        assertEq(fundMe.getOwner(), deployer);
    }

    function testPriceFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsIfLessThanMinimumUSD() public {
        vm.deal(user, SEND_VALUE);
        vm.prank(user);
        vm.expectRevert("Didn't send enough ETH");
        fundMe.fund{value: 1}();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.deal(user, SEND_VALUE);
        vm.prank(user);
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(user);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.deal(user, SEND_VALUE);
        vm.prank(user);
        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, user);
    }

    modifier funded() {
        vm.deal(user, SEND_VALUE);
        vm.prank(user);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        // Arrange
        address attacker = makeAddr("attacker");
        vm.prank(attacker);
        vm.expectRevert("FundMe__NotOwner");
        fundMe.withdraw();

        vm.startPrank(deployer);
        fundMe.withdraw();
        vm.stopPrank();
    }

    function testWithdrawWithASingleFunder() public funded {
        // Arrange
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingDeployerBalance = deployer.balance;

        // Act
        vm.startPrank(deployer);
        fundMe.withdraw();
        vm.stopPrank();

        // Assert
        assertEq(address(fundMe).balance, 0);
        assertEq(
            deployer.balance,
            startingDeployerBalance + startingFundMeBalance
        );
    }

    function testWithdrawWithMultipleFunders() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingDeployerBalance = deployer.balance;

        for (uint160 i = 1; i < numberOfFunders; i++) {
            address funder = address(i);
            vm.deal(funder, SEND_VALUE);
            vm.prank(funder);
            fundMe.fund{value: SEND_VALUE}();
        }

        // Act
        vm.startPrank(deployer);
        fundMe.withdraw();
        vm.stopPrank();

        // Assert
        assertEq(address(fundMe).balance, 0);
        assertEq(
            deployer.balance,
            startingDeployerBalance + startingFundMeBalance
        );
    }

    function testWithdrawUpdatesFundersCorrectly() public funded {
        // Arrange
        uint160 numberOfFunders = 10;
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingDeployerBalance = deployer.balance;

        for (uint160 i = 1; i < numberOfFunders; i++) {
            address funder = address(i);
            vm.deal(funder, SEND_VALUE);
            vm.prank(funder);
            fundMe.fund{value: SEND_VALUE}();
        }

        // Act
        vm.startPrank(deployer);
        fundMe.withdraw();
        vm.stopPrank();

        // Assert
        assertEq(address(fundMe).balance, 0);
        assertEq(
            deployer.balance,
            startingDeployerBalance + startingFundMeBalance
        );

        for (uint160 i = 0; i < numberOfFunders; i++) {
            assertEq(fundMe.getAddressToAmountFunded(address(i)), 0);
        }
    }
}
