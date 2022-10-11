.model Small

.stack 

.data 
    
    texto db "Hello world!" , "$" 
    
.code 

main proc 

    mov ax, SEG @data 
    mov ds,ax 

    mov ah,09 

    lea dx, texto 

    int 21h

    mov ax,4c00h 

    int 21h 

main endp 

end main    
   

