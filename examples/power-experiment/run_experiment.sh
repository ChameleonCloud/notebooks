#!/usr/bin/env bash

task_time_s="${1:-30}"
sample_rate_s="${2:-0.5}"
interval_time_s="${3:-5}"
num_cores=$(grep )

echo "Task time: ${task_time_s}s"
echo "Sample rate: ${sample_rate_s}s"
echo "Interval time: ${interval_time_s}s"
echo "Number of cores: ${num_cores}"

echo "Cleaning output directory ..."
rm -rf ./out && mkdir ./out

prefix="./out/run-$(date +%Y%m%d.%H%M.%S)"

run_task() {
  timeout "$task_time_s" etrace2 -s "$sample_rate_s" "$@"
}

echo
echo "************************"
echo "** Running at 25% ... **"
echo "************************"

run_task stress-ng --cpu $((num_cores/4)) >"$prefix-pct25.out"

echo
echo "************************"
echo "** Running at 50% ... **"
echo "************************"

run_task stress-ng --cpu $((num_cores/2)) >"$prefix-pct50.out"

echo
echo "************************"
echo "** Running at 100% .. **"
echo "************************"

run_task stress-ng --cpu $num_cores >"$prefix-pct100.out"

echo
echo "Creating archive of results ...",

tarball="$prefix.tar.gz"
tar -czf "$tarball" "$prefix-*.out" && cp "$tarball" ./out/latest.tar.gz
echo "Finished. Tarball located at $tarball (and ./out/latest.tar.gz)"
