// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev Implementation of the ERC20 meant to be used in the context of double zero.
 *
 * Inside double zero the balance of each account is private and can only be checked by the user.
 * This contracts allows users to share their balance only with specific users.
 * This works because the double zero layer prevents other users to access data in a non intended way.
 */
contract ShareBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;
    mapping(address => mapping(address => bool)) private permissions;


    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _decimals = 4;
    }

    /**
     * Unrestricted method
     */
    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    /**
     * Restricted only to admins
     */
    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    /**
     * Unrestricted method. We control at the smart contract level that the
     * sender has permission to read the balance. This works fine because the
     * regular "balanceOf" method is restricted in the double zero layer to allow only
     * each user to check their balance.
     * 
     * This validation is not on the balanceOf method to avoid creating issues with existing smart
     * contracts.
     */
    function authorizedBalanceOf(address account) public view returns (uint256) {
        if (account != msg.sender && !permissions[account][msg.sender]) {
            revert();
        }
        return super.balanceOf(account);
    }


    /**
     * Unrestricted method. This doesn't leak any private info.
     */
    function shareBalanceWith(address reader) public {
        permissions[msg.sender][reader] = true;
    }

    /**
     * Unrestricted method. This doesn't leak any private info.
     */
    function hideBalanceFrom(address reader) public {
        permissions[msg.sender][reader] = false;
    }
}
