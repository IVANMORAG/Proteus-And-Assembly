list    p=16f628a
#include <p16f628a.inc>
__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC & _LVP_OFF

org 0x00
goto start

start
    ; Configuración de puertos
    bsf     STATUS, RP0       ; Cambiar al banco 1
    movlw   b'00000011'       ; RA0 y RA1 como entradas
    movwf   TRISA
    movlw   b'00000000'       ; RB0 como salida
    movwf   TRISB
    bcf     STATUS, RP0       ; Volver al banco 0

main_loop
    ; Leer entradas RA0 y RA1
    btfss   PORTA, 0           ; Si RA0 está en alto
    goto    and_off            ; Si no, apaga RB0
    btfss   PORTA, 1           ; Si RA1 está en alto
    goto    and_off            ; Si no, apaga RB0
    bsf     PORTB, 0           ; Si ambos están en alto, enciende RB0
    goto    main_loop

and_off
    bcf     PORTB, 0           ; Apaga RB0
    goto    main_loop

    end
