\ Plot x**2 for x in 0 to 10.    strick for gforth

40 constant H   \ screen height
72 constant W   \ screen width

42 constant STAR
46 constant DOT
32 constant SP
124 constant VBAR
45 constant DASH
48 constant ZERO
: digit ( n -- ch ) ZERO + ;   \ compute ascii digit

\ ---- screen graphics -----
create screen  H W * cells allot
: set-char ( x y ch -- ) rot rot  W * + cells screen + ! ;
: set-blank ( x y -- ) SP set-char ;
: set-star ( x y -- ) 42 set-char ;                                \ sets '*'
: cls ( -- ) H 0 do  W 0 do  i j set-blank  loop loop ;            \ clear screen
: emit-char ( x y -- ch ) W * + cells screen + @ emit ;            \ print one char from screen
: display ( -- ) cr H 0 do  W 0 do  i j emit-char  loop cr loop ;  \ print result
10000 constant XMAX000
100000 constant YMAX000
: draw-point-fixed-millis ( x000 y000 ch -- )
    rot rot         \ push char down to bottom
    YMAX000 swap -  \ flip screen so y000 increases bottom to top
    H * YMAX000 /  0 max   H 1 - min  \ y -> integer from 0 to H
    swap                              \ x on top
    W * XMAX000 /  0 max   W 1 - min  \ x -> integer from 0 to W
    swap                              \ y on top again
    rot set-char ;   \ recover the char & set it.
\ --------------------------
: draw-x-squared
  XMAX000 0 do   i   i dup * 1000 /   35 draw-point-fixed-millis  loop ;
: draw-x-axis
      XMAX000 0 do   i   0   45 draw-point-fixed-millis  loop 
      YMAX000 0 do  11 1 do i 1000 *   j  DOT  draw-point-fixed-millis  loop loop 
      10 0 do i 1000 *   0  48 i +  draw-point-fixed-millis  loop ;
: draw-y-axis
      YMAX000 0 do   0   i   VBAR draw-point-fixed-millis  loop
      XMAX000 0 do  11 1 do  j   i 10 * 1000 *     DOT  draw-point-fixed-millis  loop  loop
      10 0 do  0   i 10 * 1000 *     i digit  draw-point-fixed-millis  loop \ first digit
      10 0 do  XMAX000 W / 1 +   i 10 * 1000 *     0 digit  draw-point-fixed-millis  loop ; \ second digit

cls  draw-x-axis draw-y-axis draw-x-squared  display bye
