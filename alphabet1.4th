\ Print alphabet in alternating case: AbCd...z    ; strick for gforth

30000 constant SIZE
create tape SIZE cells allot  \ The tape.

variable p                  \ Tape pointer.

: reset
  tape p !                  \ Initialize p to beginning of tape.
  SIZE 0 do
      0  i cells tape +  !  \ Clear the tape.
  loop ;
reset

: {-}  - ;   \ save - before redefining it.
: {+}  + ;   \ save + before redefining it.
: {.}  . ;   \ save . before redefining it.

: show           \ show begining of tape, and pointer.
    cr 10 0 do
    i cells tape {+}  p @  = if ." ^" then
    i cells tape {+} @ {.}
  loop cr ;

: -   p @ @   1 {-}        p @ !  ;  \  (*p)--;
: +   p @ @   1 {+}        p @ !  ;  \  (*p)++;
: .   p @ @   emit                ;  \  putchar(*p);
: <   p @     1 cells {-}  p !    ;  \  p--;
: >   p @     1 cells {+}  p !    ;  \  p++;


: [  POSTPONE begin  ; immediate
: ]        POSTPONE p POSTPONE @ POSTPONE @  
           POSTPONE while  
     POSTPONE repeat  ; immediate

: program

  > > > + + + + [ < + + + + [ < + + + + [ < + > - ] > - ] > - ] < < < +               show \ ^65

  > + + + + + + + + + + + + +                                                         show \ 65 ^13 _

  > > > > + + + + [ < + + + + + [ < + + + + + [ < + > - ] > - ] > - ] < < < - - <     show \ 65 ^13 98

  [
    < . + + >
    > . + + <
    -
  ]

;
program
