    list    p=16f628a
    #include <p16f628a.inc>
    __CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _XT_OSC & _LVP_OFF

    cblock  0x20
	delay_count1
	delay_count2
	delay_count3
    endc

    #define BTN_INICIO   RA0
    #define BTN_DETENER  RA1
    #define S1_VERDE     RA2
    #define S1_AMARILLO  RA3
    #define S1_ROJO      RB3   
    #define S2_VERDE     RB0
    #define S2_AMARILLO  RB1
    #define S2_ROJO      RB2

    org 0x00
    goto start

    delay_1s
	movlw   d'10'
	movwf   delay_count1
    delay_loop1
	movlw   d'200'
	movwf   delay_count2
    delay_loop2
	movlw   d'200'
	movwf   delay_count3
    delay_loop3
	decfsz  delay_count3, f
	goto    delay_loop3
	decfsz  delay_count2, f
	goto    delay_loop2
	decfsz  delay_count1, f
	goto    delay_loop1
	return

    start
	bsf     STATUS, RP0
	movlw   b'00000011'
	movwf   TRISA
	movlw   b'00000000'
	movwf   TRISB
	bcf     STATUS, RP0

	movlw   b'00000111'
	movwf   CMCON

	clrf    PORTA
	clrf    PORTB

    wait_for_start
	btfss   PORTA, BTN_INICIO
	goto    wait_for_start

    main_loop
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	bcf     PORTB, S1_ROJO
	bcf     PORTA, S1_AMARILLO
	bsf     PORTA, S1_VERDE
	bcf     PORTB, S2_VERDE
	bcf     PORTB, S2_AMARILLO
	bsf     PORTB, S2_ROJO
	call    delay_1s
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	bcf     PORTA, S1_VERDE
	bsf     PORTA, S1_AMARILLO
	call    delay_1s
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	bcf     PORTA, S1_AMARILLO
	bsf     PORTB, S1_ROJO
	bcf     PORTB, S2_ROJO
	bsf     PORTB, S2_VERDE
	call    delay_1s
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	bcf     PORTB, S2_VERDE
	bsf     PORTB, S2_AMARILLO
	call    delay_1s
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	bcf     PORTB, S2_AMARILLO
	bsf     PORTB, S2_ROJO
	bcf     PORTB, S1_ROJO
	bsf     PORTA, S1_VERDE
	call    delay_1s
	btfsc   PORTA, BTN_DETENER
	goto    stop_lights

	goto    main_loop

    stop_lights
	clrf    PORTA
	clrf    PORTB
	goto    wait_for_start

    end
