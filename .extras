NOTES_DIR=$HOME/ghq/github.com/simenandre/notes/
function note() {
  if [ $1 ]; then
    FILE=$NOTES_DIR/$(date +%Y-%m-%d).md

    if [ $2 ]; then
      FILE=$2
    fi
    
    echo $1 >> $FILE
  fi
}

function nt() {
  if [ $1 ]; then
    CONTENT="- [ ] $1"
    note $CONTENT $2
  fi
}

function getBjerkIssues() {
  gh issue list --repo bjerkio/internal \
    --search "-label:backlog -label:kind/system" \
    --json title,body,url,createdAt,assignees,number,labels,comments \
    --jq 'map({url, createdAt, title, labels: [.labels[].name], assignees: [.assignees[].login], body, number: "#\(.number)", comments: .comments | map({ body: .body, createdAt: .createdAt })})'
}


