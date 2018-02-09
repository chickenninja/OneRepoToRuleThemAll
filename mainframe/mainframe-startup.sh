# Set up windows
tmux split-window -t mainframe
tmux new-window -t mainframe
tmux new-window -t mainframe

tmux send-keys -t mainframe:0.0 "echo Setup" Enter
tmux send-keys -t mainframe:0.1 "echo MVS Machine" Enter
tmux send-keys -t mainframe:1.0 "echo Console1" Enter
tmux send-keys -t mainframe:2.0 "echo TSO1" Enter 

tmux rename-window -t mainframe:0 "mvs"
tmux rename-window -t mainframe:1 "console"
tmux rename-window -t mainframe:2 "tso"

# install MVS and c3270
tmux send-keys -t mainframe:0.0 "chmod +x setup" Enter
tmux send-keys -t mainframe:0.0 "./setup -a" Enter
sleep 1
tmux send-keys -t mainframe:0.0 "Y" Enter
sleep 10
tmux send-keys -t mainframe:0.0 "SECRET" Enter
sleep 1
tmux send-keys -t mainframe:0.0 Enter

# wait until installations are complete
while [ ! -f /tmp/suite3270-3.6/obj/x86_64-unknown-linux-gnu/c3270/c3270 ]
do
  sleep 2
done

# start mvs
tmux send-keys -t mainframe:0.1 "cd /var/adm/mvs38j && ./startmvs" Enter
sleep 1
tmux send-keys -t mainframe:0.1 Enter
sleep 5

# start console
tmux send-keys -t mainframe:1.0 "cd /tmp/suite3270-3.6/obj/x86_64-unknown-linux-gnu/c3270" Enter
tmux send-keys -t mainframe:1.0 "./c3270 127.0.0.1:3270" Enter

# start tso
tmux send-keys -t mainframe:2.0 "cd /tmp/suite3270-3.6/obj/x86_64-unknown-linux-gnu/c3270" Enter
tmux send-keys -t mainframe:2.0 "./c3270 00C0@127.0.0.1:3270" Enter

# IPL
tmux send-keys -t mainframe:0.1 "ipl 148" Enter
sleep 10

tmux select-window -t mainframe:1.0
tmux send-keys -t mainframe:1.0 "R 00,CLPA" Enter
sleep 5
tmux send-keys -t mainframe:1.0 "R 00,Y" Enter
sleep 5
tmux send-keys -t mainframe:1.0 "S JES2,,,PARM='FORMAT,NOREQ'" Enter
sleep 5
tmux send-keys -t mainframe:1.0 "R 01,Y" Enter
sleep 5
tmux send-keys -t mainframe:1.0 "R 02,Y" Enter

tmux select-window -t mainframe:2.0
