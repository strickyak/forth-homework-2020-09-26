\ Print 5 largest primes less than 10000.  strick for  gforth

10000 constant N   \ limit of seive (exclusive)
5 constant K       \ how many primes to print
1 constant TRUE
0 constant FALSE
create sieve  N cells  allot  \ the array sieve

: top-primes
  N 0 do  FALSE  sieve i cells +  !  loop  \ clear the sieve
  
  N 2 /  2  do
    N  i 2 *  ?do
      TRUE   sieve i cells +  !
    j +loop
  loop
  K
  ( k ) N 0 do  \ loop forward, but meaning is backward: N 1 - i -
    ( k ) sieve  N 1 - i - cells + @  FALSE =  if
        ( K ) N 1 - i - .      \ print the prime
        ( K ) 1 -              \ decrement k
        then
    ( k ) dup 0 = if drop leave then  \ leave after printing 5 primes.
  loop
;
top-primes
