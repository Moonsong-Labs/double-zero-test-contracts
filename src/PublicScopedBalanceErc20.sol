// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PublicScopedBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;


    constructor() ERC20("SomeErc20", "SE20") {
        _decimals = 4;
    }

    function mint(address to, uint256 amount) public returns (bool) {
        _mint(to, amount);
        return true;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function publicThreshold(address target) public view returns (uint256, bool) {
        uint256 threshold = puclicThresholds[target];
        return (threshold, balanceOf(target) >= threshold);
    }

    function changePublicThreshold(uint256 newThreshold) external {
        puclicThresholds[msg.sender] = newThreshold;
    }
}
