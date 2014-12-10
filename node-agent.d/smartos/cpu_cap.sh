#!/bin/bash

echo -e "used_percent\tn\t$(sm-cpuinfo | grep "Cap Used" | cut -d" " -f4)"
