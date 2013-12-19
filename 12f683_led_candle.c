/***************************************************
  uses code from http://ledhacker.blogspot.ro/
  adapted for 12f683 by Silviu Vulcan
  http://www.silviuvulcan.ro
***************************************************/

// the start of the flicker (low)
int flicker_low_min = 120;
int flicker_low_max = 160;

// the end value of the flicker (high)
int flicker_high_min = 230;
int flicker_high_max = 255;

// delay between each low-high-low cycle
// low->high |flicker_hold| high->low
int flicker_hold_min = 40;           // milliseconds
int flicker_hold_max = 80;           // milliseconds

// delay after each low-high-low cycle
// low->high->low |flicker_pause| low->high...
int flicker_pause_min = 100;         // milliseconds
int flicker_pause_max = 200;         // milliseconds

// delay low to high and high to low cycle
int flicker_speed_min = 800;         // microseconds
int flicker_speed_max = 1100;        // microseconds

int flicker_random_low_start = 0;
int flicker_random_low_end = 0;
int flicker_random_high = 0;
int flicker_random_speed_start = 0;
int flicker_random_speed_end = 0;

int i;

// crude function that returns a random value between an interval
int random(int minVal, int maxVal){
    return minVal+(rand()%(maxVal-minVal+1));;
}

void main() {
     OSCCON = 0b01000111;                     // internal oscillator at 1MHz
     ADCON0 = 0;                              // ADC disabled
     CMCON0 = 7;                              // comparator disabled

     ANSEL =  0;                              // pins are digital
     TRISIO = 0;                              // pins are output
     GPIO=0;                                  // pins are low

     PWM1_Init(5000);                         // Init PWM1 with 5kHz
     PWM1_Start();

// infinte loop
     while (1) {
           // random time for low
           flicker_random_low_start = random(flicker_low_min, flicker_low_max);
           flicker_random_low_end = random(flicker_low_min, flicker_low_max);

           // random time for high
           flicker_random_high = random(flicker_high_min, flicker_high_max);

           // random time for speed
           flicker_random_speed_start = random(flicker_speed_min, flicker_speed_max);
           flicker_random_speed_end = random(flicker_speed_min, flicker_speed_max);

           // low -> high
           for (i = flicker_random_low_start; i<flicker_random_high; i++) {
               PWM1_Set_Duty(i);
               // Delay_us does not accept variables
               // At 1Mhz it should be 1 cycle/us anyway
               Delay_cyc(flicker_random_speed_start);
           }

           // hold
           VDelay_ms(random(flicker_hold_min, flicker_hold_max));

           // high -> low
           for (i = flicker_random_high; i>=flicker_random_low_end; i--) {
               PWM1_Set_Duty(i);
               Delay_cyc(flicker_random_speed_end);
           }

           // pause
           VDelay_ms(random(flicker_pause_min, flicker_pause_max));
           }
}