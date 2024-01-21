import strformat,strutils,terminal

const
  W = 10
  H = 22

type Grid = array[H, array[W, bool]]

var g: Grid

while true:
  let c = getch()
  case c:
    of 'q': break
    of 'p':
      for r in 0..<H:
        for c in 0..<W:
          stdout.write(if g[r][c]: "* " else: ". ")
        echo ""
    else: continue
