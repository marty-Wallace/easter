## easter
Sparc assembly program to calculate the date of easter for a given year

### to run
```
bash$ m4 easter.m4 > easter.s 
bash$ gcc -g easter.s -o easter
bash$ gdb easter

(gdb) break input
Breakpoint 1 at 0x10710

(gdb) break end
Breakpoint 2 at 0x1080c

(gdb) r
Starting program: /home/oksun6/student/mwallace/easter
(no debugging symbols found)...(no debugging symbols found)...(no debugging symbols found)...
Breakpoint 1, 0x00010710 in input ()

(gdb) set $i0 = 1998

(gdb) c
Continuing.

Breakpoint 2, 0x0001080c in out ()

(gdb) printf "Easter occurs on %d/%d/%d\n", $l6, $l7, $i0
Easter occurs on 12/4/1998
```

The following easter algorithm taken from "SPARC Architecture Assembly Language Programming Language, and C" Second Edition By Richard P. Paul. 

This algorithm is historically significant as it was one of the main applications of arithmitec in the middle ages, used by the Catholic Church to calculate the date of easter each year. 

    1. Start by setting the Year Y for the date we want to find easter on
        Y = 1984

    2. Compute the golden number G for the year Y
        G = (Y mod 19) + 1


    3. Compute the century C for year Y
        C = (Y / 100) + 1


    4. Compute X (the number of years, such as 1900, in which the leap year was dropped in order to keep up with the sun)
        X = (3C / 4) - 12


    5. Compute Z (a special correction designed to synchronize Easter with the moons orbit)
        Z = ((8C + 5) / 25) - 5


    6. Compute Sunday 
        D = (5Y / 4) - X - 10


    7. Find the "epact" E. 
        E = (11G + 20 + Z - X) mod 30
        if (E == 25 and G > 11) or E == 24:
            E++
        

    8. Now find the full moon, N
        N = 44 - E
        if N < 21:
            N += 30


    9. Now Advance N to be a sunday
        N = N + 7 - ((D + N) mod 7)
        

    10. Extract the month M
        if N > 31:
            M = 4
            N -= 31
        else:
            M = 3

