# Mockup runner

The `shedule.jl` is an executable for scheduling mockup workflow from description file. The topology of scheduled workflow will match the description by all the algorithms will be replaced by `MockupAlgorithm`s executing dummy calculations.

## Usage

```
julia --project bin/schedule.jl --help
```

Following command line arguments are supported:

```txt
usage: schedule.jl [--event-count EVENT-COUNT]
                   [--max-concurrent MAX-CONCURRENT]
                   [--logs-graph LOGS-GRAPH] [--logs-trace LOGS-TRACE]
                   [--logs-gantt LOGS-GANTT] [--logs-raw LOGS-RAW]
                   [--dump-plan DUMP-PLAN] [--fast] [--dry-run] [-h]
                   data-flow

positional arguments:
  data-flow             Input data-flow graph as a GraphML file

optional arguments:
  --event-count EVENT-COUNT
                        Number of events to be processed (type: Int64,
                        default: 1)
  --max-concurrent MAX-CONCURRENT
                        Number of slots for graphs to be scheduled
                        concurrently (type: Int64, default: 1)
  --logs-graph LOGS-GRAPH
                        Output the execution logs as a graph. Either
                        dot or graphics file format like png, svg, pdf
  --logs-trace LOGS-TRACE
                        Output the execution logs as a chrome trace.
                        Must be a json file
  --logs-gantt LOGS-GANTT
                        Output the execution logs as a Gantt chart.
                        Must be a graphics file format like png, svg,
                        pdf
  --logs-raw LOGS-RAW   Output the execution logs as text. The file
                        will be formatted as json if json extension is
                        given
  --dump-plan DUMP-PLAN
                        Output the execution plan as a graph. Either
                        dot or graphics file format like png, svg, pdf
  --fast                Execute algorithms immediately skipping
                        algorithm runtime information and crunching
  --dry-run             Assemble workflow but don't schedule it, don't
                        create any output files
  -h, --help            show this help message and exit
```

## Parallel workers controls

The workers and parallelism used by the application can be configured with standard julia arguments such as 
`-t, --threads`, `-p, --procs`, `--machine-file`. 

For example:

```
julia -t 4 --project bin/schedule.jl <ARGS>
```