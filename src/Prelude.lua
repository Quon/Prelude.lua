--usage: require"Prelude"

local print = print
local tavle = table
local pairs = pairs
local table = table
Prelude = {}

--reverse from http://lua-users.org/wiki/CurriedLua
-- reverse(...) : take some tuple and return a tuple of elements in reverse order
--                  
-- e.g. "reverse(1,2,3)" returns 3,2,1
function Prelude.reverse(...)

  --reverse args by building a function to do it, similar to the unpack() example
  local function reverse_h(acc, v, ...)
    if 0 == select('#', ...) then
      return v, acc()
    else
      return reverse_h(function() return v, acc() end, ...)
    end
  end

  -- initial acc is the end of the list
  return reverse_h(function() return end, ...)
end

local reverse = Prelude.reverse

--curry from http://lua-users.org/wiki/CurriedLua
-- curry(func, num_args) : take a function requiring a tuple for num_args arguments
--                         and turn it into a series of 1-argument functions
-- e.g.: you have a function dosomething(a, b, c)
-- curried_dosomething = curry(dosomething, 3) -- we want to curry 3 arguments
-- curried_dosomething (a1) (b1) (c1) -- returns the result of dosomething(a1, b1, c1)
-- partial_dosomething1 = curried_dosomething (a_value) -- returns a function
-- partial_dosomething2 = partial_dosomething1 (b_value) -- returns a function
-- partial_dosomething2 (c_value) -- returns the result of dosomething(a_value, b_value, c_value)
function Prelude.curry(func, num_args)

  -- currying 2-argument functions seems to be the most popular application
  num_args = num_args or 2

  -- no sense currying for 1 arg or less
  if num_args <= 1 then return func end

  -- helper takes an argtrace function, and number of arguments remaining to be applied
  local function curry_h(argtrace, n)
    if 0 == n then
      -- kick off argtrace, reverse argument list, and call the original function
      return func(reverse(argtrace()))
    else
      -- "push" argument (by building a wrapper function) and decrement n
      return function(onearg)
        return curry_h(function() return onearg, argtrace() end, n - 1)
      end
    end
  end

  -- push the terminal case of argtrace into the function first
  return curry_h(function() return end, num_args)
end

local curry = Prelude.curry

function Prelude.call_warpper(f)
  return function(...)
    local arg = table.pack(...)
    if arg.n == 0 then
      return f()
    else
      local f1 = f
      for i = 1, arg.n do
        f1 = f1(arg[i])
      end
      return f1
    end
  end
end

local call_warpper = Prelude.call_warpper

Prelude.each = call_warpper(curry(function(f, xs)
  for k, v in pairs(xs) do
    f(k, v)
  end
  return xs
end, 2))

return Prelude