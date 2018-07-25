#TODO: expand this along with example.d

# line comment

#[
block comment
]#

import std/ospaths
from std/ospaths import nil

import std/file
export file

from std/ospaths import expandTilde

var g1 = 1
var g2 {.threadvar.}: int # TODO: initialize to 1

proc test1()=
  ## documentation comment
  echo "foo"
  echo "foo", 2
  var a1 = 1
  var a2: int = 1 #NOTE: Nim's == D's ptrdiff_t
  let a3 = 1
  const a4 = 1

proc fun(a:int) =
  discard

proc fun2(a:int): auto=
  # or: a*a
  # or: result = a*a
  return a*a

proc fun3[T](a:T) =
  discard

proc test2()=
  # test1 # doesn't work, by design
  test1()

  # or: fun 2
  fun(2)

  1.fun

  let a = fun2(1)
  discard fun2(1)

  fun3(1.0)

when isMainModule:
  # echo args # TODO

