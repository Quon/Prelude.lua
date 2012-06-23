Prelude.lua
===========
Concept from [Haskell Prelude](http://www.haskell.org/ghc/docs/latest/html/libraries/base/Prelude.html) and [Lua Code for Curry (Currying Functions)](http://tinylittlelife.org/?p=249)

# ==example==
  \> require"Prelude"   
  \> a = Prelude.call_warpper(Prelude.each)   
  \> a(print,table)   
  concat  function: 01255430   
  pack    function: 01255710   
  sort    function: 012559B0   
  unpack  function: 01255820   
  remove  function: 01255300   
  insert  function: 012551A0   
  \> print(a)   
  function: 006DF7A0   
  \> print(a(print))   
  function: 005E33A0   
  \> print(a(print)(table))   
  concat  function: 01255430   
  pack    function: 01255710   
  sort    function: 012559B0   
  unpack  function: 01255820   
  remove  function: 01255300   
  insert  function: 012551A0   
  table: 006D9ED8   
  \>   