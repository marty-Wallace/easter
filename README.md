# easter
Sparc assembly program to calculate the date of easter for a given year

The following easter algorithm taken from "SPARC Architecture Assembly Language Programming Language, and C" Second Edition By Richard P. Paul. 

This algorithm is historically significant as it was one of the main applications of arithmitec in the middle ages, used by the Catholic Church to calculate the date of easter each year. 

1. Start by setting the Year Y for the date we want to find easter on

Y = 1984

1. Compute the golden number G for the year Y

    G = (Y mod 19) + 1


1. Compute the century C for year Y
    C = (Y / 100) + 1


1. Compute X (the number of years, such as 1900, in which the leap year was dropped in order to keep up with the sun)
    X = (3C / 4) - 12


1. Compute Z (a special correction designed to synchronize Easter with the moons orbit)
    Z = ((8C + 5) / 25) - 5


1. Compute Sunday 
    D = (5Y / 4) - X - 10


1. Find the "epact" E. 
    E = (11G + 20 + Z - X) mod 30
    if (E == 25 and G > 11) or E == 24:
        E++
    

1. Now find the full moon, N
    N = 44 - E
    if N < 21:
        N += 30


1. Now Advance N to be a sunday
    N = N + 7 - ((D + N) mod 7)
    

1. Extract the month M
    if N > 31:
        M = 4
        N -= 31
    else:
        M = 3

    
    


