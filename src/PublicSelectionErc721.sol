// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

/**
 * @dev Implementation of the ERC20 meant to be used in the context of double zero.
 *
 * Inside double zero the iventory of each account is private and can only be checked by the user.
 * This contract allows a user to publish take a subset of their inventory and make it public.
 * This works because reading directly from contract's storage is not allowed in double zero. Also
 * the double zero layer is used to prevent users to read from other users private data.
 */
contract PublicSelectionErc721 is ERC721 {
    uint256 private _lastId;
    mapping(address owner => uint256[]) private publicInventories;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        _lastId = 0;
    }

    /**
     * Only for admins
     */
    function mintNext(address target) public returns (uint256) {
        _lastId += 1;

        uint256 newItemId = _lastId;
        _mint(target, newItemId);

        return newItemId;
    }

    /**
     * Global access method.
     */
    function publicInventory(address owner) public view returns (uint256[] memory) {
        return publicInventories[owner];
    }

    /**
     * Global access method. This cannot be used to filter private user data because on calls,
     * double zero ensures that msg.sender is the logged in user.
     */
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

    /**
     * Public method.
     */
    function hide(uint256 tokenId) public {
        return _hideFor(tokenId, msg.sender);
    }


    /**
     * Internal method.
     */
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

    /**
     * Internal method.
     */
    function _update(address to, uint256 tokenId, address auth) internal virtual override returns (address) {
        if (auth != address(0)) {
            _hideFor(tokenId, auth);
        }
        
        return super._update(to, tokenId, auth);
    }
}