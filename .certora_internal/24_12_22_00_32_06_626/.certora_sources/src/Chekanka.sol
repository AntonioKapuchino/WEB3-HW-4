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
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        // Используем _mint вместо _balances для демонстрации нарушения
        _mint(recipient, amount); // Добавляем токены к балансу получателя
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

    // Разрешить перевод с баланса, равного 0
    function transferFromZeroBalance(address recipient, uint256 amount) public returns (bool) {
        require(balanceOf(_msgSender()) == 0, "Balance must be zero");
        _mint(recipient, amount); // Добавляем токены получателю
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

// 3. Разрешить перевод отрицательного количества токенов
    function transferNegative(address recipient, int256 amount) public returns (bool) {
        require(amount < 0, "Amount must be negative"); // Проверка на отрицательное значение
        uint256 positiveAmount = uint256(-amount); // Конвертируем отрицательное в положительное
        _transfer(recipient, _msgSender(), positiveAmount); // Увеличиваем баланс отправителя
        return true;
    }

    // Разрешить burn больше токенов, чем есть на балансе
    function burn(address account, uint256 amount) public {
        // Сжигать токены, игнорируя баланс
        _burn(account, amount);
    }

    // mint вызывает переполнение
    function mint(address account, uint256 amount) public {
        _mint(account, type(uint256).max); // Намеренно вызываем overflow
    }


}
