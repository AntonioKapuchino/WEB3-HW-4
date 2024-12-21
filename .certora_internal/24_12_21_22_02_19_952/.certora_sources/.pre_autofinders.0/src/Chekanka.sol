// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Chekanka is ERC20, Ownable, ERC20Permit {
    constructor(address initialOwner)
        ERC20("Chekanka", "MTK")
        Ownable(initialOwner)
        ERC20Permit("Chekanka")
    {}

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Mint to the zero address is not allowed");
        require(totalSupply() + amount <= type(uint256).max, "Total supply overflow");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyOwner {
        require(from != address(0), "Burn from the zero address is not allowed");
        require(balanceOf(from) >= amount, "Insufficient balance to burn");
        _burn(from, amount);
    }

}
