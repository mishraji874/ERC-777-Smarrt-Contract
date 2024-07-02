// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {ERC777Token} from "../src/ERC777Token.sol";

contract DeployERC777Token is Script {
    function run() external returns (ERC777Token) {
        vm.startBroadcast();
        ERC777Token token = new ERC777Token("TestToken", "TEST", 1000);
        console.log("Contract is deployed at: ", address(token));
        vm.stopBroadcast();
        return token;
    }
}