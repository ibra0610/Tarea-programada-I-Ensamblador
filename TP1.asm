;Tarea programada I, Javier Cruz Ruiz C02517
;Lenguaje ensamblador Grupo 01

.model small 
.stack 512 

.data 
    
    ;Datos para la interfaz
    menu db "1.AND 2.OR 3.NOT 4.XOR 5.Salir"
    eleccion db ? 
    peticionHex1 db "Ingrese el primer numero hexadecimal: " 
    peticionHex2 db "Ingrese el segundo numero hexadecimal: "
    resultadoTexto db "El resultado de la operacion es: " 
    volverAlMenu db "Presione cualquier tecla para volver al menu"
    
    ;datos para imprimir luego de la eleccion
    peticionAux db "Este mensaje sera remplazado" 
    peticionAnd db "Usted selecciono AND." 
    peticionOr db "Usted selecciono OR." 
    peticionNot db "Usted selecciono NOT."
    peticionXOR db "Usted selecciono XOR."
    salir db "Usted selecciono Salir." 

    
    ;Datos necesarios para realizar las operaciones
    hexa1 db ? 
    hexa2 db ? 
    resultado_operacion db ? 
    
    ;Datos para la impresion en pantalla 
    fila db ? 
    columna db ? 

.code 

borre_pantalla PROC     NEAR  ;Proceso que se encarga de limpiar la pantall
                              ;esto para que se pueda volver a imprimir 
    mov ax, 0600h 
    mov bh, 07h 
    mov cx, 0000h 
    mov dx, 184Fh 
    int 10h 
    RET 
    
borre_pantalla ENDP 

coloque_cursor PROC     NEAR  ;Se encarga de colocar el cursor en pantalla 
                              ;Se coloca en diferente posicion dependiendo de los valores de fila y columna 
    mov ah, 02h               
    mov bh, 0 
    mov dh, fila 
    mov dl, columna 
    int 10h 
    RET
    
coloque_cursor endp 


obtenga_caracter PROC   NEAR ;Este proceso utiliza la funcion 10h de la interrupcion 16h     
                             ;para obtener cualquier caracter, espera a que el usuario presione
    mov ah, 10h              ;una tecla. Se utiliza como "stop para el programa
    int 16h 
    RET
    
obtenga_caracter ENDP 

lea_teclado PROC    NEAR ;Este proceso utiliza la funcion 00h de la interrupcion 16h 
                         ;espera a que el usuario presione una tecla y almacena en ah   
    mov ah, 00h          ;el scancode de la tecla presionada. Esto se utiliza en el menu
    int 16h              ;comparando el scancode con las opciones del menu. 
    RET  
lea_teclado ENDP


imprima_eleccion_AND PROC  ;Este proceso se utiliza para imprimir en la ventana la eleccion que 
                            ;realizo el usuario, en este caso imprime una confirmacion diciendo
    mov ax, @data           ;que el usuario eligio hacer la operacion AND. Al final llama otro proceso para
    mov ds, ax              ;obtener los operandos. 
    mov ax, 0B800h 
    mov es, ax 
 
    call borre_pantalla   
    
    mov ah, 07 
    mov cx, 21                  ;cantidad de caracteres
    mov si, offset peticionAnd  ;es el texto de la peticion
    mov di, 700                 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaElecAnd: 
    lodsb 
    stosw 
    loop imprimaElecAnd 
    
    mov fila, 4 
    mov columna, 52             ;Posicion del cursor, para que aparezca al final del texto
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset peticionAnd 
    
    call obtenga_operandos_AND  ;llama al proceso para obtener los operandos de AND

imprima_eleccion_AND ENDP 

imprima_eleccion_OR PROC  ;Este proceso se utiliza para imprimir en la ventana la eleccion que 
                          ;realizo el usuario, en este caso imprime una confirmacion diciendo
                          ;que el usuario eligio hacer la operacion OR. Al final llama otro proceso para
                          ;obtener los operandos. 
    
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
 
    call borre_pantalla   
    
    mov ah, 07 
    mov cx, 20                  ;cantidad de caracteres
    mov si, offset peticionOr   ;es el texto de la peticion
    mov di, 700                 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaElecOr: 
    lodsb 
    stosw 
    loop imprimaElecOr 
    
    mov fila, 4  
    mov columna, 52             ;Posicion del cursor, para que aparezca al final del texto 
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset peticionOr 
    
    call obtenga_operandos_OR   ;llama al proceso para obtener los operandos de OR

imprima_eleccion_OR ENDP 

imprima_eleccion_NOT PROC  ;Este proceso se utiliza para imprimir en la ventana la eleccion que 
                            ;realizo el usuario, en este caso imprime una confirmacion diciendo
                            ;que el usuario eligio hacer la operacion NOT. Al final llama otro proceso para
                            ;obtener los operandos. 
    
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
 
    call borre_pantalla   
    
    mov ah, 07 
    mov cx, 21                  ;cantidad de caracteres
    mov si, offset peticionNot  ;es el texto de la peticion
    mov di, 700                 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaElecNot: 
    lodsb 
    stosw 
    loop imprimaElecNot 
    
    mov fila, 4 
    mov columna, 52             ;Posicion del cursor, para que aparezca al final del texto 
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset peticionNot 
    
    call obtenga_operandos_NOT

    imprima_eleccion_NOT ENDP 

imprima_eleccion_XOR PROC  ;Este proceso se utiliza para imprimir en la ventana la eleccion que 
                            ;realizo el usuario, en este caso imprime una confirmacion diciendo
                            ;que el usuario eligio hacer la operacion XOR. Al final llama otro proceso para
                            ;obtener los operandos. 
    
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
 
    call borre_pantalla   
    
    mov ah, 07 
    mov cx, 21                  ;cantidad de caracteres
    mov si, offset peticionXor  ;es el texto de la peticion
    mov di, 700                 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaElecXor: 
    lodsb 
    stosw 
    loop imprimaElecXor 
    
    mov fila, 4 
    mov columna, 52             ;Posicion del cursor, para que aparezca al final del texto 
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset peticionXor 
    
    call obtenga_operandos_XOR

imprima_eleccion_XOR ENDP 

imprima_eleccion_SALIR PROC  ;Este proceso se utiliza para imprimir en la ventana la eleccion que 
                            ;realizo el usuario, en este caso imprime una confirmacion diciendo
                            ;que el usuario eligio salir del programa. 
    
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
 
    call borre_pantalla   
    
    mov ah, 07 
    mov cx, 23              ;cantidad de caracteres
    mov si, offset salir    ;es el texto de la peticion
    mov di, 700             ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaElecSalir: 
    lodsb 
    stosw 
    loop imprimaElecSalir 
    
    mov fila, 4 
    mov columna, 52          ;Posicion del cursor, para que aparezca al final del texto 
    call coloque_cursor 
 
    mov ax, @data 
    mov es, ax 
    
    mov cx, 1000 
    mov di, offset salir 
    
    
    .EXIT

imprima_eleccion_SALIR ENDP 


obtenga_operandos_AND PROC ;Este proceso se utiliza para obtener los operandos 
                            ;necesarios para realizar el AND. Luego se llama al proceso imprima_resultado para que muestre al usuario el resultado de la operacion.
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 38              ;cantidad de caracteres del texto 
    mov si, offset peticionHex1 
    mov di, 1120            ;mueve el texto en la ventana, lo cambia de posicion 
    cld 
    
    imprimaPet1AND:         ;Se imprime el texto para pedir el primer numero al usuario
        lodsb 
        stosw 
        loop imprimaPet1AND 
    
        mov fila, 7 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex1
        
        call obtenga_caracter       ;Utiliza el proceso obtenga_caracter, este utiliza la int 16h para leer 
        sub al, 30h                 ; el cogido ASCII de la tecla presionada por el usuario, se le resta 30 para que quede el numero exacto (no un simbolo ascii)
        mov hexa1, al               ;al final se almacena en hexa1. 
        
        
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 39                  ;cantidad de caracteres del texto 
    mov si, offset peticionHex2 
    mov di, 1280                ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaPet2AND: ;Se imprime el texto para pedir el segundo numero al usuario
        lodsb 
        stosw 
        loop imprimaPet2AND 
    
        mov fila, 8 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex2
        
        call obtenga_caracter   ;Utiliza el proceso obtenga_caracter, este utiliza la int 16h para leer 
                                ; el cogido ASCII de la tecla presionada por el usuario, se le resta 30 para que quede el numero exacto (no un simbolo ascii)
                                ;al final se almacena en hexa2
        sub al, 30h 
        mov hexa2, al 
        
        mov al, hexa1           ;se ejecuta la operacion AND, se almacena en resultado_operacion, al final se le suma 48 para que pueda imprimir el caracter de un numero
        AND al, hexa2 
        mov resultado_operacion, al
        ADD resultado_operacion, 48 ;Para que imprima el caracter ASCII correcto 
        
        call imprima_Resultado  ;llama a la operacion para que muestre el resultado al usuario
        
obtenga_operandos_AND ENDP 

obtenga_operandos_OR PROC   ;Este proceso se utiliza para obtener los operandos necesarios para realizar la operacion OR
                            ;Luego se llama al proceso imprima_resultado para que muestre al usuario el resultado de la operacion.
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 38                      ;cantidad de caracteres del texto 
    mov si, offset peticionHex1 
    mov di, 1120                    ;mueve el texto en la ventana, lo cambia de posicion 
    cld 
    
    imprimaPet1OR:          ;Imprime el mensaje que solicita al usuario ingresar el primer numero
        lodsb 
        stosw 
        loop imprimaPet1OR 
    
        mov fila, 7 
        mov columna, 38         ;Posicion del cursor
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex1
        
        call obtenga_caracter       ;llama a obtenga_caracter para que lea la tecla ingresada por el usuario, se le resta 30 para que quede un numero
        sub al, 30h                 ;finalmente se almacena en hexa1
        mov hexa1, al  
        
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 39 ;cantidad de caracteres del texto 
    mov si, offset peticionHex2 
    mov di, 1280 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaPet2OR:              ;imprime el texto solicitando al usuario ingresar el segundo numero
        lodsb 
        stosw 
        loop imprimaPet2OR 
    
        mov fila, 8 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex2
        
        call obtenga_caracter   ;llama a obtenga_caracter para que lea la tecla ingresada por el usuario, se le resta 30 para que quede un numero
        sub al, 30h             ;finalmente se almacena en hexa2
        mov hexa2, al 
        
        mov al, hexa1             ;ejecuta la operacion OR y almacena el resultado en resultado_operacion, al final se le suma 48 para que pueda imprimir el caracter de un numero
        OR al, hexa2 
        mov resultado_operacion, al
        ADD resultado_operacion, 48  
        
        call imprima_Resultado  ;llama a la operacion para que muestre el resultado al usuario 
        
obtenga_operandos_OR ENDP 

obtenga_operandos_NOT PROC ;Este proceso se utiliza para obtener los operandos necesarios para realizar la operacion NOT
                            ;Luego se llama al proceso imprima_resultado para que muestre al usuario el resultado de la operacion.
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 38 ;cantidad de caracteres del texto 
    mov si, offset peticionHex1 
    mov di, 1120 ;mueve el texto en la ventana, lo cambia de posicion 
    cld 
    
    imprimaPet1NOT: ;Imprime el mensaje que solicita al usuario ingresar el primer numero
        lodsb 
        stosw 
        loop imprimaPet1NOT 
    
        mov fila, 7 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex1
        
        call obtenga_caracter       ;llama a obtenga_caracter para que lea el codigo ascii de la tecla presionada por el usuario
        sub al, 30h                 ;se le resta 30 para que quede el caracter de un numero 
        mov hexa1, al               ;se almacena en hexa1
         
        
        mov al, hexa1               ;ejecuta la operacion NOT y almacena el resultado en resultado_operacion, s ele resta 48 para que pueda imprimir
        NOT al                      ;el resultado mostrando el caracter de un numero
        mov resultado_operacion, al
        ADD resultado_operacion, 48 
        
        call imprima_Resultado  ;llama al proceso que imprime el resultado al usuario 
        
obtenga_operandos_NOT ENDP 

obtenga_operandos_XOR PROC ;Este proceso se utiliza para obtener los operandos necesarios para realizar la operacion XOR
                            ;Luego se llama al proceso imprima_resultado para que muestre al usuario el resultado de la operacion.
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 38                  ;cantidad de caracteres del texto 
    mov si, offset peticionHex1 
    mov di, 1120                    ;mueve el texto en la ventana, lo cambia de posicion 
    cld 
    
    imprimaPet1XOR: ;Imprime el mensaje que solicita al usuario ingresar el primer numero
        lodsb 
        stosw 
        loop imprimaPet1XOR
    
        mov fila, 7 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex1
        
        call obtenga_caracter       ;llama a obtenga_caracter para que lea el codigo ascii de la tecla presionada por el usuario
        sub al, 30h                 ;se le resta 30 para que quede el caracter de un numero 
        mov hexa1, al               ;se almacena en hexa1
        
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 

    mov ah, 07 
    mov cx, 39 ;cantidad de caracteres del texto 
    mov si, offset peticionHex2 
    mov di, 1280 ;mueve el texto en la ventana, lo cambia de posicion 
    cld
    
    imprimaPet2XOR: ;Imprime el mensaje que solicita al usuario ingresar el segundo numero
        lodsb 
        stosw 
        loop imprimaPet2XOR 
    
        mov fila, 8 
        mov columna, 38 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset peticionHex2
        
        call obtenga_caracter       ;llama a obtenga_caracter para que lea el codigo ascii de la tecla presionada por el usuario
        sub al, 30h                 ;se le resta 30 para que quede el caracter de un numero 
        mov hexa2, al               ;se almacena en hexa2
        
        mov al, hexa1               ;ejecuta la operacion XOR y almacena el resultado en resultado_operacion, se le suma 48 para que muestre un caracter de numero
        XOR al, hexa2               
        mov resultado_operacion, al
        ADD resultado_operacion, 48 
        
        call imprima_Resultado
        
obtenga_operandos_XOR ENDP
  
imprima_Resultado PROC      ;Este proceso se utiliza para imprimir el resultado
                            ;de cada operacion y que este sea visible para el usuario
        
    mov ax, @data 
    mov ds, ax 
    mov ax, 0B800h 
    mov es, ax 
    
    mov ah, 07 
    mov cx, 33 ;cantidad de caracteres del texto 
    mov si, offset resultadoTexto 
    mov di, 1920 ;mueve el texto en la ventana, lo cambia de posicion 
    cld  
    
    imprimaResultadoTexto: 
    
        lodsb 
        stosw 
        loop imprimaResultadoTexto 
    
        mov fila, 11 
        mov columna, 20 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset resultadoTexto 
        
        mov ax, @data 
        mov ds, ax 
        mov ax, 0B800h 
        mov es, ax 
    
        mov ah, 07 
        mov cx, 1 ;cantidad de caracteres del texto 
        mov si, offset resultado_operacion 
        mov di, 1988 ;mueve el texto en la ventana, lo cambia de posicion 
        cld
        
        ImprimaNumero: 
            lodsb 
            stosw 
            loop ImprimaNumero 
    
            mov fila, 12 
            mov columna, 34 ;Posicion del cursor con un texto mas largo 
            call coloque_cursor 
 
            mov ax, @data 
            mov es, ax 
    
            mov cx, 1000
            mov di, offset resultado_operacion 
            
            mov ax, @data 
            mov ds, ax 
            mov ax, 0B800h 
            mov es, ax 
    
            mov ah, 07 
            mov cx, 44 ;cantidad de caracteres del texto 
            mov si, offset volverAlMenu
            mov di, 2600 ;mueve el texto en la ventana, lo cambia de posicion 
            cld  
    
        volver_al_menu: ;Este mensaje se imprime para que el usuario sepa que debe oprimir cualquier tecla para volver al menu, luego de imprimir el resultado
    
        lodsb 
        stosw 
        loop volver_al_menu 
    
        mov fila, 16 
        mov columna, 65 ;Posicion del cursor con un texto mas largo 
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset volverAlMenu 
            
            call obtenga_caracter ;Esto para que de tiempo a mostrar el resultado y desaparezca cuando el usuario presione una tecla
    
imprima_Resultado ENDP

  
 

Begin: 

    mov ax, @data ;carga los datos
    mov ds, ax 
    mov ax, 0B800h ;segmento del buffer de video
    mov es, ax  
    
    call borre_pantalla
    
    mov ah, 07 
    mov cx, 30 ;Esta es la cantidad de caracteres a mostrar, dependiendo del largo del texto, en este caso es 30
    mov si, offset menu 
    mov di, 1620 ;Se ajusta la posicion en donde imprime el menu
    cld 
    
    imprimaMenu: 
        lodsb 
        stosw 
        loop imprimaMenu 
    
        mov fila, 10 ;Aqui se mueve el cursor de arriba a abajo
        mov columna, 43 ;Aqui se mueve el cursor a los lados
        call coloque_cursor 
 
        mov ax, @data 
        mov es, ax 
    
        mov cx, 1000 
        mov di, offset menu 

     lectura: 
        
        call lea_teclado 
        mov eleccion, ah ;Almacena el scancode de la tecla que selecciono el usuario en eleccion 
        
        cmp eleccion, 2 ;compara la eleccion con el numero 2, el cual es el scancode de la tecla 1 
        JE interfaz_AND 
        
        cmp eleccion, 3 ;compara la eleccion con el numero 3, el cual es el scancode de la tecla 2 
        JE interfaz_OR 
        
        cmp eleccion, 4 ;compara la eleccion con el numero 4, el cual es el scancode de la tecla 3 
        JE interfaz_NOT 
        
        cmp eleccion, 5 ;compara la eleccion con el numero 5, el cual es el scancode de la tecla 4 
        JE interfaz_XOR 
        
        cmp eleccion, 6 ;compara la eleccion con el numero 6, el cual es el scancode de la tecla 5 
        JE interfaz_SALIR 
     
    
        
      interfaz_AND: 
        
        call imprima_eleccion_AND ;llama a imprima eleccion, en donde se llama al resto de procesos para el funcionamiento del programa

        jmp Begin   ;luego de ejecutar todos los procesos salta a begin, para que vuelva a iniciar el programa, asi entra en un bucle
                    ;hasta que el usuario decida salir
      interfaz_OR:
      
        call imprima_eleccion_OR 
        
        jmp Begin
       
      interfaz_NOT: 
      
        call imprima_eleccion_NOT 
        
        jmp Begin
        
      interfaz_XOR:
      
        call imprima_eleccion_XOR 
        
        jmp Begin
        
      interfaz_SALIR: 
      
        call imprima_eleccion_SALIR 
        
        
end Begin 



























    