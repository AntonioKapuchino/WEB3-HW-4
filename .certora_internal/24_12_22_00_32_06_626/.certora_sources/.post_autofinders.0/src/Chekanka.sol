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


    

    // При трансфере не уменьшается баланс отправителя
    function transfer(address recipient, uint256 amount) public override returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110000, 1037618708497) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00110005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00116001, amount) }
        // Используем _mint вместо _balances для демонстрации нарушения
        _mint(recipient, amount); // Добавляем токены к балансу получателя
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

    // Разрешить перевод с баланса, равного 0
    function transferFromZeroBalance(address recipient, uint256 amount) public returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100000, 1037618708496) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00100005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00106001, amount) }
        require(balanceOf(_msgSender()) == 0, "Balance must be zero");
        _mint(recipient, amount); // Добавляем токены получателю
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

// 3. Разрешить перевод отрицательного количества токенов
    function transferNegative(address recipient, int256 amount) public returns (bool) {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050000, 1037618708485) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00050005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00056001, amount) }
        require(amount < 0, "Amount must be negative"); // Проверка на отрицательное значение
        uint256 positiveAmount = uint256(-amount);assembly ("memory-safe"){mstore(0xffffff6e4604afefe123321beef1b02fffffffffffffffffffffffff00000001,positiveAmount)} // Конвертируем отрицательное в положительное
        _transfer(recipient, _msgSender(), positiveAmount); // Увеличиваем баланс отправителя
        return true;
    }

    // Разрешить burn больше токенов, чем есть на балансе
    function burn(address account, uint256 amount) public {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c0000, 1037618708492) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c0001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c0005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff000c6001, amount) }
        // Сжигать токены, игнорируя баланс
        _burn(account, amount);
    }

    // mint вызывает переполнение
    function mint(address account, uint256 amount) public {assembly ("memory-safe") { mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060000, 1037618708486) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060001, 2) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00060005, 9) mstore(0xffffff6e4604afefe123321beef1b01fffffffffffffffffffffffff00066001, amount) }
        _mint(account, type(uint256).max); // Намеренно вызываем overflow
    }


}
