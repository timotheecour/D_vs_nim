# D vs nim
***PR's welcome!***
Goal: up to date and objective comparison of features between D and nim, and 1:1 map of features to help D users learn nim and vice versa.

| category | D | nim | 1 for D, -1 for nim
| --- | --- | --- | --- |
| **UFCS** |
| UFCS supported everywhere | not everywhere, eg: mixin(expr), typeof(expr) | yes | -1 |
| **CTFE** |
| engine | AST interpreter. every expression encountered will allocate one or more AST nodes. Within a tight loop, the interpreter can easily generate over 100_000_000 nodes and eat a few gigabytes of RAM. That can exhaust memory quite quickly. Future work: https://dlang.org/blog/2017/04/10/the-new-ctfe-engine/ | uses a register VM (also the basis of Nimscript); faster | -1 |
| FFI during CTFE | no | no | 0 |
| can read/write/exec during CTFE | read only (string import) | yes; allows filesystem access via staticRead and staticExec;  | -1 |
| other CTFE limitations | ? | no heap-allocated runtime type at compile-time. Heap allocated compile-time variables are turned into immutable static/const at runtime. | ? |
| **OOP** |
| design | C++ like | allows multi-method dynamic dispatch (defined outside, avoiding kitchen sink classes) | -1 |
| **syntax** |
| allows local imports | yes | | 1 |
| mutually recursive imports | yes | no, compile-time error. you can use forward declaration and/or "mixin foosymbol" to tell the compiler that a symbol will be visible at one point. | 1 |
| familiarity | C-like | C or Python-like | 0 |
| interpolated strings |  | yes | -1 |
| style | (subjective opinion) official D style guide is controversial, not standard, takes too much vertical whitespace (eg braces on their own line) | [Nim Enhancement Proposal #1](https://nim-lang.org/docs/nep1.html) | 0 |
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
| direct use | no | Nim emits C code and you can break in with emit pragma; C code doesn't have to be written outside nim file | -1 |
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
| packages | dub: https://code.dlang.org/ | nimble: https://nimble.directory/packages.xml and https://github.com/nim-lang/packages | 0 |
| number of packages | 1247 | 639 | 1 |
| **tooling** |
| format code | `dfmt --inplace` | no | 1 |
| REPL | https://github.com/dlang-community/drepl ; https://github.com/callumenator/dabble |  unofficially, you can use `nim secret` but it does not support a lot of things. The most promising is [nrpl](https://github.com/wheineman/nrpl) | ? |
| **implementation** |
| GC | single shared memory heap that is controlled by its GC, thread safe, fully conservative, stop-the-world | precise, thread-local heaps, a bit more deterministic and a lot faster, you can even timeframe it if you need consistent 60fps for example. Much better GC implementation for soft real-time applications because it can be paused or the max pause can be tuned. Default GC is not thread safe. GC implementation can be switched at compile-time between deferred reference counting with cycle detection (default), mark and sweep, boehm or no GC (memory regions). Untraced heap-allocated manually managed objects are available (nim distinguishes bw ref and ptr: traced references point to objects of a garbage collected heap, untraced references point to manually allocated objects or to objects somewhere else in memory) | -1 |
| compile speed | faster (via dmd) CHECKME | | 1 |
| runtime performance | ? | ? | 0 |
| binary sizes produced |  | produces smaller binaries | -1 |
| shared library support | linux:OK; OSX: ldc (not dmd); windows: not OK(CHECKME) ; | anything that can be linked from C | -1 |
| **doc** |
| builtin doc | ddoc (noisy and nonstandard) | markdown eg `  ## removes `n` from `L`. Efficiency: O(1).` (eg: https://nim-lang.org/docs/lists.html) | -1 |
| **metaprogramming** |
| macro | no | hygienic macro system instead of string mixin; string mixin are available through `parseStmt`. The macros modify directly the abstract syntax tree given by the parser, before the compiler pass. It is possible to implement new DSLs or even a new language with a syntax different from Nim based on the macro system: example Smalltalk-like language (Spry)[http://sprylang.org/]| -1 |

See also libraries.md

## similar code comparison

| category | D | nim | 
| --- | --- | --- |
| longest path | https://github.com/logicchains/LPATHBench/blob/master/d.d  | https://github.com/logicchains/LPATHBench/blob/master/nim.nim |
| csv test | https://github.com/euantorano/faster-command-line-tools-in-nim/blob/master/D/csv_test.d | https://github.com/euantorano/faster-command-line-tools-in-nim/blob/master/Nim/csv_test.nim |
| rosettacode examples | https://rosettacode.org/wiki/Category:D | https://rosettacode.org/wiki/Category:Nim |

## differences (not clear if pro or con)
* nim has head immutability unlike D: http://nim-by-example.github.io/types/objects/
* Indentation based syntax, but supports syntax skins

## map of corresponding features
| category | D | nim | 
| --- | --- | --- |
| **syntax** |
| string mixin | `mixin("1+1")` | `stringMixinLikeInD("1+1")` with: `macro stringMixinLikeInD(s: static[string]): untyped = parseStmt(s)` source: https://forum.nim-lang.org/t/1779/2#19060 |
| WISYWIG string | \`foo\nbar\` | """foo\nbar""" |
| UFCS | foo(a, b), a.foo(b) | foo(a, b), a.foo(b), a.foo b, foo a b |
| expr without parenthesis | `auto a=fun;` calls `fun` | `var a=fun` returns `fun` |
| UFCS expr without parenthesis | `auto a=b.fun;` calls `fun` | `var a=b.fun` calls `fun` |
| increment | i++ | i+=1 or inc(i) |
| concatenation | ~ | & |
| type name | T.stringof (builtin) | T.name (import typetraits) |
| type of | typeof(expr) | expr.type |
| class | class A : B | type A = ref object of B |
| struct | struct A | type A = object |
| empty statement | {} | discard |
| conditional compilation | when defined(macosx) | version(OSX) |
| compile time if | static if | when |
| variable decl | auto a=foo | var a=foo |
| immutable decl | immutable foo=bar; | let foo=bar; |
| compile time decl | enum foo=bar | const foo=bar |
| nesting block comments | /++/ | #[ ]# |
| sring import | import("foo"); requires `-J` for security | staticRead("foo") |
| file | `__FILE__` | instantiationInfo; limitation: doesn't work for function caller, cf https://github.com/nim-lang/Nim/issues/7406 |
| **library** |
| **tools** |
| find declaration | dscanner --declaration | ? |

See also libraries.md

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
* can we modify a slice of an immutable array declared by 'let'?
* how to use global variables? (cf http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html)
* rdmd equivalent?
* how to search for symbols `fooBar` given that nim allows foobar fooBar foo_bar etc?

## nim questions (answered)
* are there real immutable variables in nim ?
A:https://www.reddit.com/r/nim/comments/2w32oi/immutability_in_nim/

## no longer valid points
https://forum.nim-lang.org/t/1779/1#11314 => dmd backend license was changed recently

