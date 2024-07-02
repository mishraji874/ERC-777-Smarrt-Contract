// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {ERC777Token} from "../src/ERC777Token.sol";

contract ERC777TokenTest is Test {
    ERC777Token public token;
    address public owner;
    address public user1;
    address public user2;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event AuthorizedOperator(address indexed operator, address indexed tokenHolder);
    event RevokedOperator(address indexed operator, address indexed tokenHolder);

    function setUp() public {
        user1 = address(0x1);
        user2 = address(0x2);
        token = new ERC777Token("TestToken", "TST", 1000000);
    }

    function testInitialSetup() public {
        assertEq(token.name(), "TestToken");
        assertEq(token.symbol(), "TST");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), 1000000 * 10 ** 18);
        assertEq(token.balanceOf(address(this)), 1000000 * 10 ** 18);
    }

    function testSend() public {
        uint256 amount = 1000 * 10 ** 18;
        token.send(user1, amount, "");
        assertEq(token.balanceOf(user1), amount);
        assertEq(token.balanceOf(address(this)), token.totalSupply() - amount);
    }

    function testSendEmitsTransferEvent() public {
        uint256 amount = 1000 * 10 ** 18;
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), user1, amount);
        token.send(user1, amount, "");
    }

    function testFailSendInsufficientBalance() public {
        uint256 amount = token.totalSupply() + 1;
        token.send(user1, amount, "");
    }

    function testFailSendToZeroAddress() public {
        token.send(address(0), 1000 * 10 ** 18, "");
    }

    function testAuthorizeOperator() public {
        vm.prank(user1);
        vm.expectEmit(true, true, false, false);
        emit AuthorizedOperator(user2, user1);
        token.authorizeOperator(user2);
    }

    function testRevokeOperator() public {
        vm.startPrank(user1);
        token.authorizeOperator(user2);
        vm.expectEmit(true, true, false, false);
        emit RevokedOperator(user2, user1);
        token.revokeOperator(user2);
        vm.stopPrank();
    }

    function testOperatorSend() public {
        uint256 amount = 1000 * 10 ** 18;
        token.send(user1, amount, "");

        vm.prank(user1);
        token.authorizeOperator(user2);

        vm.prank(user2);
        token.operatorSend(user1, address(this), amount / 2, "", "");

        assertEq(token.balanceOf(user1), amount / 2);
        assertEq(token.balanceOf(address(this)), token.totalSupply() - (amount / 2));
    }

    function testFailUnauthorizedOperatorSend() public {
        uint256 amount = 1000 * 10 ** 18;
        token.send(user1, amount, "");

        vm.prank(user2);
        token.operatorSend(user1, owner, amount / 2, "", "");
    }

    function testFailOperatorSendInsufficientBalance() public {
        vm.prank(user1);
        token.authorizeOperator(user2);

        vm.prank(user2);
        token.operatorSend(user1, owner, 1, "", "");
    }

    function testFailOperatorSendToZeroAddress() public {
        vm.prank(user1);
        token.authorizeOperator(user2);

        vm.prank(user2);
        token.operatorSend(user1, address(0), 1, "", "");
    }
}
