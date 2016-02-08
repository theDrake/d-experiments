#!/usr/bin/dmd -run

/******************************************************************************
  command_line.d

  To compile:
    dmd command_line.d
  To optimize:
    dmd -O -inline -release command_line.d
  To get generated documentation:
    dmd command_line.d -D
******************************************************************************/

import std.stdio;

void main(char[][] args) {
  writefln("Command line arguments:");
  foreach(argc, argv; args) {
    auto cl = new CmdLin(argc, argv);
    writefln(cl.argnum, cl.suffix, " arg: %s", cl.argv);
    delete cl;
  }

  struct specs {
    int count, allocated;
  }

  specs argspecs(char[][] args)

  in {
    assert(args.length > 0);
  }

  out(result) {
    assert(result.count == CmdLin.total);
    assert(result.allocated > 0);
  }

  body {
    specs *s = new specs;
    s.count = args.length;
    s.allocated = typeof(args).sizeof;
    foreach(argv; args) {
      s.allocated += argv.length * typeof(argv[0]).sizeof;
    }

    return *s;
  }

  // built-in string and common string operations, e.g. '~' is concatenate.
  char[] argcmsg = "argc = %d";
  char[] allocmsg = "allocated = %d";
  writefln(argcmsg ~ ", " ~ allocmsg, argspecs(args).count,
           argspecs(args).allocated);
}

/******************************************************************************
  CmdLin class: Stores a single command line argument.
******************************************************************************/
class CmdLin {
 private:
  int argc_;
  char[] argv_;
  static uint totalc_;

 public:
  this(int argc, char[] argv) {
    argc_ = argc + 1;
    argv_ = argv;
    totalc_++;
  }

  ~this() {}

  int argnum() {
    return argc_;
  }

  char[] argv() {
    return argv_;
  }

  wchar[] suffix() {
    wchar[] suffix;
    switch(argc_) {
      case 1:
        suffix = "st";
        break;
      case 2:
        suffix = "nd";
        break;
      case 3:
        suffix = "rd";
        break;
      default:
        suffix = "th";
    }

    return suffix;
  }

  static typeof(totalc_) total() {
    return totalc_;
  }

  invariant {
    assert(argc_ > 0);
    assert(totalc_ >= argc_);
  }
}
