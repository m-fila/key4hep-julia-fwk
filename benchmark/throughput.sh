#!/bin/bash
WORKFLOW="$(dirname $0)/../data/ATLAS/q449/df.graphml"
REPEAT=5
AFFINITY=0
THREADS_SEQ="1 2 4 6 8 12 16 20 24 28 32 40 48 56 64 72 88 104 120 136 144"

THREADS_PER_SLOT=2
EVENTS_PER_SLOT=20

PROJECT="$(dirname $0)/.."
EXEC="$(dirname $0)/../bin/schedule.jl"

for threads in ${THREADS_SEQ}; do
    concurrent=$((threads/THREADS_PER_SLOT))
    total=$((concurrent*EVENTS_PER_SLOT))

    gcthreads_variants=(
        "1,0"
        "1,1"
        "$((threads / 2)),0"
        "$((threads / 2)),1"
        "${threads},0"
        "${threads},1"
    )

    for gcthreads in "${gcthreads_variants[@]}"; do
        output_file="timing_${threads}_gc${gcthreads}.csv"
        echo "Starting measurements for ${threads} threads, gcthreads=${gcthreads}, ${total} total events," \
            "${concurrent} concurrent events"

        CMD=(
            env JULIA_NUM_GC_THREADS="${gcthreads}"
            numactl --cpunodebind="${AFFINITY}" --membind="${AFFINITY}" julia -t "${threads}"
            --project="${PROJECT}" "${EXEC}" "${WORKFLOW}" --disable-logging=warn
            --max-concurrent="${concurrent}" --event-count="${total}"
            --warmup-count="${total}" --trials="${REPEAT}" --save-timing="${output_file}"
        )
        CMD=${CMD[*]}
        echo "Running command: ${CMD}"
        $CMD
    done
done