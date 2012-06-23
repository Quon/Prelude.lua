Prelude.lua
===========
Concept from [Haskell Prelude](http://www.haskell.org/ghc/docs/latest/html/libraries/base/Prelude.html) and [Lua Code for Curry (Currying Functions)](http://tinylittlelife.org/?p=249)
test under Lua 5.2
## ==example==
  \> require"Prelude"   
  \> a = Prelude.each   
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
  
## ==performance test==
code:
  run100k = function(f)   
    local t1 = os.clock()   
    for i=1,100000 do   
      f(i, i+1)   
    end   
    local t2 = os.clock()   
    print(t2 - t1)   
  end   

  run100k(function(x,y) return x+y end)   
  run100k(Prelude.curry(function(x,y) return x+y end,2))   
  run100k(Prelude.call_warpper(Prelude.curry(function(x,y) return x+y end,2)))   
  
  result on my pc:
  \> run100k(function(x,y) return x+y end)   
  0.024999999999864   
  \> run100k(Prelude.curry(function(x,y) return x+y end,2))   
  0.46799999999985   
  \> run100k(Prelude.call_warpper(Prelude.curry(function(x,y) return x+y end,2)))   
  1.885   
  
  so, just for fun.