#!/usr/bin/env python3


import os
import json
from datetime import datetime
import humanize


def refmttime(s):
    if s is None:
        return None
    ts = datetime.strptime(s, '%Y-%m-%dT%H:%M:%SZ')
    return datetime.strftime(ts, '%d %b, %a')

def main():
    cmd = '''
    gh -R ClickHouse/ClickHouse pr list -S "assignee:@me is:closed updated:>=`date -v-1d -v-1w +%Y-%m-%d` -label:pr-backport -label:pr-cherrypick" --json labels,author,state,title,url,mergedAt,updatedAt,createdAt
    '''

    stream = os.popen(cmd)
    output = stream.read()
    prlist = json.loads(output)

    prlist.sort(key=lambda e: e['updatedAt'] or '')

    for e in prlist:
        e['mergedAt'] = refmttime(e['mergedAt'])
        e['updatedAt'] = refmttime(e['updatedAt'])
        e['createdAt'] = refmttime(e['createdAt'])
        if e['updatedAt'] == e['mergedAt']:
            del e['updatedAt']
        e['author'] = e['author']['login']
        e['labels'] = ','.join(sorted({lb['name'] for lb in e['labels']}))

    print(json.dumps(prlist))

if __name__ == '__main__':
    main()
