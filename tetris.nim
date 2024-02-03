const
  W = 10
  H = 22

type Grid = array[H, array[W, char]]

var
  g: Grid
  score = 0

proc clear(g: var Grid) =
  for r in 0..<H:
    for c in 0..<W:
      g[r][c] = '.'

g.clear

while true:
  let c = stdin.readLine
  case c:
    of "q": break
    of "p": # print
      for r in 0..<H:
        for c in 0..<W:
          stdout.write(g[r][c] & " ")
        echo ""
    of "g": # given
      for r in 0..<H:
        let line = stdin.readLine
        for c in 0..<W:
          g[r][c] = line[c*2]
    of "c": g.clear
    of "?s": echo score
    else: continue
