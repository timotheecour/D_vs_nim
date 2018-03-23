# D_vs_nim
Goal: up to date comparison of features between D and nim. PR's welcome!

## D pros over nim
* CHECKME: D (via dmd) compiles faster
* CHECKME: docs seem to say nim can only use CTFE (via 'const') on functions 'without side-effects'
* CHECKME: are there real immutable variables in nim ? eg can we modify a slice of an immutable array declared by 'let'?
* D allows local imports
* nim is still pre 1.0
* CHECKME: D ranges are faster than nim's iterators
* bigger community
* CHECKME: more packages (via dub)
* Calpypso (ldc fork) allows direct C++ integration

## nim pros over D
* PR's get merged way faster in nim (see https://github.com/nim-lang/Nim/pulls vs https://github.com/dlang/dmd/pulls or phobos etc)
* nim uses a single repo for compiler + stdlib making synchronization easier; there are some threads mentioning D should do that
* nim github history almost linear (guessing it rebases); D's is not (uses merges)
* nim uses github issues instead of D's use of bugizlla
* fewer open bugs: D shows 4563 open bugs (https://dlang.org/bugstats.html) vs 1230 for nim
* nim has a much better GC implementation for soft real-time applications because it can be paused.
* can compile to js
* official D style guide is bad, not standard, takes too much vertical whitespace
* nim has AST macros
* nim has interpolated strings
* nim builtin doc (which looks like markdown) better than ddoc (which is noisy and nonstandard), eg:
```
proc remove*[T](L: var DoublyLinkedRing[T], n: DoublyLinkedNode[T]) =
  ## removes `n` from `L`. Efficiency: O(1).
```
generating https://nim-lang.org/docs/lists.html


## differences (not clear if pro or con)
nim has head immutability unlike D: http://nim-by-example.github.io/types/objects/

## map of corresponding features
* static if => when

## links
* https://www.slant.co/versus/118/395/~d_vs_nim
* https://forum.nim-lang.org/t/1779 Nim vs D
* http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html
* https://www.quora.com/Of-the-emerging-systems-languages-Rust-D-Go-and-Nim-which-is-the-strongest-language-and-why
* https://github.com/kostya/benchmarks
* https://digitalmars.com/d/archives/digitalmars/D/D_and_Nim_251571.html

## scratch
* makes some common idioms in D first-class citizens.   For example, imperative type declarations are first-class citizens so all the boiler plate around "if (isInputRange!(R))" type stuff goes away in Nim

## nim questions
* how to specify immutable inside `for(foo in bar)` ?
* does it have dfmt equivalent?
