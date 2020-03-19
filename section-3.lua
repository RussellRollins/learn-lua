#! /usr/bin/env lua

--- 3 Expressions

--- Numeric constants, string literals, variables, unary and binary operations,
--- function calls, function definitions, and table constructors.

--- 3.1 Arithmetic Operators.

--- All the hits.
print(1 + 3)
print(1 - 3)
print(1 * 3)
print(1 / 3)
print(-3)

--- Exponentiation is _not_ supported by default, but defined as a "fallback"
--- (basically, operator overload) in the math library. This is confusing.
print(2^3)

--- 3.2 Relational Operators

--- <, >, <=, >=, ==, ~=, you know the game.
--- tables, userdata, and functions are compared by reference, only equal if
--- they are the same object
a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a == b)
print(a == c)

--- Strings are compared in alphabetical order for locale.
print("aardvark" < "zebra")

-- String/number conversion does _not_ apply to comparisons.
print("2" < "15") --- false, because alphabetical.

--- 3.3 Logical Operators

--- and, not, or

--- and returns its first argument if it is false, second if true
--- or is the opposite
print(4 and 5)
print(nil and 13)
print(4 or 5)
print(nil or 13)

--- This property can be used to simplify operations.
x = false
v = "a default"

if not x then foo = v end
print(foo)
foo = x or v
print(foo)

--- and has higher precedence than or.
x = 10
y = 20
max = (x > y) and x or y
print(max)

--- 3.4 Concatentation

--- I'm pretty sure I already took notes on this during strings.
print("Hello" .. " " .. "World" .. "!")

--- 3.5 Precedence

--- ^
--- not - (unary)
--- + - (binary)
--- ..
--- < > <= >= ~= ==
--- and
--- or

--- Binary operators are left associative, except for ^ and ..
--- Use parentheses, they're good.

--- 3.6 Table Constructors

empty = {}
days = {"Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"}

--- Remember, 1 indexed arrays.
print(days[1])

--- Don't have to be constants
tab = {math.sin(1), math.sin(2), math.sin(3)}

--- Can do map-y tables too.
a = {x=0, y=0}
print(a.x)

--- Table constructors always create and initialize a new table, so we can
--- do cute stuff like build linked lists with them.
list = nil
for line in io.lines() do
    list = {next=list, value=line}
end
l = list
while l do
    print(l.value)
    l = l.next
end

--- Can mix styles
polyline = {color="blue", thickness=2, npoints=4,
             {x=0,   y=0},
             {x=-10, y=0},
             {x=-10, y=1},
             {x=0,   y=1},
           }
print(polyline.color)
print(polyline[1])

--- Both styles are special cases of a more general tool using square brackets.
a = {["x"]=0, ["y"]=1}
a = {[1]="red", [2]="blue"}

--- Trailing commas are optional but valid, semicolons can be used instead, by
--- convention, used to delimit different sections of a constructor. Such as
--- below, where it seperates list part and record part.
a = {x=10, y=45; "one", "two", "three"}
