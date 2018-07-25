module foo;
// line comment

/+
block comment
+/

import std.stdio;

import std.path;
static import std.path;

public import std.file;

import std.path : expandTilde;

static int g1 = 1;
int g2 = 1;

/// documentation comment
void test1(){
  writeln("foo");
  writeln("foo", 2);
  auto a1 = 1;
  int a2 = 1;
  const a3 = 1;
  enum a4 = 1;
}

void fun(int a){
}

int fun2(int a){
  return a*a;
}

void fun3(T)(T a){
}

void test2(){
  test1;
  test1();

  fun(2);
  1.fun;

  const a = fun2(1)
  fun2(1)

  fun3(1.0)
}

void main(string[]args){
  writeln(args);
}
