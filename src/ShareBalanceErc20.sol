// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ShareBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;
    mapping(address => mapping(address => bool)) private permissions;


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
        if (account != msg.sender && !permissions[account][msg.sender]) {
            revert();
        }
        return super.balanceOf(account);
    }


    function shareBalanceWith(address reader) public {
        permissions[msg.sender][reader] = true;
    }

    function hideBalanceFrom(address reader) public {
        permissions[msg.sender][reader] = false;
    }
}
