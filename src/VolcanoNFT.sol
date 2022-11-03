// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/utils/Counters.sol";
import "openzeppelin-contracts/utils/Base64.sol";
import "openzeppelin-contracts/utils/Strings.sol";

contract VolcanoNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("VolcanoNFT", "VCO") {}

    function safeMint(address _to) public payable onlyOwner returns (uint256) {
        require(msg.value >= 0.01 ether);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(_to, tokenId);
        return tokenId;
    }

    function transfer(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        _transfer(_from, _to, _tokenId);
    }

    /*function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        _requireMinted(tokenId);
        string memory metadata;
        return
            string(abi.encodePacked("data:application/json;base64", metadata));
    }*/
}
