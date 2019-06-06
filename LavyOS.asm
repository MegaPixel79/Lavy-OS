[bits 16]
[org 0x7c00]

    mov ax,0x13
    int 0x10
   
    mov ah,0x02         ; set value for change to cursor position  
    mov bh,0x00         ; page  
    mov dh,0x06         ; y cordinate/row  
    mov dl,0x05         ; x cordinate/col  
    int 0x10 

    mov si,text_string  ; Put string position into SI
    call print_string   ; Call our string-printing routine
    
    
    
    
    jmp $               ; Jump here - infinite loop!


text_string:  db 'Welcome to LAVY OS!',13, 0


print_string:       ; Routine: output string in SI to screen
    mov ah, 0x0E    ; int 10h 'print char' function
    mov bl, 0x02
    
repeat:
    lodsb           ; Get character from string
    cmp al, 0
    je done        ; If char is zero, end of string
    inc bl
    and bl,7
    cmp bl,0
    jz setcolor
    int 0x10        ; Otherwise, print it
    jmp repeat 
setcolor:
    mov bl,0x02
    int 0x10        ; Otherwise, print it
    jmp repeat

done:
    ret

times 510-($-$$) db 0x00 ; Pad remainder of boot sector with 0s
dw 0xaa55
