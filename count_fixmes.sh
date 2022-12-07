#!/bin/bash

function get_youngest_commits {
    commits_list=$(git log --date=short --pretty=format:"%ad;%H" | ../same_date_filter.py)
}

cd serenity
git pull
git config core.pager cat

get_youngest_commits
echo ${commit_list}

N=4
ITER=0
for i in ${commits_list}
do
    ((ITER++)); ((ITER%N==0)) && wait
    {
        date=$(echo $i | cut -f1 -d ';')
        hash=$(echo $i | cut -f2 -d ';')
        result=$(git grep -Ei "(TODO|FIXME)" $hash | wc -l)
        echo "$date;$hash;$result"
        >&2 echo "[$ITER done]"
    } &
done
