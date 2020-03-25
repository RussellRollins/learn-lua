#! /usr/bin/env lua

--- 6 More about Functions

--- Functions are first class citizens. But what does this mean?
--- They have all the same rights of any other value. They can be in variables,
--- they can be in tables, they can be passed as arguments or returned by
--- functions.

--- Functions are anonymous. The names we use to refer to them are just
--- variables, and like any variable we can do stuff to 'em.
a = {p = print}
a.p("Hello, World!")
print = math.sin --- Oh no
a.p(print(1))
print = a.p

--- The normal variable declaration is just syntactical sugar.
function foo (x) return 2*x end
print(foo(2))

--- We could do the same thing just declaring a variable.
foo = function (x) return 2*x end
print(foo(2))

--- Lua also supports higher order functions, one example is sort, which takes
--- a comparator function.
network = {
    {name = "grauna",  IP = "210.26.30.34"},
    {name = "arraial", IP = "210.26.30.23"},
    {name = "lua",     IP = "210.26.23.12"},
    {name = "derain",  IP = "210.26.23.20"},
}
table.sort(network, function (a,b)
  return (a.name > b.name)
end)

--- 6.1 Closures

--- A function contained inside another function has full access to the
--- variables of the enclosing function. This is called lexical scoping and
--- the authors of the book seem quite proud of it.

names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}

function sortbygrade(names, grades)
  table.sort(names, function(n1, n2)
    --- We access grades, even though it is not an argument to this anonymous
    --- function.
    return grades[n1] > grades[n2]
  end)
end

sortbygrade(names, grades)

--- Accessing a variable from your parent function's lexical scope is neither
--- a local nor global variable. Known as external local variable, or "upvalue"

--- We can combine anonymous functions with upvalues to create a "closure", a
--- closure is a function plus all it needs to access its upvalues correctly

function newCounter()
    local count = 0
    return function ()
        count = count + 1
        return count
    end
end

c = newCounter()
print(c())
print(c())
c2 = newCounter()
print(c2())
print(c())

--- Closures are also useful to create callback functions.

--- Closures can also be used to redefine an existing function (oh boy).
do
  local oldSin = math.sin
  local k = math.pi/180
  math.sin = function (x)
    return oldSin(x*k)
  end
end

print(math.sin(1))

--- 6.2 Non-Global Functions

--- First class functions are how we implement library type functions, such as
--- math.foo. They're just a table full of functions.

Lib = {}
Lib.foo = function (x,y) return x + y end

print(Lib.foo(10, 12))

--- Or a table constructor
Lib = {
    foo = function(x,y) return x + y end
}

print(Lib.foo(10, 12))

--- Or a special syntax just for this
Lib = {}
function Lib.foo (x,y)
  return x + y
end

print(Lib.foo(10, 12))

--- We can make local functions which are scoped like other chunks

local f = function()

end

--- Or a special syntax for same

local function f()

end

--- This can mess with recursion a bit. If you need a locally recursive deal,
--- predefine or "forward" declaration it.

--- 6.3 Proper Tail Calls

--- A tail call happens when the last action of a function is to call another
--- function. In this case, the program never needs to return control to the
--- calling function. Lua can optimize this sort of tail call such that no
--- extra stack is used.

--- This function will never overflow the stack in Lua, no matter how big a
--- number we pass in.

function foo (n)
    if n > 0 then return foo(n - 1) end
end

--- In Lua _only_ a call of return g(...) is a true tail call. Any operation
--- including discarding values of a return will break it.

--- These are useful for building state machines, for instance, since no matter
--- how many states you pass through, no overflow.
