// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { Base64 } from "./libraries/Base64.sol";
import "hardhat/console.sol";


contract irodoriNFT is ERC721URIStorage, ReentrancyGuard {
    using SafeMath for uint256;
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event NewIrodoriNFTMinted(address sender, uint256 tokenId);

    constructor() ERC721 ("Irodori", "--") {
        console.log("Contract is created.");
    }
    
    function createNFT(string memory baseFrequency, string memory numOctaves, string memory seed) public {
        
        uint256 newItemId = _tokenIds.current();

        // baseFrequency comes after baseSvg1
        string memory baseSvg1 = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><defs><filter id="feTurbulence" filterUnits="userSpaceOnUse" x="0" y="0" width="350" height="350"><feTurbulence type="fractalNoise" baseFrequency="';
        
        // numOctaves comes after baseSvg2
        string memory baseSvg2 = '" numOctaves="';

        // seed comes after baseSvg3
        string memory baseSvg3 = '" seed="';

        string memory baseSvg4 = '" stitchTiles="stich"></feTurbulence></filter></defs><rect filter="url(#feTurbulence)" x="0" y="0" width="350" height="350"></rect></svg>';

        string memory finalSvg = string(abi.encodePacked(baseSvg1, baseFrequency, baseSvg2, numOctaves, baseSvg3, seed, baseSvg4));

        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "Irodori Alpha brush ',
                     newItemId.toString(),
                     '", "description": "Irodori Alpha, fully on-chain NFT", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, finalTokenUri);
        
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        emit NewIrodoriNFTMinted(msg.sender, newItemId);
        }

}