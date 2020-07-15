#!/bin/bash
awk 'BEGIN{OFS=" "} />/ {h=$0; next} {print h, $0}' output441.detect > output441.detect.big
