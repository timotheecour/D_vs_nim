# D_vs_nim
Goal: up to date comparison of features between D and nim. PR's welcome!

| category | D | nim | 1 for D, -1 for nim
| --- | --- | --- | --- |
| **CTFE** |
| FFI during CTFE | no | no | 0 |
| can print during CTFE | no | yes; allows filesystem access CHECKME;  | -1 |
| other CTFE limitations | ? | docs seem to say nim can only use CTFE on functions 'without side-effects' | ? |
| **syntax** |
| optional parens | yes | no | ? |
| allows local imports | yes | | 1 |
| mutually recursive imports | yes | ? |  |
| familirity | C-like | python-like | 0 |
| interpolated strings |  | yes | -1 |
| style | official D style guide is bad, not standard, takes too much vertical whitespace (eg braces on their own line) | | 1 |
| **language** |
| Distinction between traced and untraced pointers |  | yes | -1 |
| **debugging** |
| **maturity** |
| stability | few breaking changes in each release | pre 1.0, new releases often make lots of break changes | 1 |
| community | larger |  | 1 |
| **interop** |
| C++ | Calpypso (ldc fork) allows direct C++ integration |  | 1 |
| C++ |  | C/C++ code generation giving us much better interop than what D offers. Case in point: Converting to cstring doesn't require an allocation and copy | -1 |
| can compile to js | | yes | -1 |
| **library** |
| ranges | D ranges are faster than nim's iterators CHECKME |  | 1 |
| - |  | nim's iterators are easier to write | -1 |
| **ecosystem** |
| contributing | PR's languish forever | PR's get merged way faster in nim (see https://github.com/nim-lang/Nim/pulls vs https://github.com/dlang/dmd/pulls or phobos etc); QUOTE: Nim is magnitudes of orders easier to contribute to. Not only the compiler code is easier to reason about (at least for me), but PRs are accepted a lot more willingly. I bet such openness of the core devs makes Nim evolution faster and I hope it's gonna stay that way no matter 1.0. | -1 |
| repo split | dmd,druntime,phobos | single repo for compiler + stdlib making synchronization easier | -1 |
| github history | highly intertwined (uses merges) | almost linear (guessing it rebases) | -1 |
| issue tracker | bugzilla (issues.dlang.org) | github issues (https://github.com/nim-lang/Nim/issues) | -1 |
| open bugs | 4563 (https://dlang.org/bugstats.html)  | 1230 https://github.com/nim-lang/Nim/issues | -1 |
| **packages** |
| packages | dub: https://code.dlang.org/ | nimble: https://nimble.directory/packages.xml | 0 |
| number of packages | 1247 | 639 | 1 |
| **implementation** |
| GC | single shared memory heap that is controlled by its GC, thread safe | much better GC implementation for soft real-time applications because it can be paused ; Thread local heaps. Default GC is not thread safe. Otherwise use bdwgc | 0 |
| compile speed | faster (via dmd) CHECKME | | 1 |
| runtime performance | ? | ? | 0 |
| binary sizes produced |  | produces smaller binaries | -1 |
| shared library support | linux:OK; OSX: ldc (not dmd); windows: not OK(CHECKME) ; | ? | ? |
| **doc** |
| builtin doc | ddoc (noisy and nonstandard) | markdown eg `  ## removes `n` from `L`. Efficiency: O(1).` (eg: https://nim-lang.org/docs/lists.html) | -1 |
| **metaprogramming** |
| macro | no | hygienic macro system instead of string mixin; these can be implemented in library though (TODO:source)  | -1 |

## similar code comparison
* https://github.com/logicchains/LPATHBench/blob/master/d.d vs https://github.com/logicchains/LPATHBench/blob/master/nim.nim


## differences (not clear if pro or con)
* nim has head immutability unlike D: http://nim-by-example.github.io/types/objects/
* Indentation based syntax, but supports syntax skins

## map of corresponding features
| category | D | nim | 
| --- | --- | --- |
| **syntax** |
|  | i++ | i+=1 or inc(i) |
|  | static if | when |
|  | auto a=foo | var a=foo |
|  | immutable foo=bar; | let foo=bar; |
|  | enum foo=bar | const foo=bar |
| nesting block comments | /++/ | #[ ]# |
| sring import | import("foo"); requires `-J` for security | staticRead("foo") |
| file | __FILE__ | instantiationInfo; limitation: doesn't work for function caller, cf https://github.com/nim-lang/Nim/issues/7406 |
| **library** |
| **tools** |
| find declaration | dscanner --declaration | ? |
| format code | dfmt --inplace | ? |

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
* has REPL?
* can we modify a slice of an immutable array declared by 'let'?
* how to use global variables? (cf http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html)
* rdmd equivalent?
* how to search for symbols `fooBar` given that nim allows foobar fooBar foo_bar etc?

## nim questions (answered)
* are there real immutable variables in nim ?
A:https://www.reddit.com/r/nim/comments/2w32oi/immutability_in_nim/

## no longer valid points
https://forum.nim-lang.org/t/1779/1#11314 => dmd backend license was changed recently

