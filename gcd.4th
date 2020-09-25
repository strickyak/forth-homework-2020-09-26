\ Problem 2: Print an GCD table.    strick for gforth

: gcd ( a b -- z )
  ( a b ) dup 0 = if  drop exit  then
  ( a b ) over 0 = if  swap drop exit  then
  ( a b ) 2dup < if
      ( a b ) over mod  recurse   else
      ( a b ) dup rot   swap mod  recurse   then
  ;
: 3d.  \ fixed-length, print a 3 digit number and a space.
  dup 100 >= if  . exit then
  dup 10 >= if   ."  "  . exit then
  ."   "  .
  ;
: gcd-table cr
  ."      : "
  10 0 do i
    240 i + 3d.
  loop cr
  10 0 do
    170 i + 3d.
    ."  : "
    10 0 do
      i 240 +   j 170 +   gcd 3d.
    loop cr
  loop cr
  ;
gcd-table
