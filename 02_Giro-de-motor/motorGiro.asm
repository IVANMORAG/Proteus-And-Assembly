; Archivo: motor_control_buttons.asm
; Microcontrolador: PIC16F628A

LIST    P=16F628A
INCLUDE "P16F628A.INC"

; Configuración del bit de configuración
__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT

; Definición de pines
#define BUTTON_CCW PORTA, 0
#define BUTTON_CW  PORTA, 1
#define RELAY1     PORTB, 0
#define RELAY2     PORTB, 1

ORG 0x00
goto start

ORG 0x05

start:
    ; Inicializa los puertos
    bsf STATUS, RP0
    clrf TRISB  ; PORTB como salida
    movlw 0x03
    movwf TRISA ; RA0 y RA1 como entrada
    bcf STATUS, RP0
    clrf PORTB  ; Limpia PORTB

    ; Configuración del oscilador interno
    movlw 0x07
    movwf CMCON

main_loop:
    ; Revisa el botón para dirección contraria a las manecillas del reloj
    btfsc BUTTON_CCW
    goto ccw_direction

    ; Revisa el botón para dirección en sentido de las manecillas del reloj
    btfsc BUTTON_CW
    goto cw_direction

    ; Mantener estado actual si no se presiona ningún botón
    goto main_loop

ccw_direction:
    bsf RELAY1
    bcf RELAY2
    goto main_loop

cw_direction:
    bcf RELAY1
    bsf RELAY2
    goto main_loop

END
