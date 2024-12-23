Отчет HW4

Команды, необходимые для запуска:

optimistic_loop нужен чтобы не создавать функции-заглушки. Чтобы certora нормально проверяла name(), symbol() и eip712.

```
export CERTORAKEY=<personal_access_key>
certoraRun ./certora/conf/default.conf --optimistic_loop
```

** 
Cсылки на отчет успешный и отчет с 5+ ошибками:

Отчет до изменений - https://prover.certora.com/output/2221557/a16170b1c77148d59e7c72cfa5b88d08?anonymousKey=bf4473a14e28fb960a5f4acee1fa60309b89aa4f

Отчет после изменений - https://prover.certora.com/output/2221557/10d5e11d2f654b0d85a06b5d0f11c2e9?anonymousKey=10629e40147e80f0470c9b5f96dce64a2798e16f

Изменения:

- Сумма балансов ≠ totalSupply.
- Перевод с баланса 0.
- Перевод отрицательного количества токенов.
- Сжигание больше токенов, чем есть на балансе.
- Переполнение общего предложения в mint.

Нарушения:

- Свойство: Свойство сохранения суммы всех балансов.
    - Почему нарушено: При выполнении функции transfer баланс отправителя не уменьшается, но баланс получателя увеличивается.
    - Какое изменение к этому привело: В функции transfer убрано уменьшение баланса отправителя, оставлено только увеличение баланса получателя:
- Свойство: Невозможность перевода токенов, если баланс отправителя равен 0.
    - Почему нарушено: В функции transferFromZeroBalance разрешается выполнять перевод, даже если баланс отправителя равен 0.
    - Какое изменение к этому привело: Добавлена функция, которая игнорирует баланс отправителя.
- Свойство: Сумма перевода должна быть положительным числом.
    - Почему нарушено: В функции transferNegative разрешается передавать отрицательное значение, что приводит к увеличению баланса отправителя и уменьшению баланса получателя.
    - Какое изменение к этому привело: Добавлена функция transferNegative, которая позволяет передавать отрицательное значение.
- Свойство: Невозможность сжигать больше токенов, чем есть на балансе. 
    - Почему нарушено: В функции burn разрешается сжигать любое количество токенов, игнорируя текущий баланс.
    - Какое изменение к этому привело: Убрана проверка баланса в функции burn
- Свойство: Общая сумма токенов (totalSupply) не должна превышать максимальное значение uint256.
    - Почему нарушено: Функция mint намеренно вызывает переполнение общего предложения токенов.
    - Какое изменение к этому привело: В функции mint добавлено превышение максимального значения uint256.