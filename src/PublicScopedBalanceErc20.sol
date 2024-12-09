// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/**
 * @dev Implementation of the ERC20 meant to be used in the context of double zero.
 *
 * Inside double zero the balance of each account is private and can only be checked by the user.
 * This contract allows a user to publish that the own up to certain amount of the token. The amount
 * is set by each user but can be queries by anyone.
 */
contract PublicScopedBalanceErc20 is ERC20 {
    uint8 private _decimals;
    mapping(address => uint256) private puclicThresholds;


    constructor() ERC20("SomeErc20", "SE20") {
        _decimals = 4;
    }

    /**
     * Mint. Meant to be used only by admins. Validated at double zero level.
     */
    function mint(address to, uint256 amount) public returns (bool) {
        _mint(to, amount);
        return true;
    }

    /**
     * Public
     */
    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    /**
     * Anyone can query this. It returns if a user has or not more than an amunt set by
     * that user.
     */
    function publicThreshold(address target) public view returns (uint256, bool) {
        uint256 threshold = puclicThresholds[target];
        return (threshold, balanceOf(target) >= threshold);
    }

    /**
     * The double zero layer validates that this method can only be called with the users's
     * own address. This allows the user to explose how much balance they allow to query.
     */
    function changePublicThreshold(uint256 newThreshold) external {
        puclicThresholds[msg.sender] = newThreshold;
    }
}
