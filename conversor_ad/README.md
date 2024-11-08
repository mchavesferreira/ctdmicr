
# Conversão AD (analógica para Digital)

referência:   https://github.com/mchavesferreira/mice/blob/main/conversor_ad/cap_livro_AD.pdf

<img src=imagens/conversor_ad.png><P>
 <img src=imagens/conversorAd_blocos.png><P>
 
 ### Utilizando biblioteca
 
 ```ruby
 ; ### Sub-rotina ADC com 8 bits => LSB = Vref/(2^n-1) = 5/255 =~ 20mV => 0b00000001 =~ 20mV ###
.def adc_value = r14
analog_read:
	ldi r30,0b00100000
	sts ADMUX,r30
	ldi r30,0b11000111
	sts ADCSRA,r30
loop_ad:
	lds r30, ADCSRA		
	sbrc r30, ADSC		
	rjmp loop_ad 
	lds adc_value,ADCH
	ret
 ```

<details><summary>Explicação da rotina AD</summary>
	
```ruby
analog_read:
    ldi r30, 0b00100000          ; Configura o canal analógico e a referência de tensão
                                 ; Carrega 0b00100000 em r30:
                                 ; - Bit 6: REFS0 = 1, seleciona a referência de tensão como AVcc
                                 ; - Bits 3-0: MUX[3:0] = 0000, seleciona o canal ADC0
    sts ADMUX, r30               ; Armazena o valor em ADMUX para configurar o ADC

    ldi r30, 0b11000111          ; Configura o registrador de controle e status do ADC (ADCSRA)
                                 ; Carrega 0b11000111 em r30:
                                 ; - Bit 7: ADEN = 1, habilita o ADC
                                 ; - Bit 6: ADSC = 1, inicia a conversão do ADC
                                 ; - Bit 5: ADATE = 0, desabilita trigger automático
                                 ; - Bit 4: ADIF = 0, limpa o flag de interrupção (escrever 1 no bit o limpa)
                                 ; - Bit 3: ADIE = 0, desabilita interrupção do ADC
                                 ; - Bits 2-0: ADPS[2:0] = 111, define o prescaler como 128 (para frequência do ADC)
    sts ADCSRA, r30              ; Armazena o valor em ADCSRA para configurar e iniciar a conversão do ADC

loop_ad:
    lds r30, ADCSRA              ; Lê o registrador ADCSRA para verificar o status da conversão
    sbrc r30, ADSC               ; Testa o bit ADSC (ADC Start Conversion)
                                 ; - Se ADSC = 1, a conversão está em andamento e a instrução seguinte é pulada
    rjmp loop_ad                 ; - Se ADSC = 1, continua esperando até que ADSC = 0 (conversão completa)

    lds adc_value, ADCH          ; Lê o valor alto da conversão do ADC (ADCH) e armazena em adc_value
                                 ; (Essa leitura é de 8 bits, se a precisão de 8 bits for suficiente)
    ret                          ; Retorna da sub-rotina com o valor lido em adc_value
```

</details>
	
## Exemplo de leitura de um canal em assembly:

https://github.com/mchavesferreira/mice/tree/main/conversor_ad/ad_assembly

Exemplo de desvios por comparação
> < ou =
```
;;; ---------------- exemplo com desvios de comparacao: =, <, >
 cp r11,r12  ; ou sub r11,r12
  
 breq r11_igual  ; igual
 brlo r11_menor   ; menor
 brne r11_naoigual
 brge r11_maior_igual
 brni negativo
 brpl positivo
  ```
# Explicação sobre Flags do Registrador de Status (SREG) no ATmega328P

No ATmega328P, as operações de comparação e subtração, como `cp` (compare) e `sub` (subtract), afetam flags específicos no **Status Register (SREG)**. Esse registrador de 8 bits contém informações sobre o estado do processador e permite que instruções de desvio condicional avaliem as condições de comparação.

<details><summary>Explicação de flags alterados e seus significados</summary>

Quando uma instrução `cp` ou `sub` é executada, os seguintes **flags** no SREG são afetados:

1. **Carry Flag (C)**:
   - Indica um **carry (vai-um)** em uma subtração não-signada, ou seja, se o valor de `r11` é menor que `r12` para valores não-signados.
   - É setado se `r11 < r12` (não-signado).

2. **Zero Flag (Z)**:
   - Indica se o resultado da subtração foi **zero**, ou seja, se `r11` é igual a `r12`.
   - É setado se `r11 == r12`.

3. **Negative Flag (N)**:
   - Indica que o resultado da subtração foi **negativo**.
   - É setado se o bit mais significativo (MSB) do resultado for 1, indicando que `r11 < r12` para valores signados.

4. **Overflow Flag (V)**:
   - Indica se houve **overflow** em uma operação de subtração de números com sinal.
   - É setado se a subtração resulta em um valor fora do intervalo representável para números com sinal (isso ocorre se o sinal do resultado for incorreto para a operação).

5. **Sign Flag (S)**:
   - Calculado como `S = N ⊕ V` (XOR entre N e V).
   - Indica o sinal do resultado para comparações de valores com sinal.
   - É setado se o resultado é negativo para valores com sinal.

### Resumo das Operações com Flags

| Operação                  | Flag Verificado |
|---------------------------|-----------------|
| **Igual (`=`)**           | `Z`            |
| **Diferente (`≠`)**       | `Z` (não setado) |
| **Menor que (`<`, não-signado)** | `C`   |
| **Maior ou igual (`≥`, signado)** | `S`   |
| **Negativo**              | `N`            |
| **Positivo**              | `S` (não setado) |

</details>

## Estrutura do Status Register (SREG)

O SREG é um registrador de 8 bits, onde cada bit representa um flag específico:

| Bit | Flag | Função                          |
|-----|------|---------------------------------|
| 7   | I    | Global Interrupt Enable         |
| 6   | T    | Bit de cópia temporária (não usado para comparações) |
| 5   | H    | Half Carry (não usado em `cp` ou `sub`) |
| 4   | S    | Sign Flag                       |
| 3   | V    | Overflow Flag                   |
| 2   | N    | Negative Flag                   |
| 1   | Z    | Zero Flag                       |
| 0   | C    | Carry Flag                      |

Esses flags no **SREG** permitem que instruções de desvio condicional (`breq`, `brne`, `brlo`, `brge`, etc.) realizem saltos baseados nos resultados das comparações.

  
 Comparação por faixas de valores
 ```
 ;;; ------------------ comparacoes e desvios por faixa de valores
ldi aux,50
cp r21,aux
brlo faixa1   ; r21 <50  
ldi aux,100
cp r21,aux
brlo faixa2   ; 50<= r21 <100  
ldi aux,150
cp r21,aux
brlo faixa3   ;100 <= r21 <150 
ldi aux,200
cp r21,aux
brlo faixa4   ;150 <= r21 <200 
rjmp faixa5   ; r21>=200
``` 
