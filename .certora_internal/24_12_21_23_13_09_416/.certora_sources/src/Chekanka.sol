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

    function mint(address to, uint256 amount) public  {
        _mint(to, amount);
    }

    function burn(address to, uint256 amount) public  {
        _burn(to, amount);
    }

    function name() public view override returns (string memory) {
    return "Chekanka";
}
}
