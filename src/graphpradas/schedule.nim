## schedule.nim -- DAG scheduling as pradas problem.
{.experimental: "strict_funcs".}
import std/tables

type
  Task* = object
    id*: int
    duration*: int
    resource*: int  ## resource requirement

  Dependency* = object
    predecessor*: int
    successor*: int

  ScheduleProblem* = object
    tasks*: seq[Task]
    dependencies*: seq[Dependency]
    num_resources*: int

  ScheduleResult* = object
    start_times*: Table[int, int]  ## task_id -> start time
    makespan*: int

proc new_schedule*(tasks: seq[Task], deps: seq[Dependency],
                   num_resources: int): ScheduleProblem =
  ScheduleProblem(tasks: tasks, dependencies: deps, num_resources: num_resources)

proc compute_makespan*(tasks: seq[Task], start_times: Table[int, int]): int =
  for t in tasks:
    if t.id in start_times:
      let end_time = start_times[t.id] + t.duration
      if end_time > result: result = end_time
