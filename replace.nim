import std/[os, sequtils, strutils]

let
  nimibStart = readFile(getCurrentDir() / "nimibStart.txt")
  nimibStop = readFile(getCurrentDir() / "nimibStop.txt")
  workingDir = getCurrentDir() / "nimwiki"

for file in toSeq(walkFiles(workingDir / "*.md")):
  let fileContent = readFile(file)
  var newName = file.changeFileExt("nim")
  newName = newName.replace('-','_')
  var f: File = nil
  if open(f, splitPath(newName).tail, fmWrite):
    try:
      echo "writing ", newName
      f.write(nimibStart)
      f.write(fileContent)
      f.write(nimibStop)
    finally:
      close(f)
  else:
    echo "Could not create file ", newName
