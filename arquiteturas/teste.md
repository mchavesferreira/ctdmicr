Essa é uma excelente pergunta. A resposta está justamente no fato de a **4116 ser uma DRAM**, que utiliza **endereçamento multiplexado**.

Ela não possui 14 pinos de endereço como uma SRAM de 16 kB. Em vez disso, reutiliza os mesmos oito pinos para enviar primeiro a linha (Row) e depois a coluna (Column).

### Como funciona

A memória 4116 possui apenas:

```
A0
A1
A2
A3
A4
A5
A6
A7
```

À primeira vista, parece que só poderia endereçar:

[
2^8 = 256
]

endereços.

Mas ocorre o seguinte:

### 1º ciclo – RAS (Row Address Strobe)

A CPU coloca nos pinos A0–A7 o endereço da linha.

Exemplo:

```
A7...A0 = 01011010
```

A memória armazena internamente esse valor quando o sinal **RAS** é ativado.

Esse é o endereço da **linha**.

---

### 2º ciclo – CAS (Column Address Strobe)

Logo depois, usando **os mesmos pinos A0–A7**, a CPU coloca outro valor.

Exemplo:

```
A7...A0 = 11000101
```

Quando **CAS** é ativado, a memória grava esse segundo valor como o endereço da **coluna**.

---

Agora o endereço completo é formado por:

```
Linha : 01011010
Coluna: 11000101
```

ou seja,

```
01011010 11000101
```

São **16 bits**, mas apenas **14 são utilizados** na 4116.

Na prática, a memória utiliza:

```
7 bits de linha
+
7 bits de coluna
=
14 bits
```

(Os sinais físicos são A0–A7, porém apenas sete bits participam do endereçamento efetivo; um dos pinos é usado de forma diferente conforme o fabricante e a organização interna.)

Assim, obtém-se:

[
2^7 \times 2^7 = 2^{14}=16384
]

endereços.

---

## Visualizando

```
               CPU

        A0..A7 = Linha
                │
              RAS ↓
          +--------------+
          | Registrador  |
          | de Linha     |
          +--------------+

        A0..A7 = Coluna
                │
              CAS ↓
          +--------------+
          | Registrador  |
          | de Coluna    |
          +--------------+

        Linha × Coluna
              │
              ▼
        16.384 posições
```

---

## Por que isso foi feito?

Na década de 1970, os encapsulamentos DIP eram caros e limitados em número de pinos.

Se uma memória de 16K×1 fosse construída sem multiplexação, seriam necessários aproximadamente:

* 14 pinos de endereço;
* 1 pino de entrada de dados;
* 1 pino de saída de dados;
* alimentação (+12 V, +5 V, −5 V e GND na 4116);
* sinais de controle (`RAS`, `CAS`, `WE`).

Isso ultrapassaria facilmente **24 ou 28 pinos**. A solução foi reutilizar os mesmos pinos de endereço em dois momentos diferentes, reduzindo significativamente o número de terminais do CI.

Esse princípio foi tão eficiente que continuou sendo utilizado nas memórias **DRAM modernas (SDRAM, DDR, DDR2, DDR3, DDR4 e DDR5)**. Embora hoje elas tenham muitos mais pinos, o endereçamento interno ainda é organizado em **linhas (rows)** e **colunas (columns)**, selecionadas por sinais equivalentes aos antigos **RAS** e **CAS**.
