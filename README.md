# D vs nim
***PR's welcome!***
Goal: up to date and objective comparison of features between D and nim, and 1:1 map of features to help D users learn nim and vice versa.

NOTE: tables render better (ie full width) with a chrome extension, see https://stackoverflow.com/a/49566642/1426932

NOTE: occasionally, nim code below will use the braces syntax skin to fit in 1 line

Help welcome, eg by filling in the entries with `?` `TODO` and `CHECKME`, correcting wrong entries, or adding more (see also other files eg libraries.md).

| category | D | nim | 1 for D, -1 for nim |
| --- | --- | --- | --- |
| **UFCS** |
| UFCS supported everywhere | not everywhere, eg: mixin(expr), typeof(expr) | yes | -1 |
| **tuple** |
| tuple unpacking | no | yes:`proc getTup(): auto = (4, "foo"); let (_, a) = getTup()` | -1 |
| **CTFE** |
| engine | AST interpreter. every expression encountered will allocate one or more AST nodes. Within a tight loop, the interpreter can easily generate over 100_000_000 nodes and eat a few gigabytes of RAM. That can exhaust memory quite quickly. Future work: https://dlang.org/blog/2017/04/10/the-new-ctfe-engine/ | uses a register VM (also the basis of Nimscript); faster | -1 |
| FFI during CTFE | no | no | 0 |
| embed directly C/C++ code | no | yes: `emit` | -1 |
| can read/write/exec during CTFE | read only (string import) | yes; allows filesystem access via staticRead and staticExec;  | -1 |
| other CTFE limitations | ? | Heap allocated compile-time variables are turned into immutable static/const at runtime. | ? |
| **OOP** |
| design | Java like | allows multi-method dynamic dispatch (defined outside, avoiding kitchen sink classes) | -1 |
| **syntax** |
| allows local imports | yes | no | 1 |
| import order irrelevant | yes | ? | 1 |
| package modules (allows backward compatible breaking of module into package) | yes: https://dlang.org/spec/module.html#package-module | yes but see https://github.com/timotheecour/D_vs_nim/issues/22 | 0 |
| mutually recursive imports | yes | no, compile-time error. you can use forward declaration and/or "mixin foosymbol" to tell the compiler that a symbol will be visible at one point (CHECKME); see also: https://stackoverflow.com/questions/30235080/cannonical-way-to-do-circular-dependency-in-nim, https://github.com/nim-lang/Nim/issues/3961, https://forum.nim-lang.org/t/2114; workaround: The lack of cyclic dependencies in Nim is usually worked around by having a types module | 1 |
| familiarity | C-like | C or Python-like | 0 |
| interpolated strings | no | yes | -1 |
| named parameter arguments | no | yes | -1 |
| style | (subjective opinion) https://dlang.org/dstyle.html ; style guide for phobos takes too much vertical whitespace (eg braces on their own line) | [Nim Enhancement Proposal #1](https://nim-lang.org/docs/nep1.html) | 0 |
| **types** |
| mutually recursive types | yes | these types can only be declared within a single type section (else would require arbitrary symbol lookahead which slows down compilation.) | 1 |
| nested types | yes | no; but see https://github.com/nim-lang/Nim/issues/7449  | 1 |
| **semantics** |
| rvalue references | no | ? | ? |
| attribute inference | for template functions | ? | ? |
| Distinction between traced and untraced pointers |  | yes | -1 |
| forward declarations allowed? | yes | no; see https://github.com/nim-lang/Nim/issues/5287 | 1 |
| User defined operators | partial: opCall opSlice, opAssign etc | yes | -1 |
| User defined attributes | yes | ? | ? |
| RAII | yes | no? see: [RAII](https://forum.nim-lang.org/t/362/1) | 1 |
| **debugging** |
| **maturity** |
| stability | few breaking changes in each release | pre 1.0, new releases often make lots of break changes | 1 |
| community | larger |  | 1 |
| **interop** |
| C++ | Calpypso (ldc fork) allows direct C++ integration |  | 1 |
| C++ |  | C/C++ code generation giving us much better interop than what D offers. Case in point: Converting to cstring doesn't require an allocation and copy; see also https://github.com/timotheecour/D_vs_nim/issues/12 | -1 |
| can compile to js | | yes | -1 |
| direct use | no | Nim emits C code and you can break in with emit pragma; C code doesn't have to be written outside nim file | -1 |
| **standard library** |
| ranges | D ranges (implements empty, front, popFront) | yield-based iterators ; maybe simpler to write but less efficient? not as flexible? (eg: can't do infinite ranges, bidirectional ranges) | ? |
| variable length arrays | D allows `alloca` | see https://forum.nim-lang.org/t/499 (Variable length array) | ? |
| slices form pointer + length | builtin, `T[]` | pending https://github.com/nim-lang/Nim/issues/5753 or https://github.com/nim-lang/Nim/issues/8256 | 1 |
| strings are built from arrays | yes, `immutable(char)[]` | no, different type, so less generic API's | 1 |
| lazy functional programming (eg map, filter) | yes, eg `std.algorithm` | no (pending https://github.com/nim-lang/Nim/issues/3837, https://github.com/nim-lang/Nim/issues/8188) | 1 |
| **ecosystem** |
| contributing | PR's languish forever | PR's get merged way faster in nim (see https://github.com/nim-lang/Nim/pulls vs https://github.com/dlang/dmd/pulls or phobos etc but not sure how to quantify objectively; see also https://github.com/nim-lang/Nim/pulse vs https://github.com/dlang/dmd/pulse). QUOTE: Nim is magnitudes of orders easier to contribute to. Not only the compiler code is easier to reason about (at least for me), but PRs are accepted a lot more willingly. I bet such openness of the core devs makes Nim evolution faster and I hope it's gonna stay that way no matter 1.0. | -1 |
| repo split | dmd,druntime,phobos | single repo for compiler + stdlib making synchronization easier | -1 |
| github history | highly intertwined (uses merges) | almost linear (guessing it rebases) | -1 |
| issue tracker | bugzilla (issues.dlang.org) | github issues (https://github.com/nim-lang/Nim/issues) | -1 |
| opened/closed bugs | 4588/14061 (https://dlang.org/bugstats.html)  | 1296/3437 https://github.com/nim-lang/Nim/issues | ? |
| **packages** |
| packages | dub: https://code.dlang.org/ | nimble: https://nimble.directory/packages.xml and https://github.com/nim-lang/packages | 0 |
| number of packages (as of 2018/07/13) | 1346 (http://code.dlang.org/) | 704 (`nimble list` ) | 1 |
| **tooling** |
| format code | `dfmt --inplace` | `nimpretty`, not yet ready: https://github.com/nim-lang/Nim/issues/7420 | 1 |
| code reduction for bugs | dustmite | pending https://github.com/nim-lang/Nim/issues/8276 | 1 |
| REPL | https://github.com/dlang-community/drepl ; https://github.com/callumenator/dabble |  unofficially, you can use `nim secret` but it does not support a lot of things. The most promising is [nrpl](https://github.com/wheineman/nrpl) | ? |
| **implementation** |
| GC | single shared memory heap that is controlled by its GC, thread safe, fully conservative, stop-the-world | precise, thread-local heaps, a bit more deterministic and a lot faster, you can even timeframe it if you need consistent 60fps for example. Much better GC implementation for soft real-time applications because it can be paused or the max pause can be tuned. Default GC is not thread safe. GC implementation can be switched at compile-time between deferred reference counting with cycle detection (default), mark and sweep, boehm or no GC (memory regions). Untraced heap-allocated manually managed objects are available (nim distinguishes bw ref and ptr: traced references point to objects of a garbage collected heap, untraced references point to manually allocated objects or to objects somewhere else in memory) | -1 |
| compile speed | faster (via dmd) CHECKME | | 1 |
| is compiler bootstrapped? | frontend, not yet backend | yes, and bootstrapping sources can be regenerated from nim allowing compiler sources to use latest features | -1 |
| error messages uses poisoning/gagging to avoid spurious errors | yes | ? | ? |
| binary sizes produced |  | produces smaller binaries | -1 |
| shared library support | linux:OK; OSX: ldc (not dmd); windows: not OK(CHECKME) ; | anything that can be linked from C | -1 |
| **doc** |
| builtin doc | ddoc (noisy and nonstandard) | reStructuredText eg `  ## removes `n` from `L`. Efficiency: O(1).` (eg: https://nim-lang.org/docs/lists.html) | -1 |
| **metaprogramming** |
| variadic generics | yes: void fun(T...)(T a) | no; [RFC: Variadic Generics](https://github.com/nim-lang/Nim/issues/1019); but `varargs[untyped]` allowed in macros; not same though, eg can't be used in template functions | 1 |
| partial type template type deduction | yes | no, see https://github.com/nim-lang/Nim/issues/7529 | 1 |
| supported generic parameters | type, alias, constant | type, alias, constant | 0 |
| template constraint | `void fun(T)(T a) if(isFoo!T)` | concepts are simpler to use: `type isFoo = concept a (...); proc fun(a: isFoo)` | -1 |
| macro | no | hygienic macro system instead of string mixin; string mixin are available through `parseStmt`. The macros modify directly the abstract syntax tree given by the parser, before the compiler pass. It is possible to implement new DSLs based on the macro system: for example webserver DSL [jester](https://github.com/dom96/jester/) | -1 |
| **backend** |
| available backends | custom (dmd), gcc (gdc), llvm (ldc) | C, C++, js; WIP llvm (https://github.com/arnetheduck/nlvm) | ? |

See also libraries.md

## features requested in latest D survey (https://rawgit.com/wilzbach/state-of-d/master/report.html) that are already supported in Nim
* From the D survey question "What language features do you miss?", these features are supported in Nim:
tuples, named arguments, string interpolation, in-place struct initialization, UFCS for local symbols, writing files at compile-time
* these are doable in library code:
assert diagnostics, static break
* these are sort of available:
Static inheritance

## compilation time
* https://forum.nim-lang.org/t/1372
* tcc instead of clang (but not on OSX, see https://github.com/wheineman/nrpl/issues/16)

## runtime performance

| category/benchmark | D | nim | 1 for D, -1 for nim |
| --- | --- | --- | --- |
| functional: [Zero_functional](https://github.com/alehander42/zero-functional); Zero_functional fuses loop at compile-time when chaining zip.map.filter.reduce functional constructs | ? (missing D entry) | nim is currently number 1 or 2 against 9 other langs. The other number 2 or 1 lang being Rust. | ? |
| webserver | ? | [Mofuw](https://github.com/2vg/mofuw) by @2vg is faster than tokio-minihttp, the current \#1 on TechEmpower benchmark | ? |
| parsing csv files | [csv-blog-d](https://dlang.org/blog/2017/05/24/faster-command-line-tools-in-d/) | [csv-blog-nim](https://nim-lang.org/blog/2017/05/25/faster-command-line-tools-in-nim.html); D and Nim had the same speed and same compilation time. fastest CSV parser (to parse GBs of machine learning datasets) is [XSV](https://github.com/BurntSushi/xsv) in Rust | 0 |

See also https://github.com/timotheecour/D_vs_nim/issues/11

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
| documentation comments | `/** */`` or `/++ +/` or `///` | `##` or `##[ ... ]##` |
| WYSIWYG string | \`foo\nbar\`, r"foo\nbar", etc | """foo\nbar""", r"foo\nbar", etc(?) |
| end of file (useful when debugging) | `__EOF__` | ? |
| increment | i++ | i+=1 or inc(i) |
| concatenation | ~ | & |
| empty statement | {} | discard |
| **syntax:parsing** |
| alias | `alias T2=T;` | ?; template, see https://github.com/nim-lang/Nim/issues/7090 |
| type alias | `alias T2=T;` | `type T2=T` |
| string mixin | `mixin("1+1")` | `stringMixinLikeInD("1+1")` with: `macro stringMixinLikeInD(s: static[string]): untyped = parseStmt(s)` source: https://forum.nim-lang.org/t/1779/2#19060 |
| UFCS | foo(a, b), a.foo(b) | foo(a, b), a.foo(b), a.foo b, foo a, b |
| expr without parenthesis | `auto a=fun;` calls `fun` | `var a=fun` returns `fun` |
| UFCS expr without parenthesis | `auto a=b.fun;` calls `fun` | `var a=b.fun` calls `fun` (when b is arg, not module) |
| static if .. else if .. else| `static if(foo1) bar1 else if(foo2) bar2 else bar3` | `when foo1: bar1 elif foo2:bar2 else:bar3`  |
| conditional compilation | `version(OSX)` | `when defined(macosx)` |
| compile time if | `static if` | `when` |
| string import | `import("foo");` requires `-J` for security | `staticRead("foo")` |
| public import | `public import foo;` | `import foo; export foo;` |
| static import | `static import foo;` | `from foo import nil` |
| package fully qualified access | `pkg.mod.symbol();` | `symbol()` (`pkg.mod.symbol` illegal) |
| **syntax:exceptions** |
| scope guards | `scope(exit) foo`, `scope(success) foo`, `scope(failure) foo`,  | `defer: foo`, ? , ? ; see also https://forum.nim-lang.org/t/141/1#23104 |
| try throw catch finally | <code>try{throw new Exception("bar");}<br>catch(Exception e) {writeln(e);}<br>finally {}<code>  | <code>try: raise newException(IOError, "test exception")<br>except IOError: (let e = (ref IOError)(getCurrentException()); echo e[])<br>finally: discard<code> |
| **syntax:array** |
| static array literal | `int[2] a = [1,2];` | `var a = [1,2]` |
| dynamic array literal | `auto a = [1,2];` | `var a = @[1,2]` |
| dynamic array create | `auto a = new int[2];` | `var a = newSeq[int](2)` |
| empty dynamic array | `auto a = [];` | `var a:seq[int] = @[]` |
| indexing slice of a | `a[1..$], a[1..$-1], a[1..3]` | `a[1..^1], a[1..^2], a[1..<3]` |
| length | `a.length;` | `a.len` |
| **types** |
| initial value of type | `T.init` (known at CT) | ? |
| type of | `typeof(expr)` | `expr.type` |
| type name | `T.stringof` (builtin) | `T.name` (import typetraits) |
| class | `class A : B` | `type A = ref object of B` |
| struct | `struct A` | `type A = object` |
| float: 32, 64 bit | float, double | float32, float(float64) |
| pointer sized int, uint | ptrdiff_t, size_t | int, uint |
| sized ints | byte, short, int, long | int8, int16, int32, int64 |
| char types | char, wchar, dchar  | ?,?,? |
| **functions** |
| delegates | `int delegate(int, int)` | `proc (a, b: int): int {.closure.}` |
| **decl** |
| variable decl | `auto a=foo;` | `var a=foo` |
| immutable decl | `immutable foo=bar;` | `let foo=bar` |
| compile time decl | `enum foo=bar;` | `const foo=bar` |
| shared static | `__gshared a = 0;` | `var a {.global.} = 0` ? |
| static TLS | `static a = 0;` | `var a {.threadvar.} : int` |
| ref return | `auto ref fun(ref A a){ return a.x;}` | `proc fun(a:var A):var a.x.type = return a.x` |
| skip initialization | `T a = void;` | `var a {.noInit.}: T` |
| **attributes** |
| purity | `pure` | `{.noSideEffect.}` |
| nothrow | `nothrow` | `{.raises: [].}` |
| safe | `@safe` | ? |
| GC free | `@nogc` | ? |
| lockfree | ? | `{.locks:0.}` |
| **language** |
| unit tests | `unittest{stmt}` | https://nim-lang.org/docs/unittest.html |
| constructor | `T(args)` | ad-hoc: `newT(args)`, but see https://github.com/nim-lang/Nim/issues/7474 |
| **semantics** |
| float.init | NaN | 0 |
| file | `__FILE__` | instantiationInfo; limitation: doesn't work for function caller, cf https://github.com/nim-lang/Nim/issues/7406 |
| **traits** |
| does expr compile | `__traits(compiles, expr)` | `compiles(expr)` |
| get fields | `T.tupleof` | `x.fields` |
| **metaprogramming** |
| static assert | `static assert(foo);` | `static: assert foo` |
| **library** |
| universal type conversion | a.to!T | no: https://github.com/nim-lang/Nim/issues/7430 |
| path append | a.buildPath(b) | a / b ; does right thing on windows; NOTE: if b is absolute, buildPath returns b unlike nim |
| **cmd line** |
| custom define | -version=foo | --define:foo or --define:foo=bar |
| **resources** |
| tutorials | https://tour.dlang.org/ | https://nim-lang.org/docs/tut1.html |
| **tools** |
| caching compiler | rdmd | nim (compiles dependencies; only compiles changed file by default); https://github.com/Jeff-Ciesielski/nimr (subset of functionality) |
| find declaration | dscanner --declaration | nimgrep (but no declaration search, cf https://github.com/nim-lang/Nim/issues/7419) |
| fix code | dfix | nimfix |
| package manager | dub | nimble |
| install specific compiler versions | digger | choosenim |

See also libraries.md

## links
* https://www.slant.co/versus/118/395/~d_vs_nim
* https://forum.nim-lang.org/t/1779 Nim vs D
* https://forum.dlang.org/post/mailman.1536.1428946094.3111.digitalmars-d@puremagic.com D vs nim
* http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html
* https://www.quora.com/Of-the-emerging-systems-languages-Rust-D-Go-and-Nim-which-is-the-strongest-language-and-why
* https://github.com/kostya/benchmarks
* https://digitalmars.com/d/archives/digitalmars/D/D_and_Nim_251571.html
* https://forum.nim-lang.org/t/1983#12391 A few questions about Nim

## nim questions (besides entries marked above with `?`)
* does it have dfmt equivalent?
* instead of `newSeq` could we write `new!Seq` or new[Seq] or anything else that's generic and doesn't pollute namespace?

* how to use dirty templates/macros that require an import? eg:
```nim
template foo*() {.dirty.} { #[want: import os ]# let programName = getAppFilename() }
```

* how to compose arbitrary ranges/iterators in Nim?

* how to define a slice of type T from ptr + length?
cf https://github.com/nim-lang/Nim/issues/5437 feature-request pointer size pair, (openArray as value) #5437

## nim questions (answered)
* are there real immutable variables in nim ?
A: https://www.reddit.com/r/nim/comments/2w32oi/immutability_in_nim/
* how to specify immutable inside `for(foo in bar)` ?
A: immutability depends on iterator and by default iterators return immutable values.
```
var a = @[1, 2, 3, 4]
for item in a: item += 5  # compile-time error
for item in mitems(a):  item += 5  # ok
```
* how to search for symbols `fooBar` given that nim allows foobar fooBar foo_bar etc?
A: nimgrep; also: Nim provides "nimsuggest" that can be used for vim, emacs, vscode, atom that autocompletes

* how to use global variables? (cf http://gradha.github.io/articles/2015/02/goodbye-nim-and-good-luck.html)
A: Non-const global vars are not allowed in proc tagged noSideEffects and care must be used if accessed from multiple threads but there is nothing special about them otherwise.

* can we modify a slice of an immutable array declared by 'let'?
A: Slicing doesn't return a var T for let arrays so you can't. Note that immutability for stack objects/array/types is deep but for ref/ptr types it is shallow, it means that the memory address pointed to cannot be modified but the content can.

* is there a robust way to write complex nim functions as a one liner (eg, for use in 1 line docs, in REPL etc); ideally by replacing indentation with braces
A: `(st1; st2; st3)`, or undocumented braces syntax skin:
```nim
#? braces

proc main() {
  echo "Hello"
}

when (isMainModule) {
  main()
}
```

## no longer valid points
https://forum.nim-lang.org/t/1779/1#11314 => dmd backend license was changed recently

