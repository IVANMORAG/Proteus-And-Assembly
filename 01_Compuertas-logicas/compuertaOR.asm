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

    movlw   0x07              ; Desactivar comparadores
    movwf   CMCON

main_loop
    ; Leer entradas RA0 y RA1
    btfsc   PORTA, 0           ; Si RA0 está en alto
    bsf     PORTB, 0           ; Enciende RB0 (LED ON)
    btfsc   PORTA, 1           ; Si RA1 está en alto
    bsf     PORTB, 0           ; Enciende RB0 (LED ON)

    ; Si ambas entradas están en bajo, apaga el LED
    btfss   PORTA, 0           ; Si RA0 está en bajo
    btfss   PORTA, 1           ; Y si RA1 está en bajo
    bcf     PORTB, 0           ; Apaga RB0 (LED OFF)

    goto    main_loop

end
