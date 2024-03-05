import sequtils, strutils

const
  W = 10
  H = 22

type Grid = seq[seq[char]]
type Pieces = enum I

var
  g: Grid = newSeqWith(H, newSeq[char](W))
  activeRegion: Grid = newSeqWith(4, newSeq[char](4))
  score = 0
  cleared = 0

proc clear(g: var Grid) =
  for r in 0..<H:
    for c in 0..<W:
      g[r][c] = '.'

g.clear

proc step() =
  for r in 0..<H:
    var isClear = true
    for c in 0..<W:
      if g[r][c] == '.': isClear = false

    if isClear:
      score += 100
      cleared += 1
      for c in 0..<W: g[r][c] = '.'

proc setPiece(p: Pieces) =
  # clear the active region
  for r in 0..<4:
    for c in 0..<4:
      activeRegion[r][c] = '.'

  if p == Pieces.I:
    for c in 0..<4:
      activeRegion[1][c] = 'c'

proc showGrid(grid: Grid) =
  for r in 0..<grid.len:
    for c in 0..<grid[0].len:
      stdout.write(grid[r][c] & " ")
    echo ""

while true:
  let c = stdin.readLine
  case c:
    of "q": break
    of "p": showGrid(g)
    of "g": # given
      for r in 0..<H:
        let line = stdin.readLine
        for c in 0..<W:
          g[r][c] = line[c*2]
    of "c": g.clear
    of "?s": echo score
    of "?n": echo cleared
    of "s": step()
    of "I": setPiece(Pieces.I)
    of "t": showGrid(activeRegion)
    else: continue
