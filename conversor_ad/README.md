


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
