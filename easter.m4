/* Author: Martin Wallace <martin.v.wallace@ieee.org> */

define(Y, i0)
define(G, l0)
define(C, l1)
define(X, l2)
define(Z, l3)
define(D, l4)
define(E, l5)
define(N, l6)
define(M, l7)

.global main
main:
save %sp, -96, %sp

/* put a year into Y */
mov 2000, %Y
.global input
input:


/*
    calculate golden number for year Y 
    int G = (Y % 19) + 1; 
*/

mov %Y, %o0
call .rem
mov 19, %o1
add %o0, 1, %G


/* 
    calculate century
    int C = (Y / 100) + 1;
*/

mov %Y, %o0
call .div
mov 100, %o1
add %o0, 1, %C


/*
    X the number of leap years that were dropped
    int X = (3*C / 4) - 12; 
*/

mov %C, %o0
call .mul
mov 3, %o1
call .div
mov 4, %o1
sub %o0, 12, %X



/*
    Z (synchronize Easter with the moons orbit)
    int Z = ((8*C + 5) / 25) - 5;
*/
mov %C, %o0
call .mul
mov 8, %o1
add %o0, 5, %o0
call .div
mov 25, %o1
sub %o0, 5, %Z



/*
    D Sunday
    int D = (5*Y / 4) - X - 10;
*/
mov %Y, %o0
call .mul
mov 5, %o1
call .div
mov 4, %o1
sub %o0, %X, %o0
sub %o0, 10, %D




/*
    E "Epact" part 1
    int E = (11*G + 20 + Z - X) % 30;
*/

mov %G, %o0
call .mul
mov 11, %o1
add %o0, 20, %o0
add %o0, %Z, %o0
sub %o0, %X, %o0
call .rem
mov 30, %o1
mov %o0, %E


/*
    E "Epact" part 2
    if((E == 25 && G > 11) || E == 24)
        E++;
*/

cmp %E, 24
be,a FullMoon
add %E, 1, %E
cmp %G, 11
ble FullMoon
nop
cmp %E, 25
be FullMoon
nop
add %E, 1, %E




FullMoon:


/*
    N Full Moon
    int N = 44 - E;
    if(N < 21)
        N += 30;
*/

mov 44, %o0
sub %o0, %E, %N
cmp %N, 21
bge Advancing
nop
add %N, 30, %N


Advancing:

/*
    Advancing N to be a Sunday
    N = N + 7 - ((D + N) % 7);
*/
add %D, %N, %o0
call .rem
mov 7, %o1
add %N, 7, %o1
sub %o1, %o0, %N


/* 
    Extracting month M from N
    int M;
    if(N > 31){
        M = 4;
        N -= 31;
    }else{
        M = 3;
    }
*/

cmp %N, 31
ble,a end
mov 3, %M
sub %N, 31, %N
mov 4, %M


.global end
end:
mov 1, %g1
ta 0

