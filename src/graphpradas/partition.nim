## partition.nim -- Graph partitioning as pradas problem.
{.experimental: "strict_funcs".}
import std/tables

type
  PartitionProblem* = object
    num_nodes*: int
    num_parts*: int
    edges*: seq[(int, int)]
    max_imbalance*: float64  ## e.g. 0.1 = 10% imbalance allowed

  PartitionResult* = object
    assignment*: Table[int, int]  ## node -> partition
    edge_cut*: int               ## edges crossing partitions

proc new_partition*(num_nodes, num_parts: int, edges: seq[(int, int)],
                    max_imbalance: float64 = 0.1): PartitionProblem =
  PartitionProblem(num_nodes: num_nodes, num_parts: num_parts,
                   edges: edges, max_imbalance: max_imbalance)

proc compute_edge_cut*(assignment: Table[int, int], edges: seq[(int, int)]): int =
  for (u, v) in edges:
    if u in assignment and v in assignment:
      if assignment[u] != assignment[v]:
        inc result
