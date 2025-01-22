#!/bin/bash

# Define session name
SESSION_NAME="gds-dev"

# Start a new tmux session
tmux new-session -d -s "$SESSION_NAME"

# Right pane is MAX GDS
tmux select-pane -t "$SESSION_NAME:0.0" -T "MAX GDS"
tmux send-keys -t "$SESSION_NAME:0.0" "cd $DIR_MAX && max-env" C-m

# Left pane is SF environment
tmux split-window -h -t "$SESSION_NAME:0.0"

tmux select-pane -t "$SESSION_NAME:0.1" -T "Starfish Repo"
tmux send-keys -t "$SESSION_NAME:0.1" "cd $DIR_SRC && sf-env" C-m

# Focus on first pane
tmux select-pane -t "$SESSION_NAME:0.0"

# Attach
tmux attach-session -t "$SESSION_NAME"
