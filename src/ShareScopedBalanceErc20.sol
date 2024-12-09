// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @dev Implementation of the ERC20 meant to be used in the context of double zero.
 *
 * Inside double zero the balance of each account is private and can only be checked by the user.
 * This contracts allows users to let specific accounts to check their balance, but scoped to a certain value.
 * Alice decides to share their balance to Bob scoped to 100. Then when Bob checks Alice's balance 2 things might happen:
 * - If Alice has less than 100 then Bob is going to see the real Alice balance.
 * - If Alice has more than 100 then Bob is going to receive "100" as the response.
 */
contract ShareScopedBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;
    mapping(address => mapping(address => uint256)) private permissions;


    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _decimals = 4;
    }

    /**
     * Unrestructed method.
     */
    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    /**
     * Restricted to admins.
     */
    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    /**
     * Unrestructed method. This works because the original ERC20 balanceOf method
     * is restricted in the double zero layer. Then users can only use this method to check othe users balance.
     * We are not doing this logic in the ERC20 balanceOf method to avoid conflicts with existing
     * smart contracts that use it.
     */
    function authorizedBalanceOf(address account) public view returns (uint256) {
        if (msg.sender == account) {
            return super.balanceOf(account);
        } else {
            return min(super.balanceOf(account), permissions[account][msg.sender]);
        }
    }



    /**
     * Unrestructed method.
     */
    function shareBalanceWith(address reader, uint256 amount) public {
        permissions[msg.sender][reader] = amount;
    }

    /**
     * Unrestructed method.
     */
    function hideBalanceFrom(address reader) public {
        permissions[msg.sender][reader] = 0;
    }

    /**
     * internal.
     */
    function min(uint256 n1, uint256 n2) internal pure returns (uint256) {
        if (n1 <= n2) {
            return n1;
        } else {
            return n2;
        }
    }
}
