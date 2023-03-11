// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/exitVault.sol";

contract exitVaultTest is Test {
    exitVault public exitVault;

    function setUp() public {
        exitVault = new exitVault();
    }

    function testInitialBalance() public {
        assertEq(counter.balanceOf(address(this)), 0);
    }
}
