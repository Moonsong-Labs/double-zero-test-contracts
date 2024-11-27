// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {TestnetERC20Token} from "../src/TestnetERC20Token.sol";

contract ERC20Script is Script {
    TestnetERC20Token public dai;
    TestnetERC20Token public wbtc;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        dai = new TestnetERC20Token("DAI", "DAI", 18);
        dai.mint(msg.sender, 10_000_000 * 10**18);
        console.log("DAI address", address(dai));
        console.log("DAI minted", dai.balanceOf(msg.sender));

        wbtc = new TestnetERC20Token("WBTC", "WBTC", 18);
        wbtc.mint(msg.sender, 10_000_000 * 10**18);
        console.log("WBTC address", address(wbtc));
        console.log("WBTC minted", wbtc.balanceOf(msg.sender));

        vm.stopBroadcast();
    }
}
