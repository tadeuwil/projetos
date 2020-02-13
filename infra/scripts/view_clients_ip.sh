#!/bin/bash
netstat -tn 2>/dev/null | grep :1192 | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
