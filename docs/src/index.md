# FrameworkDemo.jl

FrameworkDemo.jl is a demonstrator project for event-processing application framework for High Energy Physics (HEP) written in Julia and utilizing the [Dagger.jl](https://github.com/JuliaParallel/Dagger.jl) package for task scheduling.

## Intro


## Contents

The package contains:

- Set of workflow description files containing both realistic and artificial scenarios
- Library for scheduling workflows
- Executable runner for scheduling mockups from workflow description

## Example

A mockup for the ATLAS q449 workflow provided with the package can be scheduled with:

```
julia --project --threads 8 bin/schedule.jl \
--event-count 16 --max-concurrent 4  \
/data/atlas/q449/df.graphml --logs-trace trace.json
```

The workflow will be executed by 8 threads, a total of 16 physics-events will be processed with up to 4 physics-events being processed concurrently.
The execution log will be saved to a chrome-trace formatted file.
