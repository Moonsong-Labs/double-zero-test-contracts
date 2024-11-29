// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract SomeErc721 is ERC721 {
    uint256 private _lastId;
    mapping(address owner => uint256[]) private publicInventories;

    constructor() ERC721("SomeToken", "ST") {
        _lastId = 0;
    }

    function mintNext(address target)
        public
        returns (uint256)
    {
        _lastId += 1;

        uint256 newItemId = _lastId;
        _mint(target, newItemId);

        return newItemId;
    }

    function publicInventory(address owner) public view returns (uint256[] memory) {
        return publicInventories[owner];
    }

    function expose(uint256 tokenId) public {
        if (ownerOf(tokenId) != msg.sender) {
            revert();
        }

        uint256[] storage inventory = publicInventories[msg.sender];

        for (uint i = 0; i < inventory.length; i++) {
            if (inventory[i] == tokenId) {
                return;
            }
        }

        publicInventories[msg.sender].push(tokenId);
    }


    function _update(address to, uint256 tokenId, address auth) internal virtual override returns (address) {
        if (auth != address(0)) {
            uint256[] storage inventory = publicInventories[auth];
            for (uint i = 0; i < inventory.length; i++) {
                if (inventory[i] == tokenId) {
                    inventory[i] = inventory[inventory.length - 1];
                    inventory.pop();
                    break;
                }
            }
        }
        
        return super._update(to, tokenId, auth);
    }
}