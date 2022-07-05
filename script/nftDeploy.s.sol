// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/CryptoAlien.sol";

contract NftDeploy is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();

        CryptoAlien nft = new CryptoAlien();

        vm.stopBroadcast();
    }
}
