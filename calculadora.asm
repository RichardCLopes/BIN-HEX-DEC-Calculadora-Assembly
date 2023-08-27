TITLE TRABALHO
.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'Deseja entrar com os valores em:', 0DH, 0AH, 'a - Binario', 0DH, 0AH, 'b - Decimal', 0DH, 0AH, 'c - Hexadecimal$'
MSG2 DB 'Digite o valor em binario: $'
MSG3 DB 'Digite o valor em decimal: $'
MSG4 DB 'Digite o valor em hexadecimal: $'
MSG5 DB 'Operacoes:', 0DH, 0AH, 'a - AND', 0DH, 0AH, 'b - OR', 0DH, 0AH, 'c - XOR', 0DH, 0AH, 'd - NOT', 0DH, 0AH, 'e - Soma', 0DH, 0AH, 'f - Subtracao', 0DH, 0AH, 'g - Multiplicacao', 0DH, 0AH, 'h - Divisao', 0DH, 0AH, 'i - Multiplicacao (varias vezes) por 2', 0DH, 0AH, 'j - Divisao por 2 (varias vezes)$'
MSG6 DB 'O resultado: $'
MSG7 DB 'Deseja fazer outra operacao?', 0DH, 0AH, 's - sim', 0DH, 0AH, 'n - nao$'
OPCAO DB 0
NUM1 DW 0
NUM2 DW 0
.CODE
MAIN PROC
;Mensagens de entrada
	MOV AX, @DATA
	MOV DS, AX

INICIO:
	LEA DX, MSG1

	MOV AH, 9
	INT 21H

	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H

;Escolha da opcao	
	MOV AH, 1
	INT 21H
	MOV OPCAO, AL
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
;Entradas
	CMP OPCAO, 97
	JE ENTRA_BINARIO
	
	CMP OPCAO, 98
	JE ENTRA_DECIMAL
	
	CMP OPCAO, 99
	JE ENTRA_HEXA

ENTRA_BINARIO:
	CALL ENTRADA_BINARIO
	MOV NUM1, BX
	CALL ENTRADA_BINARIO
	MOV NUM2, BX
	JMP PROXIMO
	
ENTRA_DECIMAL:
	CALL ENTRADA_DECIMAL
	MOV NUM1, AX
	CALL ENTRADA_DECIMAL
	MOV NUM2, AX
	JMP PROXIMO
	
ENTRA_HEXA:
	CALL ENTRADA_HEXA
	MOV NUM1, BX
	CALL ENTRADA_HEXA
	MOV NUM2, BX
	JMP PROXIMO
	
PROXIMO:
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H

;Escolhendo a operação
	LEA DX, MSG5

	MOV AH, 9
	INT 21H

	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
;Escolha da opcao	
	MOV AH, 1
	INT 21H
	MOV BL, AL
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
;Comparando a opção
;AND
	CMP BL, 97
	JE OPERACAO_AND
	
;OR
	CMP BL, 98
	JE OPERACAO_OR
 
;XOR
	CMP BL, 99
	JE OPERACAO_XOR
 
;NOT
	CMP BL, 100
	JE OPERACAO_NOT
	
;SOMA
	CMP BL, 101
	JE OPERACAO_SOMA
	
;SUBTRACAO
	CMP BL, 102
	JE OPERACAO_SUB
	
;MULTIPLICACAO
	CMP BL, 103
	JE OPERACAO_MUL

;DIVISAO
	CMP BL, 104
	JE OPERACAO_DIV

;MULTIPLICACAO VARIAS VEZES POR DOIS
	CMP BL, 105
	JE OPERACAO_MUL2

;DIVISAO VARIAS VEZES POR DOIS
	CMP BL, 106
	JE JUMP_DIV2

OPERACAO_AND:
	MOV BX, NUM1
	MOV AX, NUM2
	AND BX, AX
	
	JMP FINAL

OPERACAO_OR:
	MOV BX, NUM1
	MOV AX, NUM2
	OR BX, AX
	
	JMP FINAL

OPERACAO_XOR:
	MOV BX, NUM1
	MOV AX, NUM2
	XOR BX, AX
	
	JMP FINAL
	
OPERACAO_NOT:
	MOV BX, NUM1
	NOT BX
	MOV NUM1, BX
	
	MOV BX, NUM2
	NOT BX
	MOV NUM2, BX
	
	JMP FINAL_NOT

OPERACAO_SOMA:
	MOV BX, NUM1
	ADD BX, NUM2
	
	JMP FINAL
	
OPERACAO_SUB:
	MOV BX, NUM1
	SUB BX, NUM2
	
	JMP FINAL
	
JUMP_DIV2:
	JMP OPERACAO_DIV2

OPERACAO_MUL:
	MOV AX, NUM1
	MOV BX, NUM2
	MUL BX
	
	MOV BX, AX
	
	JMP FINAL
	
OPERACAO_DIV:
	MOV CX, NUM2
	MOV AX, NUM1
	CWD
	DIV CX
	MOV BX, AX
	
	JMP FINAL
	
OPERACAO_MUL2:
	MOV CX, NUM2
	MOV BX, NUM1
	
LOOP_MUL:
	SHL BX, 1 
	
	SUB CX, 1
	CMP CX, 0
	JNE LOOP_MUL
	
	JMP FINAL
	
OPERACAO_DIV2:
	MOV CX, NUM2
	MOV BX, NUM1
	
LOOP_DIV:
	SHR BX, 1 
	
	SUB CX, 1
	CMP CX, 0
	JNE LOOP_DIV
	
	JMP FINAL

FINAL:
	CMP OPCAO, 97
	JE FINAL_BIN
	
	CMP OPCAO, 98
	JE FINAL_DEC
	
	CMP OPCAO, 99
	JE FINAL_HEXA

FINAL_NOT:
	CMP OPCAO, 97
	JE FINAL_BIN_NOT
	
	CMP OPCAO, 98
	JE FINAL_DEC_NOT
	
	CMP OPCAO, 99
	JE FINAL_HEXA_NOT

FINAL_BIN:
	CALL SAIDA_BINARIO
	JMP FINALIZANDO
	
FINAL_DEC:
	MOV CX, BX
	CALL SAIDA_DECIMAL
	JMP FINALIZANDO
	
FINAL_HEXA:
	CALL SAIDA_HEXA
	JMP FINALIZANDO
	
FINAL_BIN_NOT:
	MOV BX, NUM1
	CALL SAIDA_BINARIO
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	MOV BX, NUM2
	CALL SAIDA_BINARIO
	JMP FINALIZANDO
	
INICIO1:
	JMP INICIO	
	
FINAL_DEC_NOT:
	MOV BX, NUM1
	MOV CX, BX
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	CALL SAIDA_DECIMAL
	MOV BX, NUM2
	MOV CX, BX
	CALL SAIDA_DECIMAL
	JMP FINALIZANDO
	
FINAL_HEXA_NOT:
	MOV BX, NUM1
	CALL SAIDA_HEXA
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	MOV BX, NUM2
	CALL SAIDA_HEXA
	JMP FINALIZANDO
	
FINALIZANDO:
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	LEA DX, MSG7
	
	MOV AH, 9
	INT 21H
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	MOV AH, 1
	INT 21H
	MOV BL, AL
	
	MOV AH,2
	MOV DL,0DH
	INT 21H
	MOV DL,0AH
	INT 21H
	
	CMP BL, 115
	JE INICIO1
	
	CMP BL, 110
	JE SAIR

SAIR:
;Finalizando o programa
	MOV AH, 4CH
	INT 21H

MAIN ENDP

ENTRADA_BINARIO PROC
		LEA DX, MSG2

		MOV AH, 9
		INT 21H
		
		MOV CX,16		;inicializa contador de dígitos
		MOV AH,1		;função DOS para entrada pelo teclado
		XOR BX,BX		;zera BX -> terá o resultado
		INT 21h			;entra, caracter está no AL
;while
TOPO:	CMP AL,0Dh		;é CR?
		JE  FIM			;se sim, termina o WHILE
		AND AL,0Fh		;se não, elimina 30h do caracter
						;(poderia ser SUB AL,30h)
		SHL	BX,1		;abre espaço para o novo dígito
		OR 	BL,AL		;insere o dígito no LSB de BL
		INT 21h			;entra novo caracter
		LOOP TOPO		;controla o máximo de 16 dígitos
;end_while
FIM:	RET

ENTRADA_BINARIO ENDP

ENTRADA_DECIMAL PROC
		LEA DX, MSG3

		MOV AH, 9
		INT 21H
		
;le um numero decimal da faixa de -32768 a +32767
;variaveis de entrada: nehuma (entrada de digitos pelo teclado)
;variaveis de saida: AX -> valor binario equivalente do numero decimal
		PUSH 	BX
		PUSH 	CX
		PUSH 	DX 			;salvando registradores que serão usados
		XOR 	BX,BX 		;BX acumula o total, valor inicial 0
		XOR 	CX,CX 		;CX indicador de sinal (negativo = 1), inicial = 0
		MOV 	AH,1h
		INT 	21h 		;le caracter no AL
		CMP 	AL,'-' 		;sinal negativo?
		JE 		MENOS
		CMP 	AL,'+' 		;sinal positivo?
		JE 		MAIS
		JMP 	NUM 		;se nao é sinal, então vá processar o caracter
MENOS: 	MOV 	CX,1 		;negativo = verdadeiro
MAIS: 	INT 	21h 		;le um outro caracter
NUM: 	AND 	AX,000Fh 	;junta AH a AL, converte caracter para binário
		PUSH 	AX 			;salva AX (valor binário) na pilha
		MOV 	AX,10 		;prepara constante 10
		MUL 	BX 			;AX = 10 x total, total está em BX
		POP 	BX 			;retira da pilha o valor salvo, vai para BX
		ADD 	BX,AX 		;total = total x 10 + valor binário
		MOV 	AH,1h
		INT 	21h 		;le um caracter
		CMP 	AL,0Dh 		;é o CR ?
		JNE 	NUM 		;se não, vai processar outro dígito em NUM
		MOV 	AX,BX 		;se é CR, então coloca o total calculado em AX
		CMP 	CX,1 		;o numero é negativo?
		JNE 	SAIDA 		;não
		NEG 	AX 			;sim, faz-se seu complemento de 2
SAIDA: 	POP 	DX
		POP 	CX
		POP 	BX 			;restaura os conteúdos originais
		RET 				;retorna a rotina que chamou
ENTRADA_DECIMAL ENDP

ENTRADA_HEXA PROC
		LEA DX, MSG4

		MOV AH, 9
		INT 21H

		XOR BX,BX		;inicializa BX com zero
		MOV CL,4		;inicializa contador com 4
		MOV AH,1h		;prepara entrada pelo teclado
		INT 21h			;entra o primeiro caracter
;while
TOPO2:	CMP AL,0Dh		;é o CR ?
		JE  FIM2
		CMP AL, 39h		;caracter número ou letra?
		JG  LETRA		;caracter já está na faixa ASCII
		AND AL,0FH		;número: retira 30h do ASCII
		JMP  DESL
LETRA:	SUB AL,37h		;converte letra para binário
DESL:     SHL BX,CL		;desloca BX 4 casas à esquerda
		OR BL,AL		;insere valor nos bits 0 a 3 de BX
		INT 21h			;entra novo caracter
		JMP TOPO2		;faz o laço até que haja CR
;end_while
FIM2:	RET	
ENTRADA_HEXA ENDP

SAIDA_BINARIO PROC
		MOV AH,9H
		LEA DX,MSG6
		
		INT 21H
		
		MOV CX,16		;inicializa contador de bits
		MOV AH,02h		;prepara para exibir no monitor
;for 16 vezes do
PT1:	ROL BX,1		;desloca BX 1 casa à esquerda
;if CF = 1
		JNC  PT2		;salta se CF = 0
;then
		MOV DL, 31h		;como CF = 1
		INT 21h			;exibe na tela "1" = 31h
		JMP FIM3
;else
PT2:	MOV DL, 30h		;como CF = 0
		INT 21h			;exibe na tela "0" = 30h
;end_if
FIM3:
		LOOP  PT1		;repete 16 vezes
;end_for
		RET
SAIDA_BINARIO ENDP

SAIDA_DECIMAL PROC
;exibe o conteudo de AX como decimal inteiro com sinal
;variaveis de entrada: AX -> valor binario equivalente do número decimal
;variaveis de saida: nehuma (exibição de dígitos direto no monitor de video)
		MOV 	AH,9H
		LEA 	DX,MSG6
		
		INT 	21H
		
		MOV 	AX,CX
		
		PUSH 	AX
		PUSH 	BX
		PUSH 	CX
		PUSH 	DX 		;salva na pilha os registradores usados
		OR 		AX,AX 	;prepara comparação de sinal
		JGE 	PT3 	;se AX maior ou igual a 0, vai para PT1
		PUSH 	AX 		;como AX menor que 0, salva o número na pilha
		MOV 	DL,'-'	;prepara o caracter ' - ' para sair
		MOV 	AH,2h 	;prepara exibição
		INT 	21h 	;exibe ' - '
		POP 	AX 		;recupera o número
		NEG 	AX 		;troca o sinal de AX (AX = - AX)
		
		;obtendo dígitos decimais e salvando-os temporariamente na pilha
PT3: 	XOR 	CX,CX 	;inicializa CX como contador de dígitos
		MOV 	BX,10 	;BX possui o divisor
PT4: 	XOR 	DX,DX 	;inicializa o byte alto do dividendo em 0; restante é AX
		DIV 	BX 		;após a execução, AX = quociente; DX = resto
		PUSH 	DX 		;salva o primeiro dígito decimal na pilha (1o. resto)
		INC 	CX 		;contador = contador + 1
		OR 		AX,AX 	;quociente = 0 ? (teste de parada)
		JNE 	PT4 	;não, continuamos a repetir o laço
		
		;exibindo os dígitos decimais (restos) no monitor, na ordem inversa
		MOV 	AH,2h 	;sim, termina o processo, prepara exibição dos restos
PT5: 	POP 	DX 		;recupera dígito da pilha colocando-o em DL (DH = 0)
		ADD 	DL,30h 	;converte valor binário do dígito para caracter ASCII
		INT 	21h 	;exibe caracter
		LOOP 	PT5 	;realiza o loop ate que CX = 0
		POP 	DX 		;restaura o conteúdo dos registros
		POP 	CX
		POP 	BX
		POP 	AX 		;restaura os conteúdos dos registradores
		RET 			;retorna à rotina que chamou
SAIDA_DECIMAL ENDP

SAIDA_HEXA PROC
		MOV 	AH,9H
		LEA 	DX,MSG6
		
		INT 	21H

		MOV CH,4	;CH contador de caracteres hexa
		MOV CL,4	;CL contador de delocamentos
		MOV AH,2h	;prepara exibição no monitor
;for 4 vezes do
TOPO3:	MOV DL,BH	;captura em DL os oito bits mais significativos de BX
		SHR DL,CL	;resta em DL os 4 bits mais significativos de BX
;if DL , 10
		CMP DL, 0Ah	;testa se é letra ou número
		JAE LETRA2
;then
		ADD DL,30h	;é número: soma-se 30h
		JMP PT6
;else
LETRA2:	ADD DL,37h	;ao valor soma-se 37h -> ASCII
;end_if
PT6:	INT 21h		;exibe
		ROL BX,CL	;roda BX 4 casas para a direita
		DEC CH
		JNZ TOPO3	;faz o FOR 4 vezes
;end_for
		RET
SAIDA_HEXA ENDP

END MAIN