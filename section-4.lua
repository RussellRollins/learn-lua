#! /usr/bin/env lua

--- 4 Statements

--- Assignment, control structures, and procedure calls
--- Multiple assignment and local variables.

--- 4.1 Assignment

--- We've already seen the basics
a = "foo"

--- Can also do multiple assignment, evaluates all values before assignment,
--- so can be used to do things like swap values.
a, b = 10, 20
print(a, b)
a, b = b, a
print(a, b)

--- Lua adjusts the number of values and variables in multiple assignment.
--- Unmatched variables get nil, unmatched values get discarded.
a, b = 10
print(a, b)
a, b = 10, 20, 30
print(a, b)

--- 4.2 Local Variables and Blocks
local i = 1
print(i)

--- scoped to their block. The body of a function, a control structure, or a
--- chunk (file or string). Locally scoped variables override global ones.
x = 10
local i = 1

while i<=x do
    local x = i*2
    print("scoped", x)
    i = i + 1
end
print("global", x)

--- can also explicitly create a block, to create scope
do
  local x = 20
  print("scoped", x)
end
print("global", x)

--- 4.3 Control Structures

--- if, while, repeat, for.

--- 4.3.1 if then else

if a<0 then a = 0 end

if a<0 then
    a = 0
elseif a>100 then
    a = 100
else
    a = "boring"
end

--- 4.3.2 while
local i = 1
while a[i] do
    print(a[i])
    i = i + 1
end

--- 4.3.3 repeat

repeat
    line = io.read()
until line ~= ""
print(line)

--- 4.3.4 Numeric for

--- for var=exp1,exp2,exp3 do
---   something
--- end
---
--- execute something for each value of var from exp1 to exp2, using exp3
--- as the step to increment var.
for i=10,1,-1 do print(i) end

--- The iteration variable is local, and should not be changed. Use break to
--- early exit.
a = {n=3; "one", "two", "three"}
local search = "two"
local found = nil
--- if exp3 is omitted, defaults to 1
for i=1,a.n do
  if a[i] == search then
    found = i
    break
  end
end
print("found", found)

--- 4.3.5 Generic for

--- traverse all values returned by an iterator function.
t = {}
for i,v in ipairs(a) do print(v) end
for k in pairs(t) do print(k) end

--- 4.4 break and return

--- They do what you expect.
--- Only weird thing is, they _must_ be the last statement in a block
--- or immediately followed by an end. If you want to break this rule, just use
--- a do block.

function foo ()
    do return end
    x = "foo"
end

