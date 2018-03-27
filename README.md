# D vs nim
***PR's welcome!***
Goal: up to date and objective comparison of features between D and nim, and 1:1 map of features to help D users learn nim and vice versa.

Help welcome, eg by filling in the entries with `?` `TODO` and `CHECKME`.

| category | D | nim | 1 for D, -1 for nim
| --- | --- | --- | --- |
| **UFCS** |
| UFCS supported everywhere | not everywhere, eg: mixin(expr), typeof(expr) | yes | -1 |
| **CTFE** |
| engine | AST interpreter. every expression encountered will allocate one or more AST nodes. Within a tight loop, the interpreter can easily generate over 100_000_000 nodes and eat a few gigabytes of RAM. That can exhaust memory quite quickly. Future work: https://dlang.org/blog/2017/04/10/the-new-ctfe-engine/ | uses a register VM (also the basis of Nimscript); faster | -1 |
| FFI during CTFE | no | no | 0 |
| can read/write/exec during CTFE | read only (string import) | yes; allows filesystem access via staticRead and staticExec;  | -1 |
| other CTFE limitations | ? | Heap allocated compile-time variables are turned into immutable static/const at runtime. | ? |
| **OOP** |
| design | Java like | allows multi-method dynamic dispatch (defined outside, avoiding kitchen sink classes) | -1 |
| **syntax** |
| allows local imports | yes | | 1 |
| mutually recursive imports | yes | no, compile-time error. you can use forward declaration and/or "mixin foosymbol" to tell the compiler that a symbol will be visible at one point (CHECKME); see also: https://stackoverflow.com/questions/30235080/cannonical-way-to-do-circular-dependency-in-nim, https://github.com/nim-lang/Nim/issues/3961, https://forum.nim-lang.org/t/2114; workaround: The lack of cyclic dependencies in Nim is usually worked around by having a types module | 1 |
| mutually recursive types | yes | these types can only be declared within a single type section (else would require arbitrary symbol lookahead which slows down compilation.) | 1 |
| familiarity | C-like | C or Python-like | 0 |
| interpolated strings | no | yes | -1 |
| named parameter arguments | no | yes | -1 |
| style | (subjective opinion) https://dlang.org/dstyle.html ; style guide for phobos takes too much vertical whitespace (eg braces on their own line) | [Nim Enhancement Proposal #1](https://nim-lang.org/docs/nep1.html) | 0 |
| **language** |
| attribute inference | for template functions | ? | ? |
| Distinction between traced and untraced pointers |  | yes | -1 |
| forward declarations allowed? | yes | no; see https://github.com/nim-lang/Nim/issues/5287 | 1 |
| User defined operators | partial: opCall opSlice, opAssign etc | yes | -1 |
| User defined attributes | yes | ? | ? |
| RAII | yes | no? see: [RAII](https://forum.nim-lang.org/t/362/1) | -1 |
| delegates | yes | ? | ? |
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
| ranges | D ranges (implements empty, front, popFront) | yield-based iterators ; maybe simpler to write
but less efficient? not as flexible? (eg: can't do infinite ranges, bidirectional ranges) | ? |
| **ecosystem** |
| contributing | PR's languish forever | PR's get merged way faster in nim (see https://github.com/nim-lang/Nim/pulls vs https://github.com/dlang/dmd/pulls or phobos etc but not sure how to quantify objectively; see also https://github.com/nim-lang/Nim/pulse vs https://github.com/dlang/dmd/pulse). QUOTE: Nim is magnitudes of orders easier to contribute to. Not only the compiler code is easier to reason about (at least for me), but PRs are accepted a lot more willingly. I bet such openness of the core devs makes Nim evolution faster and I hope it's gonna stay that way no matter 1.0. | -1 |
| repo split | dmd,druntime,phobos | single repo for compiler + stdlib making synchronization easier | -1 |
| github history | highly intertwined (uses merges) | almost linear (guessing it rebases) | -1 |
| issue tracker | bugzilla (issues.dlang.org) | github issues (https://github.com/nim-lang/Nim/issues) | -1 |
| opened/closed bugs | 4563/13906 (https://dlang.org/bugstats.html)  | 1230/3263 https://github.com/nim-lang/Nim/issues | ? |
| **packages** |
| packages | dub: https://code.dlang.org/ | nimble: https://nimble.directory/packages.xml and https://github.com/nim-lang/packages | 0 |
| number of packages | 1247 | 639 | 1 |
| **tooling** |
| format code | `dfmt --inplace` | no; nimpretty? | 1 |
| REPL | https://github.com/dlang-community/drepl ; https://github.com/callumenator/dabble |  unofficially, you can use `nim secret` but it does not support a lot of things. The most promising is [nrpl](https://github.com/wheineman/nrpl) | ? |
| **implementation** |
| GC | single shared memory heap that is controlled by its GC, thread safe, fully conservative, stop-the-world | precise, thread-local heaps, a bit more deterministic and a lot faster, you can even timeframe it if you need consistent 60fps for example. Much better GC implementation for soft real-time applications because it can be paused or the max pause can be tuned. Default GC is not thread safe. GC implementation can be switched at compile-time between deferred reference counting with cycle detection (default), mark and sweep, boehm or no GC (memory regions). Untraced heap-allocated manually managed objects are available (nim distinguishes bw ref and ptr: traced references point to objects of a garbage collected heap, untraced references point to manually allocated objects or to objects somewhere else in memory) | -1 |
| compile speed | faster (via dmd) CHECKME | | 1 |
| is compiler bootstrapped? | frontend, not yet backend | yes | -1 |
| runtime performance | ? | ? | 0 |
| binary sizes produced |  | produces smaller binaries | -1 |
| shared library support | linux:OK; OSX: ldc (not dmd); windows: not OK(CHECKME) ; | anything that can be linked from C | -1 |
| **doc** |
| builtin doc | ddoc (noisy and nonstandard) | reStructuredText eg `  ## removes `n` from `L`. Efficiency: O(1).` (eg: https://nim-lang.org/docs/lists.html) | -1 |
| **metaprogramming** |
| variadic templates | yes: void fun(T...)(T a) | no; [RFC: Variadic Generics](https://github.com/nim-lang/Nim/issues/1019) | 1 |
| supported template parameters | type, alias, constant | ? | ? |
| macro | no | hygienic macro system instead of string mixin; string mixin are available through `parseStmt`. The macros modify directly the abstract syntax tree given by the parser, before the compiler pass. It is possible to implement new DSLs or even a new language with a syntax different from Nim based on the macro system: example Smalltalk-like language (Spry)[http://sprylang.org/]| -1 |
| **backend** |
| available backends | custom (dmd), gcc (gdc), llvm (ldc) | C, C++, js; WIP llvm (https://github.com/arnetheduck/nlvm) | ? |

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
| **syntax:lexical** |
| nesting block comments | /++/ | #[ ]# |
| WYSIWYG string | \`foo\nbar\`, r"foo\nbar", etc | """foo\nbar""", r"foo\nbar", etc(?) |
| end of file (useful when debugging) | `__EOF__` | ? |
| increment | i++ | i+=1 or inc(i) |
| concatenation | ~ | & |
| empty statement | {} | discard |
| **syntax:parsing** |
| string mixin | `mixin("1+1")` | `stringMixinLikeInD("1+1")` with: `macro stringMixinLikeInD(s: static[string]): untyped = parseStmt(s)` source: https://forum.nim-lang.org/t/1779/2#19060 |
| UFCS | foo(a, b), a.foo(b) | foo(a, b), a.foo(b), a.foo b, foo a b |
| expr without parenthesis | `auto a=fun;` calls `fun` | `var a=fun` returns `fun` |
| UFCS expr without parenthesis | `auto a=b.fun;` calls `fun` | `var a=b.fun` calls `fun` |
| static if .. else if .. else| static if(foo1) bar1 else if(foo2) bar2 else bar3 | when foo1: bar1 elif foo2:bar2 else:bar3  |
| conditional compilation | version(OSX) | when defined(macosx) |
| compile time if | static if | when |
| sring import | import("foo"); requires `-J` for security | staticRead("foo") |
| scope guards | `scope(exit) foo` etc | `finally: foo` (https://forum.nim-lang.org/t/141) |
| **types** |
| type of | typeof(expr) | expr.type |
| type name | T.stringof (builtin) | T.name (import typetraits) |
| class | class A : B | type A = ref object of B |
| struct | struct A | type A = object |
| float: 32, 64 bit | float, double | float32, float(float64) |
| pointer sized int, uint | ptrdiff_t, size_t | int, uint |
| sized ints | byte, short, int, long | int8, int16, int32, int64 |
| **decl** |
| variable decl | auto a=foo | var a=foo |
| immutable decl | immutable foo=bar; | let foo=bar |
| compile time decl | enum foo=bar | const foo=bar |
| **attributes** |
| purity | `pure` | `.noSideEffect` |
| nothrow | `nothrow` | ? |
| safe | `@safe` | ? |
| GC free | `@nogc` | ? |
| lockfree | ? | locks:0 |
| **language** |
| unit tests | `unittest{stmt}` | https://nim-lang.org/docs/unittest.html |
| **semantics** |
| float.init | NaN | 0 |
| file | `__FILE__` | instantiationInfo; limitation: doesn't work for function caller, cf https://github.com/nim-lang/Nim/issues/7406 |
| **library** |
| universal type conversion | a.to!T | ? |
| **cmd line** |
| custom define | -version=foo | --define:foo or --define:foo=bar |
| **resources** |
| tutorials | https://tour.dlang.org/ | https://nim-lang.org/docs/tut1.html |
| **tools** |
| find declaration | dscanner --declaration | nimgrep (but no declaration search, cf https://github.com/nim-lang/Nim/issues/7419) |
| fix code | dfix | nimfix |
| package manager | dub | nimble |

See also libraries.md

## links
* https://www.slant.co/versus/118/395/~d_vs_nim
* https://forum.nim-lang.org/t/1779 Nim vs D
* https://forum.dlang.org/post/mailman.1536.1428946094.3111.digitalmars-d@puremagic.com D vs nim
* http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html
* https://www.quora.com/Of-the-emerging-systems-languages-Rust-D-Go-and-Nim-which-is-the-strongest-language-and-why
* https://github.com/kostya/benchmarks
* https://digitalmars.com/d/archives/digitalmars/D/D_and_Nim_251571.html

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

