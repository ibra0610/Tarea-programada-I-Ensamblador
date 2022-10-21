;Tarea programada I, Javier Cruz Ruiz C02517
;Lenguaje ensamblador Grupo 01

.model small 
.stack 512 

.data 

    menu db "a.AND b.OR c.NOT d.XOR e.Salir"
    eleccion db ?  
    scancode1 db 30 
    scancode2 db 48 
    scancode3 db 46 
    scancode4 db 32 
    scancode5 db 18 
    peticionAnd db "Usted selecciono AND. Ingrese el primer numero hexadecimal: " 
    peticionOr db "Usted selecciono OR. Ingrese el primer numero hexadecimal: " 
    peticionNot db "Usted selecciono NOT. Ingrese el primer numero hexadecimal: "  
    peticionXOR db "Usted selecciono XOR. Ingrese el primer numero hexadecimal: "
    salir db "Usted selecciono Salir."
    peticion2 db "Ingrese el segundo numero hexadecimal: " , "$"
    resultado db "El resultado de la operacion es: " 
    fila db ? 
    columna db ? 
    hexa1 db 0 
    hexa2 db 0  
    
.code 


    

borre_pantalla PROC     NEAR  
    
    mov ax, 0600h 
    mov bh, 07h 
    mov cx, 0000h 
    mov dx, 184Fh 
    int 10h 
    RET 
    
borre_pantalla ENDP 

coloque_cursor PROC     NEAR 

    mov ah, 02h 
    mov bh, 0 
    mov dh, fila 
    mov dl, columna 
    int 10h 
    RET
    
coloque_cursor endp 


obtenga_caracter PROC   NEAR 
    
    mov ah, 10h 
    int 16h 
    RET
    
obtenga_caracter ENDP 

lea_teclado PROC    NEAR 

    mov ah, 00h 
    int 16h 
    RET  
lea_teclado ENDP 

obtenga_numero_test PROC    NEAR 
    
    call borre_pantalla
    ;call coloque_cursor

    mov ah, 09h 
    lea dx, peticion2 
    int 21h 
    
    mov ah,01h 
    int 21h 
    sub al, 30h 
    mov eleccion, al 
    

obtenga_numero_test ENDP  

Begin: 

    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
  
    mov ah, 0 
    mov al, 3 
    int 10h 
  
call borre_pantalla 

    mov ah, 07 
    mov cx, 30 ;Aqui se pone la cantidad de caracteres a mostrar 
    mov si, offset menu 
    mov di, 1620 
    cld 

imprima: 
    
    lodsb 
    stosw 
    loop imprima 
    
    mov fila, 10 ;Aqui se mueve el cursor de arriba a abajo
    mov columna, 43 ;Aqui se mueve el cursor a los lados
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 5 
    mov di, offset menu 

lectura: 
    
    call lea_teclado 
    
    cmp ah, scancode1 
    JE op_and  
    
    cmp ah, scancode2 
    JE op_or 
    
    cmp ah, scancode3 
    JE op_not 
    
    cmp ah, scancode4 
    JE op_xor
    
    cmp ah, scancode5 
    JE op_salir
        

op_and:
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
  
    mov ah, 0 
    mov al, 3 
    int 10h 
    
    call borre_pantalla

    mov ah, 07 
    mov cx, 59 ;cantidad de caracteres del texto 
    mov si, offset peticionAnd 
    mov di, 1604 ;mueve el texto en la ventana, lo cambia de posicion 
    cld 
    
imprimaAnd: 
    lodsb 
    stosw 
    loop imprimaAnd 
    
    mov fila, 10 
    mov columna, 64 ;Posicion del cursor con un texto mas largo 
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset peticionAnd 
    
    call obtenga_caracter
    
Ciclo: 
    call Begin

op_or: 

    mov ah, 0Ah 
    mov al, 'B' 
    mov bh,0 
    mov cx,1 
    int 10h 
    call imprima 
    call lectura


op_not: 

    mov ah, 0Ah 
    mov al, 'C' 
    mov bh,0 
    mov cx,1 
    int 10h 
    call imprima 
    call lectura

op_xor: 
    mov ah, 0Ah 
    mov al, 'D' 
    mov bh,0 
    mov cx,1 
    int 10h 
    call imprima 
    call lectura
    
op_salir: 
    mov ah, 0Ah 
    mov al, 'E' 
    mov bh,0 
    mov cx,1 
    int 10h
    call imprima 
    call lectura


end Begin  

 
    































    
