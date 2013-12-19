#line 1 "E:/12f683-led-candle/12f683_led_candle.c"
#line 8 "E:/12f683-led-candle/12f683_led_candle.c"
int flicker_low_min = 120;
int flicker_low_max = 160;


int flicker_high_min = 230;
int flicker_high_max = 255;



int flicker_hold_min = 40;
int flicker_hold_max = 80;



int flicker_pause_min = 100;
int flicker_pause_max = 200;


int flicker_speed_min = 800;
int flicker_speed_max = 1100;

int flicker_random_low_start = 0;
int flicker_random_low_end = 0;
int flicker_random_high = 0;
int flicker_random_speed_start = 0;
int flicker_random_speed_end = 0;

int i;


int random(int minVal, int maxVal){
 return minVal+(rand()%(maxVal-minVal+1));;
}

void main() {
 OSCCON = 0b01000111;
 ADCON0 = 0;
 CMCON0 = 7;

 ANSEL = 0;
 TRISIO = 0;
 GPIO=0;

 PWM1_Init(5000);
 PWM1_Start();


 while (1) {

 flicker_random_low_start = random(flicker_low_min, flicker_low_max);
 flicker_random_low_end = random(flicker_low_min, flicker_low_max);


 flicker_random_high = random(flicker_high_min, flicker_high_max);


 flicker_random_speed_start = random(flicker_speed_min, flicker_speed_max);
 flicker_random_speed_end = random(flicker_speed_min, flicker_speed_max);


 for (i = flicker_random_low_start; i<flicker_random_high; i++) {
 PWM1_Set_Duty(i);


 Delay_cyc(flicker_random_speed_start);
 }


 VDelay_ms(random(flicker_hold_min, flicker_hold_max));


 for (i = flicker_random_high; i>=flicker_random_low_end; i--) {
 PWM1_Set_Duty(i);
 Delay_cyc(flicker_random_speed_end);
 }


 VDelay_ms(random(flicker_pause_min, flicker_pause_max));
 }
}
