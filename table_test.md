## example table (taken from https://github.com/nim-lang/Nim/wiki/Nim-for-C-programmers)

comment

<table>
  <tr>
    <th>C</th><th>Nim</th><th>Comment</th>
  </tr>

  <tr>
<td>
<pre>
/* A single-line comment */
int x = 3;  // more comment
// So is this
</pre>
<pre>
/*
a multi-line comment
*/
//
// or maybe this way?
//
#if 0
    some code 
    including comments 
    to be ignored
#endif
</pre>
</td>
<td>
<pre>
# A single-line comment
var x = 3  # more comment
</pre>
<pre>
#[
a multi-line comment. #[ may be nested ]#
]#
#
# or maybe this way?
#
when false:
  a multi-line comment 
  (but must be indented 
  to be included)
</pre>
</td>
<td>
<b>Single line comments</b>. Use the hash char (#).
<br>
<br>
<b>Multi-line comments</b>. Readability vs easy of use?
</td>
  </tr>
  <tr>
<td>
<pre>
int x;
int y = 2;
</pre>
</td>
<td>
<pre>
var x : int
var y1 : int = 2
var y2 = 2
let z = 2
</pre>
</td>
<td><b>Define variable</b>. y2 uses type inference. z is single-assignment. In Nim, uninitialized variables is initialized to 0/nil or similar defaults.</i>
</td>
  </tr>

</table>
