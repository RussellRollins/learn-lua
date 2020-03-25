#! /usr/bin/env lua

--- 8 Compilation, Execution, and Errors

--- Lua is interpreted, but it precompiles source code before executing it.
--- Many interpreted languages do this. PHP Zend VM, PythonC, etc. It's fine.

--- dofile() / loadfile(). dofile() compiles and runs a source file. loadfile()
--- only compiles it. loadfile() does not raise errors but returns error codes
--- instead.

--- We could write dofile() ourselves, if we wanted:
--- Note: assert raises an error on error codes.

function dofile (filename)
  local f = assert(loadfile(filename))
  return f()
end

dofile("section-1.lua")

--- loadfile() is more effecient than dofile(), since it requires compilation
--- only once.

--- loadstring() is like loadfile(), but it reads a string. Similar to `lua -e`.
function dothis(s)
  --- fffffffff, another 5.3 change! loadstring is now just load()
  local f = assert(load(s))
  return f()
end

dothis("print(\"Hello, World!\")")

--- load does not raise errors, but instead returns nil and an error message.

print(load("i i"))

--- load/loadfile do not have any side effects. They load everything into an
--- anonymous function. Only executing that function will have side effects
--- (for instance, defined functions are not avaiable until the anonymous
--- function is evaluated)

--- load/loadfile does not compile with lexical scoping. It is its own chunk.

--- 8.1 The require Function

--- require is like dofile() but it does two nice things:
---   1. It searches a path for the file in question
---   2. It remembers if a file has already been loaded and doesn't recompile.

--- The path is a set of patterns which each transform a virtual filename (the
--- argument to require).

--- require replaces each `?´ by the virtual file name and checks whether there
--- is a file with that name; if not, it goes to the next component.

--- ?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua

--- then the call require("lili") will try to open the following files:
---   * lili
---   * lili.lua
---   * c:\windows\lili
---   * /usr/local/lua/lili/lili.lua

--- require checks 3 places for a path, in order:
---   1. global variable LUA_PATH
---   2. environment variable LUA_PATH
---   3. fixed path (by default ?;?.lua, but can be compiled into the Lua
---      executable differently)

--- Loaded files are stored in a global variable, _LOADED a table of virtual
--- file names and values. Note that requiring the same file by two different
--- virtual file names will require recompilation for this reason. You can also
--- manipulate this global variable to force recompilation. I don't see why you
--- would want to do that, but it might be needed for your dark machinations.

--- The file component of the path could be a fixed filename, which would
--- be executed on misses. Using another global variable _REQUIREDNAME you
--- could get into some real shenanigans.

--- 8.2 C Packages

--- This is available on my machine, but errors because it's an invalid argument
--- Note: _Another_ 5.3 thing, moved to package.loadlib()
--- print(package.loadlib())

--- 8.3 Errors

--- Errors exist. Because Lua is often embedded in another program like Redis
--- or Nginx, can't just crash.

--- Errors happen for the reasons you might expect. Calling non-functions,
--- table accessing non-tables, adding things that aren't numbers.

--- You can also raise an error yourself with error().

--- error("oh no")

--- We use if not <foo> then error end so often, it has a builting, assert().
--- Checks whether first argument is truthy, raises an error if not, returns
--- the rest of the values if so.

--- Functions can either raise errors or return error codes (usually nil). 
--- There are no fixed rules about which you should do. One possible rule of
--- thumb: if an error is easy to avoid, raise if it is not easy to avoid,
--- return. (this is a little, but not quite, like Go's don't panic princpal)

--- 8.4 Error Handling and Exceptions

--- pcall is used to encapsulate code that might raise an error.

function foo(arg)
    print(arg)
    error("oh no")
end

if pcall(foo, "bar") then
  print("all is well")
else
  print("ah geeze")
end

--- pcall takes a function as a first argument, and its arguments as varargs.
--- it returns an error code and return values. true and returned values if
--- successful, false and an error message if not.

--- message doesn't have to be a string, anything you pass to error will be
--- returned (could send a cleanup function or an error table)

--- 8.5 Error Messages and Tracebacks

--- Lua tries to decorate errors with the filename and line number. How
--- helpful.

--- You can let the decorator know the actual error is in the caller, not the
--- function with a second argument to error, the "calling hierarchy" (our
--- function is level 1)

function foo(str)
    if type(str) ~= "string" then
      error("string expected", 2)
    end
end

--- xpcall takes a second argument, the handler function, which is called on
--- errors before the stack unwinds

xpcall(foo, function() print(debug.traceback()) end, 1)

