;Tarea programada I, Javier Cruz Ruiz C02517
;Lenguaje ensamblador Grupo 01

.model small 
.stack 
.data
    
    salto db 10,13,7 
    texto1 db 10,13,7, "1.AND", "$"
    texto2 db 10,13,7, "2.OR", "$"
    texto3 db 10,13,7, "3.NOT", "$"
    texto4 db 10,13,7, "4.XOR", "$"
    texto5 db 10,13,7, "5.SALIR", "$"  
    texto6 db 10,13,7, "Ingrese su opcion", "$" 
    
    opcion db 0 
    dato1 db 1 
    dato2 db 2 
    dato3 db 3
    dato4 db 4
    dato5 db 5 
    
    solicitud db 10,13,7, "Ingrese un entero hexadecimal: ", "$"
    hex1 db 0 
    hex2 db 0 
    resultado db 0 
    
    mostrar db 10,13,7, "El resultado es: ", "$" 
    
.code 

    mov ax, @data 
    mov ds, ax 
    
    imprima: 
    mov ah, 09h
    lea dx, salte
    int 21h
    
    mov ah, 09h
    lea dx, texto1 
    int 21h  
    
    mov ah, 09h
    lea dx, texto2 
    int 21h 
    
    mov ah, 09h
    lea dx, texto3 
    int 21h 
    
    mov ah, 09h
    lea dx, texto4 
    int 21h 
    
    mov ah, 09h
    lea dx, texto5 
    int 21h 
    
    mov ah, 09h
    lea dx, texto6 
    int 21h  
    
    obtener: 
    mov ah, 01h 
    int 21h 
    sub al, 30h 
    mov opcion, al 
    
    evalue:
    cmp al, dato1
    JE op_and 
   
    cmp al, dato2
    JE op_or 
   
    cmp al, dato3
    JE op_not 
   
    cmp al, dato4
    JE op_xor 
   
    cmp al, dato5
    JE op_salir  
    
    op_and: 
    
    
    op_or: 
    
    
    op_not: 
    
    
    op_xor: 
     
    
    op_salir: 
    
    
    
    
    
    
    
    
    
    
    
    
    
    