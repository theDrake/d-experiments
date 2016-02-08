import std.stdio, std.algorithm, std.range;

void main() {
  int[] a1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int[] a2 = [6, 7, 8, 9];

  immutable pivot = 5;  // Accessible from inside pure functions.

  int mySum(int a, int b) pure nothrow {
    if (b <= pivot) {
      return a + b;
    } else {
      return a;
    }
  }

  // Passing a delegate (closure):
  auto result = reduce!mySum(chain(a1, a2));
  //auto result = a1.chain(a2).reduce!mySum();
  writeln("Result: ", result);  // Result: 15

  // Passing a delegate literal:
  result = reduce!((a, b) => (b <= pivot) ? a + b : a)(chain(a1, a2));
  //result = a1.chain(a2).reduce!((a, b) => (b <= pivot) ? a + b : a)();
  writeln("Result: ", result);  // Result: 15
}
