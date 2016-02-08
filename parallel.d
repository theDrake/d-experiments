import std.stdio : writeln;
import std.range : iota;
import std.parallelism : parallel;

void main() {
  foreach (i; iota(10).parallel) {
    writeln("processing ", i);  // Executed in parallel for each 'i'.
  }
}
