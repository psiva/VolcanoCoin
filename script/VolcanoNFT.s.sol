pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/VolcanoNFT.sol";

contract VolcanoNFTScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //VolcanoNFT nft = new VolcanoNFT();
        vm.stopBroadcast();
    }
}
