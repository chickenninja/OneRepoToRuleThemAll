# Set up windows
tmux new-window -t mainframe

tmux send-keys -t mainframe:0.0 "echo MVS" Enter
tmux send-keys -t mainframe:1.0 "echo TSO" Enter

tmux rename-window -t mainframe:0 "mvs"
tmux rename-window -t mainframe:1 "tso"

# start mvs
tmux send-keys -t mainframe:0 "./unattended/set_console_mode" Enter
sleep 1
tmux send-keys -t mainframe:0 Enter
tmux send-keys -t mainframe:0 "./mvs" Enter

# wait for port 3270 to open 
while ! nc -z localhost 3270; do   
  sleep 0.5 
done

# start tso
tmux select-window -t mainframe:1
tmux send-keys -t mainframe:1 "cd /tmp/suite3270-3.6/obj/x86_64-unknown-linux-gnu/c3270" Enter
tmux send-keys -t mainframe:1 "./c3270 127.0.0.1:3270" Enter
