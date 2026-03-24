## coloring.nim -- Graph coloring as pradas problem.
{.experimental: "strict_funcs".}
import std/tables
import lattice

type
  ColoringProblem* = object
    num_nodes*: int
    num_colors*: int
    edges*: seq[(int, int)]

  ColoringResult* = object
    assignment*: Table[int, int]  ## node -> color
    colors_used*: int

  SolveFn* = proc(problem: ColoringProblem): Result[ColoringResult, BridgeError] {.raises: [].}

proc new_coloring*(num_nodes, num_colors: int, edges: seq[(int, int)]): ColoringProblem =
  ColoringProblem(num_nodes: num_nodes, num_colors: num_colors, edges: edges)

proc is_valid*(cr: ColoringResult, edges: seq[(int, int)]): bool =
  for (u, v) in edges:
    if u in cr.assignment and v in cr.assignment:
      if cr.assignment[u] == cr.assignment[v]:
        return false
  true
