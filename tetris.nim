import sequtils, strformat, strutils

const
  W = 10
  H = 22

type Grid = seq[seq[char]]
type Pieces = enum I, O, Z, S, J, L, T

var
  g: Grid = newSeqWith(H, newSeq[char](W))
  activeRegion: Grid
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

proc makeActiveRegion(p: Pieces) =
  let (w,h) = case p:
    of Pieces.I: (4,4)
    of Pieces.O: (2,2)
    of Pieces.Z, Pieces.S, Pieces.J, Pieces.L, Pieces.T: (3,3)

  activeRegion = newSeqWith(h, newSeq[char](w))

  for r in 0..<h:
    for c in 0..<w:
      activeRegion[r][c] = '.'

proc setPiece(p: Pieces) =
  makeActiveRegion(p)

  if p == Pieces.I:
    for c in 0..<4:
      activeRegion[1][c] = 'c'

  elif p == Pieces.O:
    for c in 0..<2:
      activeRegion[0][c] = 'y'
      activeRegion[1][c] = 'y'

  elif p == Pieces.Z:
    activeRegion[0][0] = 'r'
    activeRegion[0][1] = 'r'
    activeRegion[1][1] = 'r'
    activeRegion[1][2] = 'r'

  elif p == Pieces.S:
    activeRegion[0][1] = 'g'
    activeRegion[0][2] = 'g'
    activeRegion[1][0] = 'g'
    activeRegion[1][1] = 'g'

  elif p == Pieces.J:
    activeRegion[0][0] = 'b'
    activeRegion[1][0] = 'b'
    activeRegion[1][1] = 'b'
    activeRegion[1][2] = 'b'

  elif p == Pieces.L:
    activeRegion[0][2] = 'o'
    activeRegion[1][0] = 'o'
    activeRegion[1][1] = 'o'
    activeRegion[1][2] = 'o'

  elif p == Pieces.T:
    activeRegion[0][1] = 'm'
    activeRegion[1][0] = 'm'
    activeRegion[1][1] = 'm'
    activeRegion[1][2] = 'm'

proc showGrid(grid: Grid) =
  for r in 0..<grid.len:
    for c in 0..<grid[0].len:
      stdout.write(grid[r][c] & " ")
    echo ""

while not stdin.endOfFile:
  let s = stdin.readLine
  for c in s.split:
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
      of "O": setPiece(Pieces.O)
      of "Z": setPiece(Pieces.Z)
      of "S": setPiece(Pieces.S)
      of "J": setPiece(Pieces.J)
      of "L": setPiece(Pieces.L)
      of "T": setPiece(Pieces.T)
      of "t": showGrid(activeRegion)
      else: continue
