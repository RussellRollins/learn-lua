#! /usr/bin/env lua

--- 1 The Language
print("Hello, World!")

function fact (n)
    if n == 0 then
        return 1
    else
        return n * fact(n-1)
    end
end

print(fact(5))

--- 1.1 Chunks
a = 1
b = a*2

a = 1;
b = a*2;

a = 1 ; b = a*2
a = 1   b = a*2

print(a, b)

--- 1.2 Global Variables

print(global)
global = 10
print(global)
global = nil
print(global)

--- 1.3 Some Lexical Conventions

--[[
print("weird block syntax") -- no action (comment)
--]]

---[[
print("weird block syntax") --> 10
--]]

--- 1.4 The Stand-Alone Interpreter

--- This script already using the shebang functionality.

--- Inception
os.execute("lua -e 'print(math.sin(12))'")
