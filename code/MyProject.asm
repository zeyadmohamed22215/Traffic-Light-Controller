
_traffic:

;MyProject.c,12 :: 		void traffic(signed char counter) {
;MyProject.c,13 :: 		porte.b0 = 1;
	BSF        PORTE+0, 0
;MyProject.c,14 :: 		left = counter / 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_traffic_counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      _left+0
;MyProject.c,15 :: 		right = counter % 10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_traffic_counter+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;MyProject.c,16 :: 		portc = right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;MyProject.c,17 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_traffic0:
	DECFSZ     R13+0, 1
	GOTO       L_traffic0
	DECFSZ     R12+0, 1
	GOTO       L_traffic0
	NOP
;MyProject.c,18 :: 		portd = left;
	MOVF       _left+0, 0
	MOVWF      PORTD+0
;MyProject.c,19 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_traffic1:
	DECFSZ     R13+0, 1
	GOTO       L_traffic1
	DECFSZ     R12+0, 1
	GOTO       L_traffic1
	NOP
;MyProject.c,20 :: 		}
L_end_traffic:
	RETURN
; end of _traffic

_main:

;MyProject.c,21 :: 		void main() {
;MyProject.c,22 :: 		ADCON1 = 0x07;
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,23 :: 		trisb = 0b00000001;
	MOVLW      1
	MOVWF      TRISB+0
;MyProject.c,24 :: 		trisc = 0x00;
	CLRF       TRISC+0
;MyProject.c,25 :: 		trisd = 0x00;
	CLRF       TRISD+0
;MyProject.c,26 :: 		trisa = 0xff;
	MOVLW      255
	MOVWF      TRISA+0
;MyProject.c,27 :: 		trise = 0x00;
	CLRF       TRISE+0
;MyProject.c,28 :: 		while (1) {
L_main2:
;MyProject.c,29 :: 		if (portb.b0 == 0){
	BTFSC      PORTB+0, 0
	GOTO       L_main4
;MyProject.c,30 :: 		if (porta.b0 == 0){south();}
	BTFSC      PORTA+0, 0
	GOTO       L_main5
	CALL       _south+0
	GOTO       L_main6
L_main5:
;MyProject.c,31 :: 		else{west();}
	CALL       _west+0
L_main6:
;MyProject.c,32 :: 		}
	GOTO       L_main7
L_main4:
;MyProject.c,35 :: 		automatic();
	CALL       _automatic+0
L_main7:
;MyProject.c,36 :: 		}
	GOTO       L_main2
;MyProject.c,37 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_automatic:

;MyProject.c,39 :: 		void automatic() {
;MyProject.c,40 :: 		for (;;) {
L_automatic8:
;MyProject.c,41 :: 		for (counter = 23; counter >= 0; counter--) {
	MOVLW      23
	MOVWF      _counter+0
L_automatic11:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic12
;MyProject.c,42 :: 		if (portb.b0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_automatic14
;MyProject.c,43 :: 		if (porta.b0 == 0){south();}
	BTFSC      PORTA+0, 0
	GOTO       L_automatic15
	CALL       _south+0
	GOTO       L_automatic16
L_automatic15:
;MyProject.c,44 :: 		else{west();}
	CALL       _west+0
L_automatic16:
;MyProject.c,45 :: 		}
L_automatic14:
;MyProject.c,46 :: 		red1 = 0;yellow1 = 1;green1 = 0;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,47 :: 		red2 = 1;yellow2 = 0;green2 = 0;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,48 :: 		if (counter <= 20) {yellow1 = 0;green1 = 1;}
	MOVLW      128
	XORLW      20
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic17
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
L_automatic17:
;MyProject.c,49 :: 		for (i = 0; i <= 50; i++) {
	CLRF       _i+0
L_automatic18:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_automatic19
;MyProject.c,50 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,49 :: 		for (i = 0; i <= 50; i++) {
	INCF       _i+0, 1
;MyProject.c,51 :: 		}
	GOTO       L_automatic18
L_automatic19:
;MyProject.c,41 :: 		for (counter = 23; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,52 :: 		}
	GOTO       L_automatic11
L_automatic12:
;MyProject.c,53 :: 		for (counter = 15; counter >= 0; counter--) {
	MOVLW      15
	MOVWF      _counter+0
L_automatic21:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic22
;MyProject.c,54 :: 		if (portb.b0 == 0) {
	BTFSC      PORTB+0, 0
	GOTO       L_automatic24
;MyProject.c,55 :: 		if (porta.b0 == 0){south();}
	BTFSC      PORTA+0, 0
	GOTO       L_automatic25
	CALL       _south+0
	GOTO       L_automatic26
L_automatic25:
;MyProject.c,56 :: 		else {west();}
	CALL       _west+0
L_automatic26:
;MyProject.c,57 :: 		}
L_automatic24:
;MyProject.c,58 :: 		red1 = 1;yellow1 = 0;green1 = 0;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,59 :: 		red2 = 0;yellow2 = 1;green2 = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,60 :: 		if (counter <= 12) {yellow2 = 0;green2 = 1;}
	MOVLW      128
	XORLW      12
	MOVWF      R0+0
	MOVLW      128
	XORWF      _counter+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_automatic27
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
L_automatic27:
;MyProject.c,61 :: 		for (i = 0; i <= 50; i++) {
	CLRF       _i+0
L_automatic28:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_automatic29
;MyProject.c,62 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,61 :: 		for (i = 0; i <= 50; i++) {
	INCF       _i+0, 1
;MyProject.c,63 :: 		}
	GOTO       L_automatic28
L_automatic29:
;MyProject.c,53 :: 		for (counter = 15; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,64 :: 		}
	GOTO       L_automatic21
L_automatic22:
;MyProject.c,65 :: 		}
	GOTO       L_automatic8
;MyProject.c,66 :: 		}
L_end_automatic:
	RETURN
; end of _automatic

_south:

;MyProject.c,67 :: 		void south() {
;MyProject.c,68 :: 		for (counter = 3; counter >= 0; counter--) {
	MOVLW      3
	MOVWF      _counter+0
L_south31:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_south32
;MyProject.c,69 :: 		red1 = 0;yellow1 = 1;green1 = 0;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,70 :: 		red2 = 0;yellow2 = 1;green2 = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,71 :: 		for (i = 0; i <= 50; i++) {
	CLRF       _i+0
L_south34:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_south35
;MyProject.c,72 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,71 :: 		for (i = 0; i <= 50; i++) {
	INCF       _i+0, 1
;MyProject.c,73 :: 		}
	GOTO       L_south34
L_south35:
;MyProject.c,68 :: 		for (counter = 3; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,74 :: 		}
	GOTO       L_south31
L_south32:
;MyProject.c,75 :: 		for (counter = 15; counter >= 0; counter--) {
	MOVLW      15
	MOVWF      _counter+0
L_south37:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_south38
;MyProject.c,76 :: 		red1 = 1;yellow1 = 0;green1 = 0;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,77 :: 		red2 = 0;yellow2 = 0;green2 = 1;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,78 :: 		if (portb.b0!=0) break;
	BTFSS      PORTB+0, 0
	GOTO       L_south40
	GOTO       L_south38
L_south40:
;MyProject.c,79 :: 		for (i = 0; i <= 50; i++) {
	CLRF       _i+0
L_south41:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_south42
;MyProject.c,80 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,79 :: 		for (i = 0; i <= 50; i++) {
	INCF       _i+0, 1
;MyProject.c,81 :: 		}
	GOTO       L_south41
L_south42:
;MyProject.c,75 :: 		for (counter = 15; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,82 :: 		}
	GOTO       L_south37
L_south38:
;MyProject.c,83 :: 		}
L_end_south:
	RETURN
; end of _south

_west:

;MyProject.c,84 :: 		void west() {
;MyProject.c,85 :: 		for (counter = 3; counter >= 0; counter--) {
	MOVLW      3
	MOVWF      _counter+0
L_west44:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_west45
;MyProject.c,86 :: 		red1 = 0;yellow1 = 1;green1 = 0;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,87 :: 		red2 = 0;yellow2 = 1;green2 = 0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,88 :: 		for (i = 0; i <= 50; i++) {
	CLRF       _i+0
L_west47:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_west48
;MyProject.c,89 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,88 :: 		for (i = 0; i <= 50; i++) {
	INCF       _i+0, 1
;MyProject.c,90 :: 		}
	GOTO       L_west47
L_west48:
;MyProject.c,85 :: 		for (counter = 3; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,91 :: 		}
	GOTO       L_west44
L_west45:
;MyProject.c,92 :: 		for (counter = 23; counter >= 0; counter--) {
	MOVLW      23
	MOVWF      _counter+0
L_west50:
	MOVLW      128
	XORWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_west51
;MyProject.c,93 :: 		red1 = 0;yellow1 = 0;green1 = 1;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;MyProject.c,94 :: 		red2 = 1;yellow2 = 0;green2 = 0;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;MyProject.c,95 :: 		if (portb.b0!=0) break;
	BTFSS      PORTB+0, 0
	GOTO       L_west53
	GOTO       L_west51
L_west53:
;MyProject.c,96 :: 		for (i = 0; i <=50; i++) {
	CLRF       _i+0
L_west54:
	MOVF       _i+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_west55
;MyProject.c,97 :: 		traffic(counter);
	MOVF       _counter+0, 0
	MOVWF      FARG_traffic_counter+0
	CALL       _traffic+0
;MyProject.c,96 :: 		for (i = 0; i <=50; i++) {
	INCF       _i+0, 1
;MyProject.c,98 :: 		}
	GOTO       L_west54
L_west55:
;MyProject.c,92 :: 		for (counter = 23; counter >= 0; counter--) {
	DECF       _counter+0, 1
;MyProject.c,99 :: 		}
	GOTO       L_west50
L_west51:
;MyProject.c,100 :: 		}
L_end_west:
	RETURN
; end of _west
