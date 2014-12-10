#!/bin/bash

set -e

CPU_CAP_USED=$(sm-cpuinfo | grep "Cap Used" | cut -d" " -f4)

PREFIX="cpu_cap"

echo -e "${PREFIX}:used_percent\tn\t${CPU_CAP_USED}"
