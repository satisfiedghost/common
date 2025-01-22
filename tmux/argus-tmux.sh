#!/bin/bash

# Define session name
SESSION_NAME="argus-dev"

# Start a new tmux session
tmux new-session -d -s "$SESSION_NAME"

# Rename the first window
tmux select-pane -t "$SESSION_NAME:0.0" -T "Argus Camera"
tmux send-keys -t "$SESSION_NAME:0.0" "ssh-argus" C-m

# Left pane is argus camera
tmux split-window -h -t "$SESSION_NAME:0.0"

# Right top pane is NX
tmux select-pane -t "$SESSION_NAME:0.1" -T "PIL 1 NX"
tmux send-keys -t "$SESSION_NAME:0.1" "ssh pil1nx" C-m

# Split right side vertically
tmux split-window -v -t "$SESSION_NAME:0.1"

# Right bottom is FC
tmux select-pane -t "$SESSION_NAME:0.2" -T "PIL 1 FC"
tmux send-keys -t "$SESSION_NAME:0.2" "ssh -t pil1fc 'cd MAX/etc && exec bash -l'" C-m

# Focus on first pane
tmux select-pane -t "$SESSION_NAME:0.0"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
