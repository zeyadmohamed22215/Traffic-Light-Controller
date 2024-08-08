sbit red1 at rb1_bit;
sbit yellow1 at rb2_bit;
sbit green1 at rb3_bit;
sbit red2 at rb4_bit;
sbit yellow2 at rb5_bit;
sbit green2 at rb6_bit;
char left, right, i;
signed char counter;
void south();
void west();
void automatic();
void traffic(signed char counter) {
    porte.b0 = 1;
    left = counter / 10;
    right = counter % 10;
    portc = right;
    delay_ms(10);
    portd = left;
    delay_ms(10);
}
void main() {
    ADCON1 = 0x07;
    trisb = 0b00000001;
    trisc = 0x00;
    trisd = 0x00;
    trisa = 0xff;
    trise = 0x00;
    while (1) {
        if (portb.b0 == 0){
         if (porta.b0 == 0){south();}
                        else{west();}
        }

        else
       automatic();
    }
}

void automatic() {
    for (;;) {
        for (counter = 23; counter >= 0; counter--) {
            if (portb.b0 == 0) {
                     if (porta.b0 == 0){south();}
                        else{west();}
            }
            red1 = 0;yellow1 = 1;green1 = 0;
            red2 = 1;yellow2 = 0;green2 = 0;
            if (counter <= 20) {yellow1 = 0;green1 = 1;}
            for (i = 0; i <= 50; i++) {
                traffic(counter);
            }
        }
        for (counter = 15; counter >= 0; counter--) {
            if (portb.b0 == 0) {
                 if (porta.b0 == 0){south();}
                 else {west();}
            }
            red1 = 1;yellow1 = 0;green1 = 0;
            red2 = 0;yellow2 = 1;green2 = 0;
            if (counter <= 12) {yellow2 = 0;green2 = 1;}
            for (i = 0; i <= 50; i++) {
                traffic(counter);
            }
        }
    }
}
void south() {
            for (counter = 3; counter >= 0; counter--) {
        red1 = 0;yellow1 = 1;green1 = 0;
        red2 = 0;yellow2 = 1;green2 = 0;
        for (i = 0; i <= 50; i++) {
            traffic(counter);
        }
    }
        for (counter = 15; counter >= 0; counter--) {
            red1 = 1;yellow1 = 0;green1 = 0;
            red2 = 0;yellow2 = 0;green2 = 1;
            if (portb.b0!=0) break;
            for (i = 0; i <= 50; i++) {
                traffic(counter);
            }
        }
}
void west() {
        for (counter = 3; counter >= 0; counter--) {
        red1 = 0;yellow1 = 1;green1 = 0;
        red2 = 0;yellow2 = 1;green2 = 0;
        for (i = 0; i <= 50; i++) {
            traffic(counter);
        }
    }
        for (counter = 23; counter >= 0; counter--) {
            red1 = 0;yellow1 = 0;green1 = 1;
            red2 = 1;yellow2 = 0;green2 = 0;
            if (portb.b0!=0) break;
            for (i = 0; i <=50; i++) {
                traffic(counter);
            }
        }
}