#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
    putchar(bit + 48);
}


void display_32(int32_t num) {
    for (int i = 31; i>=0; i--) {
        int bin = (1<<i);
        if (!(num & bin)){
            display (0);
        } else {
            display(1);
        }
    }

    
}

int main(int argc, char const *argv[]) {
    int32_t x = 382;
    display_32(x);

    return 0;
}
