#! /usr/bin/env lua

--- 7 Iterators and the Generic For

--- 7.1 Iterators and Closures

--- Closures often involve two functions, a closure (which does things) and a
--- factory. Which creates the closure and sets up external local variables.

function list_iter(tab)
  local i = 0
  --- local n = table.getn(t) getn is deprecated.
  local n = #tab
  return function ()
      i = i + 1
      if i <= n then return t[i] end
  end
end

t = {10, 20, 30}
for e in list_iter(t) do
  print(e)
end

--- 7.2 The Semantics of the Generic For

--- for <var-list> in <exp-list> do
---   <body>
--- end

--- Often, the expression is is just one element, an iterator factory.
--- That's not a requirement though, the expressions return 3 things:
---   1. The iterator function 
---   2. The invariant state
---   3. Initial value for the control variable.
--- For a simple iterator, 2 and 3 are discarded.

--- After initialization, the for calls the iterator with two arguments, the
--- invariant state and the control variable.

--- Next, for assigns the returned values to variables defined by its variable
--- list. If the first value is nil, it returns, otherwise, repeats.

--- 7.3 Stateless Iterators

--- On each iteration, the for loop calls its iterator with two arguments, the
--- invariant state and the control variable. A stateless iterator uses only
--- these two variables to generate the next value.

--- A good example is ipairs, which iterates an array. We could write it
--- ourselves if we wanted

function iter(invariant, control)
    local control = control + 1
    local v = invariant[control]
    if v then return control, v end
end

function ipairs(tab)
  return iter, tab, 0
end

for k,v in ipairs({"foo", "bar", "baz"}) do
  print(k, v)
end

--- Next is a built in that can iterate anything in a table. next(t, nil)
--- returns a random first pair. next(t, k), where k is a valid key returns a
--- random next pair.

t = {1, 2; foo="foo", bar="bar", baz="baz"}
for k, v in next, t, nil do
    print(k, v)
end

--- 7.4 Iterators with Complex State

--- Sometimes we need more state than we can cram in one invariant and one
--- control variable. Using a table, we can bring along as much information
--- as we want.

--- Closures are often a better option, but this is another choice.

--- Iterators can also be written with coroutines, which is complicated but
--- powerful, claims the book author.

--- 7.5 True Iterators

--- Instead of iterating with a for, we can also just make a function that
--- takes a function, and calls it on each thing. I don't understand the 
--- point of this chapter.
