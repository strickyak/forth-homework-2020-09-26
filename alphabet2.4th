\ Print alphabet in alternating case.   strick for gforth

s" NoPqRsTuVwXyZaBcDeFgHiJkLm"  \ pay no attention
constant MAGIC_LEN              \ to that man
constant MAGIC_ADDR             \ behind the curtain

13 constant M     \ M is 13th letter of alphabet.
31 constant MASK  \ Removes bits marking upper/lower/figs.

: rot13c ( char -- char )
  dup MASK and M <= if
     M else
     M negate then
  + ;

: .rot13s ( addr len -- )
  2dup
    ( addr len ) 0 do
      ( addr ) dup i + c@ rot13c emit
    loop drop ;

cr cr MAGIC_ADDR MAGIC_LEN .rot13s cr
