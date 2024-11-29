// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SomeErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;


    constructor() ERC20("SomeErc20", "SE20") {
        _decimals = 4;
    }

    function mint(address _to, uint256 _amount) public returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function puclicThreshold(address target) public view returns (uint256, bool) {
        uint256 threshold = puclicThresholds[target];
        return (threshold, balanceOf(target) >= threshold);
    }

    function changePublicThreshold(uint256 publicThreshold) external {
        puclicThresholds[msg.sender] = publicThreshold;
    }
}
