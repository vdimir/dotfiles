#!/usr/bin/env python3


import os
import json

cmd = """
gh -R ClickHouse/ClickHouse pr list -S "assignee:vdimir is:closed updated:>=`date -v-1d -v-2w +%Y-%m-%d` -label:pr-backport -label:pr-cherrypick" --json state,title,url,mergedAt
"""

stream = os.popen(cmd)
output = stream.read()
prlist = json.loads(output)

print(prlist)
