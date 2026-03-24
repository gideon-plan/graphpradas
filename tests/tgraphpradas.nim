{.experimental: "strict_funcs".}
import std/[unittest, tables]
import graphpradas

suite "coloring":
  test "create coloring problem":
    let p = new_coloring(4, 3, @[(0, 1), (1, 2), (2, 3)])
    check p.num_nodes == 4
    check p.edges.len == 3

  test "valid coloring":
    var a: Table[int, int]
    a[0] = 0; a[1] = 1; a[2] = 0; a[3] = 1
    let cr = ColoringResult(assignment: a, colors_used: 2)
    check is_valid(cr, @[(0, 1), (1, 2), (2, 3)])

  test "invalid coloring":
    var a: Table[int, int]
    a[0] = 0; a[1] = 0
    let cr = ColoringResult(assignment: a, colors_used: 1)
    check not is_valid(cr, @[(0, 1)])

suite "partition":
  test "compute edge cut":
    var a: Table[int, int]
    a[0] = 0; a[1] = 1; a[2] = 0
    check compute_edge_cut(a, @[(0, 1), (1, 2), (0, 2)]) == 2

suite "schedule":
  test "compute makespan":
    let tasks = @[Task(id: 0, duration: 5), Task(id: 1, duration: 3)]
    var st: Table[int, int]
    st[0] = 0; st[1] = 5
    check compute_makespan(tasks, st) == 8

suite "encode":
  test "coloring to assignments":
    let p = new_coloring(3, 2, @[(0, 1)])
    let a = coloring_to_assignments(p)
    check a.len == 3
    check a[0][1].len == 2
