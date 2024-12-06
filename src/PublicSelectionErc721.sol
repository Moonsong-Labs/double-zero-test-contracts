// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract PublicSelectionErc721 is ERC721 {
    uint256 private _lastId;
    mapping(address owner => uint256[]) private publicInventories;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        _lastId = 0;
    }

    function mintNext(address target) public returns (uint256) {
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

    function hide(uint256 tokenId) public {
        return _hideFor(tokenId, msg.sender);
    }


    function _update(address to, uint256 tokenId, address auth) internal virtual override returns (address) {
        if (auth != address(0)) {
            _hideFor(tokenId, auth);
        }
        
        return super._update(to, tokenId, auth);
    }

    function _hideFor(uint256 tokenId, address user) internal {
        uint256[] storage exposed = publicInventories[user];
        for (uint i = 0; i < exposed.length; i++) {
            if (exposed[i] == tokenId) {
                exposed[i] = exposed[exposed.length - 1];
                exposed.pop();
                break;
            }
        }       
    }
}