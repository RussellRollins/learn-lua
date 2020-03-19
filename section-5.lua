#! /usr/bin/env lua

--- 5 Functions

--- They're functions. They work like functions.
--- Parenthesis are required, unless the function takes a single argument
--- and that argument is a string literal or a table constructor.
print "Hello World"
print {}
print(1)

--- Declaration
function add(a)
    local sum = 0
    for i,v in ipairs(a) do
        sum = sum + v
    end
    return sum
end

print("sum", add({1, 3, 5}))

--- There's also a special operator for object oriented programming
--- o:foo(x) is a simplified version of o.foo(o, x)
Account = {balance = 0}
function Account:withdraw(v)
  self.balance = self.balance - v
end
Account:withdraw(10)
print("balance", Account.balance)

--- It's okay to call a function with two many arguments, or too few.
--- Extras thrown away, missing get nil.
function russtype(a)
  return type(a)
end

print(russtype())
print(russtype(1, 2, 3))

--- 5.1 Mutiple Results

--- Functions can return multiple results.
start_match, end_match = string.find("hello World!", "!")
print(start_match, end_match)

--- Just seperate them with commas when you return.
function multi(a, b)
    return a, b
end

--- We only use the multiple returned values in certain cases,
--- multiple assignment, arguments to function calls, table constructors, and
--- return statements. This follows the same rules of default nil, drop extras.

print(multi("one", "two"))

--- Can force a single response with a pair of parens.
print((multi("one", "two")))

--- Unpack is a helper that returns all elements from an array starting at
--- index 1. (note, as of 5.2, it's in table.unpack)
print(table.unpack{10,20,30})

--- 5.2 Variable Number of Arguments

--- Some things can take any number of arguments. Use ..., it is put in a
--- table at arg, with the field n for number of arguments.
--- Note: That is _not true anymore_. The syntax has changed as of 5.1. The
--- ... variable can be accessed directly. To get the count, use select(#, ...)
--- to get the actual variables, use select(n, ...), to get the nth variable
--- and on.

function RussPrint(...)
    print("russell", select("#", ...), select(1, ...))
end
RussPrint(10, 20, 30)

--- 5.3 Named Arguments

--- Lua only has positional arguments. To make named arguments, pass in a table.
function Doer(arg)
    print(arg.foo, arg.bar)
end
Doer{foo="foo", bar="bar"}
