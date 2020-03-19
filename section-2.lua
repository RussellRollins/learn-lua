#! /usr/bin/env lua
X = nil
--- 2 Types and Values
print(type("Hello World"))
print(type(10.4*3))
print(type(print))
print(type(type))
print(type(true))
print(type(nil))
print(type(type(X)))

print(type(a))
a = 10
print(type(a))
a = "a string!!"
print(type(a))
a = print
a(type(a)) -- neat

--- 2.1 Nil

--- A billion dollar mistake

--- 2.2 Booleans

--- These are just booleans. Of note: only false and nil are falsey for the
--- purposes of control flow. 0 and "" are truthy.
if false then print("falsey") end
if 0 then print("truthy") end

--- 2.3 Numbers

--- All numbers are double-precision floats by default. This book says there's
--- no integer type, but there is now.
print(4)
print(0.4)
print(4.57e-3)
print(0.3e12)
print(5e+20)

--- 2.4 Strings

--- Immutable, eight-bit clean sequences of characters. Single or double quotes
--- are fine.
a = "one string"
b = string.gsub(a, "one", "another")
print(a)
print(b)

a = "double quotes"
b = 'single quotes'

a = [[
Nice heredoc-esque syntax for
multiline strings
]]

--- Automatic conversion between numbers and strings.
print("10" + 1)

--- String concatenation operator
print(10 .. 20)

--- Despite automatic conversions, underlying types are different.
print(10 == "10")
print(10 == tonumber("10"))
print("10" == tostring(10))
print("10" == 10 .. "")

--- 2.5 Tables

--- Associative array, indexed with anything except nil.
--- Only data structure, no dedicated map or array types.
--- Conventionally, arrays are indexed starting at 1, Matlab style.
a = {}
k = "x"
a[k] = 10
a[20] = "great"
print(a["x"])
k = 20
print(a[k])
a["x"] = a["x"] + 1
print(a["x"])
print(a["notexists"])

--- Multiple references to same table are possible, underlying table is
--- independent of references. Garbage collected if all references are nil.
a = {}
a["x"] = 10
b = a
print(b["x"])
b["x"] = 20
print(a["x"])
a = nil
b = nil

--- Syntactical sugar, a.x is equivalent to a["x"].
a = {}
a["x"] = "cute"
print(a.x)
a = nil

--- ipairs iterates over numerically indexed k/v in table, starting at 1,
--- ends at first nil.
a = {}
a[0] = "not me"
a[1] = "me"
a[3] = "not me either"
for k,v in ipairs(a) do
  print(k,v)
end
a = nil

--- string / number conversion does _not_ apply to table indexing.
a = {}
a[1] = "the number 1"
a["1"] = "the string 1"
print(a[1])
print(a["1"])
print(a[tonumber("1")])

--- 2.6 Functions

--- Functions are first class citizens, can be stored in variables and passed
--- as arguments. Lua can call functions written in C (and in fact, the standard
--- library is written in C).

--- 2.7 Userdata and Threads

--- Userdata type allows arbitrary C data in a Lua variable.
--- Threads / coroutines exist.
