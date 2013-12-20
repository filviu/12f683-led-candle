
_random:

;12f683_led_candle.c,38 :: 		int random(int minVal, int maxVal){
;12f683_led_candle.c,39 :: 		return minVal+(rand()%(maxVal-minVal+1));;
	CALL       _rand+0
	MOVF       FARG_random_minVal+0, 0
	SUBWF      FARG_random_maxVal+0, 0
	MOVWF      R2+0
	MOVF       FARG_random_minVal+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_random_maxVal+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	ADDLW      1
	MOVWF      R4+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R2+1, 0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       FARG_random_minVal+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_random_minVal+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;12f683_led_candle.c,40 :: 		}
L_end_random:
	RETURN
; end of _random

_main:

;12f683_led_candle.c,42 :: 		void main() {
;12f683_led_candle.c,43 :: 		OSCCON = 0b01000111;                     // internal oscillator at 1MHz
	MOVLW      71
	MOVWF      OSCCON+0
;12f683_led_candle.c,44 :: 		ADCON0 = 0;                              // ADC disabled
	CLRF       ADCON0+0
;12f683_led_candle.c,45 :: 		CMCON0 = 7;                              // comparator disabled
	MOVLW      7
	MOVWF      CMCON0+0
;12f683_led_candle.c,47 :: 		ANSEL =  0;                              // pins are digital
	CLRF       ANSEL+0
;12f683_led_candle.c,48 :: 		TRISIO = 0;                              // pins are output
	CLRF       TRISIO+0
;12f683_led_candle.c,49 :: 		GPIO=0;                                  // pins are low
	CLRF       GPIO+0
;12f683_led_candle.c,51 :: 		PWM1_Init(5000);                         // Init PWM1 with 5kHz
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;12f683_led_candle.c,52 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;12f683_led_candle.c,55 :: 		while (1) {
L_main0:
;12f683_led_candle.c,57 :: 		flicker_random_low_start = random(flicker_low_min, flicker_low_max);
	MOVF       _flicker_low_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_low_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_low_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_low_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      _flicker_random_low_start+0
	MOVF       R0+1, 0
	MOVWF      _flicker_random_low_start+1
;12f683_led_candle.c,58 :: 		flicker_random_low_end = random(flicker_low_min, flicker_low_max);
	MOVF       _flicker_low_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_low_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_low_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_low_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      _flicker_random_low_end+0
	MOVF       R0+1, 0
	MOVWF      _flicker_random_low_end+1
;12f683_led_candle.c,61 :: 		flicker_random_high = random(flicker_high_min, flicker_high_max);
	MOVF       _flicker_high_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_high_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_high_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_high_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      _flicker_random_high+0
	MOVF       R0+1, 0
	MOVWF      _flicker_random_high+1
;12f683_led_candle.c,64 :: 		flicker_random_speed_start = random(flicker_speed_min, flicker_speed_max);
	MOVF       _flicker_speed_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_speed_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_speed_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_speed_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      _flicker_random_speed_start+0
	MOVF       R0+1, 0
	MOVWF      _flicker_random_speed_start+1
;12f683_led_candle.c,65 :: 		flicker_random_speed_end = random(flicker_speed_min, flicker_speed_max);
	MOVF       _flicker_speed_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_speed_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_speed_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_speed_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      _flicker_random_speed_end+0
	MOVF       R0+1, 0
	MOVWF      _flicker_random_speed_end+1
;12f683_led_candle.c,68 :: 		for (i = flicker_random_low_start; i<flicker_random_high; i++) {
	MOVF       _flicker_random_low_start+0, 0
	MOVWF      _i+0
	MOVF       _flicker_random_low_start+1, 0
	MOVWF      _i+1
L_main2:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _flicker_random_high+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main10
	MOVF       _flicker_random_high+0, 0
	SUBWF      _i+0, 0
L__main10:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
;12f683_led_candle.c,69 :: 		PWM1_Set_Duty(i);
	MOVF       _i+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;12f683_led_candle.c,72 :: 		Delay_cyc(flicker_random_speed_start);
	MOVF       _flicker_random_speed_start+0, 0
	MOVWF      FARG_Delay_Cyc_cycles_div_by_10+0
	CALL       _Delay_Cyc+0
;12f683_led_candle.c,68 :: 		for (i = flicker_random_low_start; i<flicker_random_high; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;12f683_led_candle.c,73 :: 		}
	GOTO       L_main2
L_main3:
;12f683_led_candle.c,76 :: 		VDelay_ms(random(flicker_hold_min, flicker_hold_max));
	MOVF       _flicker_hold_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_hold_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_hold_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_hold_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       R0+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;12f683_led_candle.c,79 :: 		for (i = flicker_random_high; i>=flicker_random_low_end; i--) {
	MOVF       _flicker_random_high+0, 0
	MOVWF      _i+0
	MOVF       _flicker_random_high+1, 0
	MOVWF      _i+1
L_main5:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _flicker_random_low_end+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main11
	MOVF       _flicker_random_low_end+0, 0
	SUBWF      _i+0, 0
L__main11:
	BTFSS      STATUS+0, 0
	GOTO       L_main6
;12f683_led_candle.c,80 :: 		PWM1_Set_Duty(i);
	MOVF       _i+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;12f683_led_candle.c,81 :: 		Delay_cyc(flicker_random_speed_end);
	MOVF       _flicker_random_speed_end+0, 0
	MOVWF      FARG_Delay_Cyc_cycles_div_by_10+0
	CALL       _Delay_Cyc+0
;12f683_led_candle.c,79 :: 		for (i = flicker_random_high; i>=flicker_random_low_end; i--) {
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;12f683_led_candle.c,82 :: 		}
	GOTO       L_main5
L_main6:
;12f683_led_candle.c,85 :: 		VDelay_ms(random(flicker_pause_min, flicker_pause_max));
	MOVF       _flicker_pause_min+0, 0
	MOVWF      FARG_random_minVal+0
	MOVF       _flicker_pause_min+1, 0
	MOVWF      FARG_random_minVal+1
	MOVF       _flicker_pause_max+0, 0
	MOVWF      FARG_random_maxVal+0
	MOVF       _flicker_pause_max+1, 0
	MOVWF      FARG_random_maxVal+1
	CALL       _random+0
	MOVF       R0+0, 0
	MOVWF      FARG_VDelay_ms_Time_ms+0
	MOVF       R0+1, 0
	MOVWF      FARG_VDelay_ms_Time_ms+1
	CALL       _VDelay_ms+0
;12f683_led_candle.c,86 :: 		}
	GOTO       L_main0
;12f683_led_candle.c,87 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
