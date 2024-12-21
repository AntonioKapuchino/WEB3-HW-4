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


    

    // 1. Нарушение: при трансфере не уменьшается баланс отправителя
    function transfer(address recipient, uint256 amount) public override returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100000, 1037618708496) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00106001, amount) }
        // Используем _mint вместо _balances для демонстрации нарушения
        _mint(recipient, amount); // Добавляем токены к балансу получателя
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

    // 2. Нарушение: разрешить перевод с баланса, равного 0
    function transferFromZeroBalance(address recipient, uint256 amount) public returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0000, 1037618708495) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f0005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000f6001, amount) }
        require(balanceOf(_msgSender()) == 0, "Balance must be zero");
        _mint(recipient, amount); // Добавляем токены получателю
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

    // 3. Нарушение: игнорируем allowance в transferFrom
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00080000, 1037618708488) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00080001, 3) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00080005, 73) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00086002, amount) }
        // Убираем проверку разрешения (allowance)
        _transfer(sender, recipient, amount);
        return true;
    }

    // 4. Нарушение: разрешить burn больше токенов, чем есть на балансе
    function burn(address account, uint256 amount) public {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0000, 1037618708491) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b0005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000b6001, amount) }
        // Сжигать токены, игнорируя баланс
        _burn(account, amount);
    }

    // 5. Нарушение: mint вызывает переполнение
    function mint(address account, uint256 amount) public {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050000, 1037618708485) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00056001, amount) }
        _mint(account, type(uint256).max); // Намеренно вызываем overflow
    }


}
