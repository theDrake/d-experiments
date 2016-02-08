import std.stdio, std.concurrency, std.variant;

void foo() {
  bool cont = true;
  while (cont) {
    receive((int msg) => writeln("int received: ", msg),
            (Tid sender) { cont = false; sender.send(-1); },
            (Variant v) => writeln("huh?"));  // Variant matches any type.
  }
}

void main() {
  auto tid = spawn(&foo);  // Spawn a new thread running 'foo()'.
  foreach (i; 0 .. 10)
    tid.send(i);
  tid.send(1.0f);
  tid.send("hello");
  tid.send(thisTid);
  receive((int x) => writeln("Main thread received message: ", x));
}
