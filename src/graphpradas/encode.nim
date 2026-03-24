## encode.nim -- Generic graph -> pradas PlanningSolution converter.
{.experimental: "strict_funcs".}
import coloring, partition

proc make_domain(n: int): seq[int] =
  for i in 0 ..< n: result.add(i)

proc coloring_to_assignments*(problem: ColoringProblem): seq[(int, seq[int])] =
  let domain = make_domain(problem.num_colors)
  for i in 0 ..< problem.num_nodes:
    result.add((i, domain))

proc partition_to_assignments*(problem: PartitionProblem): seq[(int, seq[int])] =
  let domain = make_domain(problem.num_parts)
  for i in 0 ..< problem.num_nodes:
    result.add((i, domain))
