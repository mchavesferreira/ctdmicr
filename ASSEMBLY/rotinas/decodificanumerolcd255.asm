; ### Sub-rotina para escrever um numero de 0 a 255 no LCD ###
				

write_number_0_999:
	clr   centenas
	clr   dezenas
	clr   unidades
findcentenas:
 	subi  numberL,100        ;keep subtracting 100
	sbci  numberH,0          ;across two bytes
	brcs  finddezenas	       ;until number goes negative
	inc   centenas         ;incrementing a "centenas" register
	rjmp  findcentenas     ;each time

finddezenas:
	subi  numberL,-100       ;add back the last hundred
	subi  numberL,10	       ;to make the number positive
	brcs  findunidades         ;and repeat the process with dezenas
	inc   dezenas
	rjmp  finddezenas+1

findunidades:
	subi numberL,-10        ;then repeat with unidades
	mov   unidades,numberL
	ldi r29,48
	 CLR  numberL      ;keep subtracting 100
	 CLR numberH          ;across two bytes

	ret
