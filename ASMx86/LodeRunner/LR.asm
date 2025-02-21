.386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Exemplu proiect desenare",0
area_width EQU 1420
area_height EQU 900;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
area DD 0

counter DD 0 ; numara evenimentele de tip timer

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20
ladder_obj EQU 2

symbol_width EQU 10
symbol_height EQU 20
text_width EQU 10
text_height EQU 20

draw_width EQU 25
draw_height EQU 25

matrix_width EQU 40
matrix_height EQU 21

button_up_x EQU 1299
button_up_y EQU 718
button_right_x EQU 1355
button_right_y EQU 777
button_down_x EQU 1299
button_down_y EQU 844
button_left_x EQU 1237
button_left_y EQU 777
button_center_x EQU 1303
button_center_y EQU 786

enemy_up_i DD 4
enemy_up_j DD 21

enemy_upminus_i DD 9
enemy_upminus_j DD 15

enemy_downplus_i DD 11
enemy_downplus_j DD 33

enemy_down_i DD 13
enemy_down_j DD 13

x0 DD 0
y0 DD 60

mani DD 19 ; mani*matrix_width + manj * draw_width + y0 = adresa - event_click
manj DD 17

score DD 0
nrCoins EQU 12

game_matrix DB 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1
			DB 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1
			DB 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1
			DB 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1
			DB 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 0, 1
			DB 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			DB 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			DB 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			DB 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			DB 1, 0, 3, 2, 0, 0, 3, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 
			DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1
			DB 1, 0, 0, 0, 0, 0, 3, 0, 0, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 3, 1
			DB 1, 0, 0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1, 1, 1
			DB 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 1
			DB 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 1
			DB 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

include digits.inc
include letters.inc
include picture.inc
include buttons.inc
include background.inc

.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y

;Parcurgerea matricei am facut-o cu ajutor!
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, text_width
	mul ebx
	mov ebx, text_height
	mul ebx
	add esi, eax
	mov ecx, text_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, text_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, text_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 8889ECh ;  pentru 1 
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0 ; pentru 0
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

fundal proc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi, background
	
draw_text:
	mov ebx, draw_width
	mul ebx
	mov ebx, draw_height
	mul ebx
	add esi, eax
	mov ecx, draw_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, draw_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, draw_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	
	cmp byte ptr [esi], 2
	je simbol_pixel_albastru
	
	cmp byte ptr [esi], 3
	je simbol_pixel_galben
	
	cmp dword ptr [edi], 4
	je simbol_pixel_alb
	
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next
	
simbol_pixel_alb:
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_galben:
	mov dword ptr [edi], 16776960
	jmp simbol_pixel_next
simbol_pixel_albastru:
	mov dword ptr [edi], 2acaeah
	jmp simbol_pixel_next
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
fundal endp

butoane proc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi, buttons
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
butoane endp



	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm



butoane_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call butoane
	add esp, 16
endm

fundal_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call fundal
	add esp, 16
endm

line_horizontal macro x, y, len, color
local bucla_line
	mov EAX, y
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	mov ECX, len
bucla_line:
	mov dword ptr[EAX], color
	add EAX, 4
	loop bucla_line
endm

line_vertical macro x, y, len, color
local bucla_line
	mov EAX, y
	mov EBX, area_width
	mul EBX
	add EAX, x
	shl EAX, 2
	add EAX, area
	mov ECX, len
bucla_line:
	mov dword ptr[EAX], color
	add EAX, area_width * 4
	loop bucla_line
endm

;Parcurgerea matricei am facut-o cu ajutor!
matrix proc
	push ebp
	mov ebp, esp
	pusha
	lea esi, game_matrix
	mov ecx, matrix_height
	mov ebx, 0
	mov edi, y0
bucla_linii:
	push ecx
	mov ecx, matrix_width
bucla_coloane:
	; cmp byte ptr [esi], 0
	; je cont
	cmp byte ptr [esi], 1
	je brick
	cmp byte ptr [esi], 2
	je ladder
	cmp byte ptr [esi], 3
	je coin
	cmp byte ptr [esi], 4
	je character
	cmp byte ptr [esi], 5
	je enemies
	fundal_macro 0, area, ebx, edi
	jmp cont
brick:
	fundal_macro 1, area, ebx, edi
	jmp cont
ladder:
	fundal_macro 2, area, ebx, edi
	jmp cont
coin:
	fundal_macro 3, area, ebx, edi
	jmp cont
character:
	fundal_macro 4, area, ebx, edi
	jmp cont
enemies:
	fundal_macro 5, area, ebx, edi
	jmp move
move:
	
cont:
	add ebx, draw_width ; merge la urmatorul desen
	add esi, 1
	sub ecx, 1
	cmp ecx, 0
	jne bucla_coloane
	pop ecx; se pune numarul de linii 
	mov ebx, 0
	add edi, draw_height
	dec ecx
	cmp ecx, 0
	jne bucla_linii
	popa
	mov esp, ebp
	pop ebp
	ret
matrix endp





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


draw proc
	push ebp
	mov ebp, esp
	pusha
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 0
	push area
	call memset
	add esp, 12
	jmp afisare_litere

	
evt_click:
	;x = x0 + manj* draw_width
	;y = y0 + mani * draw_height
	;mani*matrix_width + manj= adresa
	
	lea esi, game_matrix

	; mov eax, manj
	; mov ebx, draw_width
	; mul ebx
	; mov ebx, eax
	; mov eax, matrix_width
	; mov ecx, mani
	; mul ecx
	; add eax, ebx
	; add eax, y0
	; mov ecx, eax
	
	
	mov eax, mani
	mov ebx, matrix_width
	mul ebx
	add eax, manj
	mov ecx, eax
	cmp byte ptr[esi+ecx], 3 ; coin
	je coin
	cmp byte ptr[esi+ecx], 5 ; enemy(not working)
	je nope_over
	;;;;;;;;;;;;;;;;
	; checking the error cases (if the character is not in the game anymore)
	cmp byte ptr[esi+ecx], 1 ; (the character is literally in the brick)
	je nope_over
	

	
	;verificare click
	mov eax, [arg2 + ebp]
	cmp eax, button_center_x
	jl vf_l
	cmp eax, button_center_x + draw_width
	jg vf_r
	
	
	mov eax, [ebp + arg3]
	cmp eax, button_center_y
	jl vf
	cmp eax, button_center_y + draw_height
	jg vf_d
	
	vf:
	cmp byte ptr[esi + ecx], 2 ; (ladder)
	je ladder
	
	vf_d:
	cmp byte ptr[esi + ecx], 2; ladder
	je down
	cmp byte ptr[esi+ecx+matrix_width], 2 ; ladder
	je down
	jmp nope
	
	vf_r: ; move right only if under the character is a brick or under him to the left side (avoid floating:)))) )
	cmp byte ptr[esi+ecx+matrix_width], 1
	je right
	cmp byte ptr[esi+ecx+matrix_width+1], 1
	je right
	jmp nope
	
	vf_l: ;move right only if under the character is a brick or under him to the right side
	cmp byte ptr[esi+ecx+matrix_width], 1
	je left
	cmp byte ptr[esi+ecx+matrix_width-1], 1
	je left
	jmp nope
	
	left:
	dec manj
	jmp nope
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	right:
	inc manj
	jmp nope
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	ladder:
		dec mani
		jmp nope
		
	down:
	inc mani
	jmp nope
	
	coin:
	mov byte ptr[esi+ecx], 0
	inc score
	cmp score, nrCoins
	je nope_over
	jmp nope
	
nope_over:
	make_text_macro 'G', area, 400, 10
	make_text_macro 'A', area, 410, 10
	make_text_macro 'M', area, 420, 10
	make_text_macro 'E', area, 430, 10
	make_text_macro 'O', area, 450, 10
	make_text_macro 'V', area, 460, 10
	make_text_macro 'E', area, 470, 10
	make_text_macro 'R', area, 480, 10
	
	jmp final_draw
	
nope:
	jmp afisare_litere
evt_timer:
	lea esi, game_matrix
	
	mov eax, enemy_down_i
	mov ebx, matrix_width
	mul ebx
	add eax, enemy_down_j
	
	mov eax, enemy_downplus_i
	mov ebx, matrix_width
	mul ebx
	add eax, enemy_downplus_j
	mov ebx, eax
	
	mov eax, enemy_up_i
	mov ebx, matrix_width
	mul ebx
	add eax, enemy_up_j
	mov ecx, eax
	
	mov eax, enemy_upminus_i
	mov ebx, matrix_width
	mul ebx
	add eax, enemy_upminus_j
	mov edi, eax
	
	
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;
enemy_1:
	cmp enemy_down_j, 20
	jl mov_right
	
	cmp enemy_down_j, 14
	jg mov_left
	
	mov_right:
	inc enemy_down_j
	
	jmp enemy_2
	
	mov_left:
	sub enemy_down_j, 2
	
	

enemy_2:
	cmp enemy_downplus_j, 35
	jl mov_right2
	
	cmp enemy_downplus_j, 28
	jg mov_left2
	
	mov_right2:
	add enemy_downplus_j, 1
	jmp enemy_3
	
	mov_left2:
	sub enemy_downplus_j, 3
	
enemy_3:
	cmp enemy_upminus_j, 20
	jl mov_right3
	
	cmp enemy_upminus_j, 15
	jg mov_left3
	
	mov_right3:
	add enemy_upminus_j, 1
	jmp enemy_4
	
	mov_left3:
	sub enemy_upminus_j, 3
	
enemy_4:
	cmp enemy_up_j, 36
	jl mov_right4
	
	cmp enemy_up_j, 20
	jg mov_left4
	
	mov_right4:
	add enemy_up_j, 1
	jmp no
	
	mov_left4:
	sub enemy_up_j, 3
	
	no:
	inc counter
	
afisare_litere:
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	;scriem un mesaj
	make_text_macro 'L', area, 110, 10
	make_text_macro 'O', area, 120, 10
	make_text_macro 'D', area, 130, 10
	make_text_macro 'E', area, 140, 10
	make_text_macro 'R', area, 160, 10
	make_text_macro 'U', area, 170, 10
	make_text_macro 'N', area, 180, 10
	make_text_macro 'N', area, 190, 10
	make_text_macro 'E', area, 200, 10
	make_text_macro 'R', area, 210, 10

	
	;pozitionarea butoanelor si al sagetiilor
	fundal_macro 1, area, 100, 100
	butoane_macro 0, area, 1299, 718; sus
	butoane_macro 1, area, 1355, 777; dreapta
	butoane_macro 2, area, 1365, 777
	butoane_macro 3, area, 1299, 844; jos
	butoane_macro 4, area, 1237, 777; stanga
	butoane_macro 5, area, 1227, 777
	
	butoane_macro 6, area, button_center_x, button_center_y
	
	mov ebx, 10
	mov eax, score
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 80, 590
	;cifra zecilor                 
	mov edx, 0                     
	div ebx                        
	add edx, '0'                   
	make_text_macro edx, area, 70, 590
	;cifra sutelor                 
	mov edx, 0                     
	div ebx                        
	add edx, '0'                   
	make_text_macro edx, area, 60, 590
	
	call matrix
	
	;;;;;;;;;;;;;;;; calcularea pozitiei initial al friendly character
	mov eax, manj
	mov ebx, draw_height
	mul ebx
	mov ecx, eax
	add ecx, x0 
	
	mov eax, mani
	mov ebx, draw_width
	mul ebx
	mov edx, eax
	add edx, y0
	fundal_macro 4, area, ecx, edx
	
	;Calcularea pozitiei a 4 enemy characters
	mov eax, enemy_down_j
	mov ebx, draw_height
	mul ebx
	mov ecx, eax
	add ecx, x0 
	
	mov eax, enemy_down_i
	mov ebx, draw_width
	mul ebx
	mov edx, eax
	add edx, y0
	fundal_macro 5, area, ecx, edx
	
	mov eax, enemy_downplus_j
	mov ebx, draw_height
	mul ebx
	mov ecx, eax
	add ecx, x0 
	
	mov eax, enemy_downplus_i
	mov ebx, draw_width
	mul ebx
	mov edx, eax
	add edx, y0
	fundal_macro 5, area, ecx, edx
	
	mov eax, enemy_upminus_j
	mov ebx, draw_height
	mul ebx
	mov ecx, eax
	add ecx, x0 
	
	mov eax, enemy_upminus_i
	mov ebx, draw_width
	mul ebx
	mov edx, eax
	add edx, y0
	fundal_macro 5, area, ecx, edx
	
	mov eax, enemy_up_j
	mov ebx, draw_height
	mul ebx
	mov ecx, eax
	add ecx, x0 
	
	mov eax, enemy_up_i
	mov ebx, draw_width
	mul ebx
	mov edx, eax
	add edx, y0
	fundal_macro 5, area, ecx, edx
	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start