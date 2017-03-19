
#include <stdio.h>
#include <stdlib.h>

/*
 *  A sample c program of the easter algorithm to be used as a template for 
 *  the assembly level program
 */

int main(int argc, char * args[]) {

    if(argc < 2) {
        printf("Please enter the year as an argument\n");
        exit(1);
    }
    // get the desired year 
    int Y = atoi(args[1]);
    
    // calculate golden number for year Y
    int G = (Y % 19) + 1;

    // calculate century
    int C = (Y / 100) + 1;

    // X the number of leap years that were dropped
    int X = (3*C / 4) - 12;

    //  Z (synchronize Easter with the moons orbit)
    int Z = ((8*C + 5) / 25) - 5;

    // D Sunday
    int D = (5*Y / 4) - X - 10;

    //E "Epact" 
    int E = (11*G + 20 + Z - X) % 30;
    if((E == 25 && G > 11) || E == 24)
        E++;

    //N Full Moon
    int N = 44 - E;
    if(N < 21)
        N += 30;

    // Advancing N to be a Sunday
    N = N + 7 - ((D + N) % 7);

    //Extracting month M from N
    int M;
    if(N > 31){
        M = 4;
        N -= 31;
    }else{
        M = 3;
    }

    if(M == 3){
        printf("Easter Sunday is on March %d, %d\n", N, Y);
    }else{
        printf("Easter Sunday is on April %d, %d\n", N, Y);
    }

    return 0;

}
