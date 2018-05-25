    org 0x7c00

    jmp entry
    db 0x90
    db "HELLOIPL"
    dw 512
    db 1
    dw 1
    db 2
    dw 224
    dw 2880
    db 0xf0
    dw 9
    dw 18
    dw 2
    dd 0
    dd 2880
    db 0, 0, 0x29
    dd 0xffffffff
    db "HELLO-OS   "
    db "FAT12   "
    resb 18

entry:
    mov AX, 0
    mov SS, AX
    mov SP, 0x7c00
    mov DS, AX
    mov ES, AX

    mov AH, 0x0e        ; 1文字表示機能をセット
    mov BX, 0           ; カラーコードを設定(うまくいかない)
    mov SI, msg         ; SIレジスタにメッセージの先頭アドレスを割り当て
putloop:
    mov AL, [SI]        ; メッセージを1文字読みだして
    add SI, 1           ; アドレスを1文字分進める
    cmp AL, 0           ; 終端に到達したら脱出
    je  end
    int 0x10            ; ビデオBIOSを呼び出す
    jmp putloop

end:
    hlt
    jmp end

msg:
    db 0x0a, 0x0a
    db "Hello, world!"
    db 0x0a
    db 0

    resb 0x7dfe-$
    db 0x55, 0xaa

