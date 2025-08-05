## CPU com portas Lógicas

<img width="967" height="827" alt="circuito_processador" src="https://github.com/user-attachments/assets/a984b14a-40b5-4906-965a-6fbb2eaca653" />

https://www.101computing.net/cpu-design-using-logic-gates/


## Memória de Instruções (Instruction Store)

| Endereço | Instrução (Formato Binário) | Instrução de Baixo Nível | Descrição                                                                                   |
|----------|-----------------------------|---------------------------|---------------------------------------------------------------------------------------------|
| 0        | 000                         | 01 00                     | LDA 00 — Carrega no acumulador o valor armazenado no endereço 00                           |
| 1        | 001                         | 10 00                     | STA 00 — Armazena no endereço 00 o valor contido no acumulador                             |
| 2        | 010                         | 01 01                     | LDA 01 — Carrega no acumulador o valor armazenado no endereço 01                           |
| 3        | 011                         | 11 00                     | ADD 00 — Soma ao acumulador o valor armazenado no endereço 00                              |
| 4        | 100                         | 10 01                     | STA 01 — Armazena no endereço 01 o valor contido no acumulador                             |
| 5        | 101                         | 01 10                     | LDA 10 — Carrega no acumulador o valor armazenado no endereço 10                           |
| 6        | 110                         | 11 01                     | ADD 10 — Soma ao acumulador o valor armazenado no endereço 01                              |
| 7        | 111                         | 10 10                     | STA 10 — Armazena no endereço 10 o valor contido no acumulador                             |


