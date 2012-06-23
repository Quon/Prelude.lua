Prelude.lua
===========
Concept from [Haskell Prelude](http://www.haskell.org/ghc/docs/latest/html/libraries/base/Prelude.html) and [Lua Code for Curry (Currying Functions)](http://tinylittlelife.org/?p=249)
test under Lua 5.2
## ==example==
  \> require"Prelude"   
  \> a = Prelude.each   
  \> a(print, {1,2,3,4,5})   
  1       1   
  2       2   
  3       3   
  4       4   
  5       5   
  \> print(a)   
  function: 00375870   
  \> print(a(print))   
  function: 0037FE60   
  \> print(a(print)({1,2,3,4,5}))   
  1       1   
  2       2   
  3       3   
  4       4   
  5       5   
  table: 00370B90   
  \>   
  
## ==performance test==
===code: ===  
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
  
 ===result on my pc:===  
  \> run100k(function(x,y) return x+y end)   
  0.024999999999864   
  \> run100k(Prelude.curry(function(x,y) return x+y end,2))   
  0.46799999999985   
  \> run100k(Prelude.call_warpper(Prelude.curry(function(x,y) return x+y end,2)))   
  1.885   
  
  so, just for fun.