#!/usr/bin/env python3
import sys

current_date = ""
while True:
    try:
        line = input()
        commit_date, commit_hash = line.split(';')
        if commit_date != current_date:
            print(f'{commit_date};{commit_hash}')
            current_date = commit_date
    except EOFError:
        break
