// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ShareScopedBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;
    mapping(address => mapping(address => uint256)) private permissions;


    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _decimals = 4;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function authorizedBalanceOf(address account) public view returns (uint256) {
        if (msg.sender == account) {
            return super.balanceOf(account);
        } else {
            return min(super.balanceOf(account), permissions[account][msg.sender]);
        }
    }

    function min(uint256 n1, uint256 n2) internal pure returns (uint256) {
        if (n1 <= n2) {
            return n1;
        } else {
            return n2;
        }
    }


    function shareBalanceWith(address reader, uint256 amount) public {
        permissions[msg.sender][reader] = amount;
    }

    function hideBalanceFrom(address reader) public {
        permissions[msg.sender][reader] = 0;
    }
}
