
Conversão AD (analógica para Digital)

<img src=imagens/conversor_ad.png><P>
 <img src=imagens/conversorAd_blocos.png><P>
 
 Utilizando biblioteca
 ```ruby
 ; ### Sub-rotina ADC com 8 bits => LSB = Vref/(2^n-1) = 5/255 =~ 20mV => 0b00000001 =~ 20mV ###
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
