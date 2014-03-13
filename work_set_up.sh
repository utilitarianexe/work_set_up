#!/bin/bash                                                                                  


programs=( firefox pgadmin3 chromium-browser )

#start programs if they are not running
for element in ${programs[@]}
do
    echo trying to start $element
    if [ $(ps aux | grep $element | wc -l) -gt 1 ]
    then
	echo Program $element already running
    else
	nohup $element  &
	
    fi
done


SESSIONNAME="script"
tmux has-session -t $SESSIONNAME &> /dev/null
if [ $? == 0 ] 
 then
    echo 'already alive I shall kill thee'
   tmux kill-session -t $SESSIONNAME
fi

cd ~/repos/

# tmux new-session -d -s foo 'exec pfoo'
# tmux send-keys 'bundle exec thin start' 'C-m'


tmux new-session -s $SESSIONNAME -n "emacs" -d "emacs -nw"
tmux new-window -a -n run_things

cd ~
tmux new-window -a -n faceiation
tmux send-keys -t $SESSIONNAME:faceiation "ssh peter@something.com" C-m
tmux split-window -t $SESSIONNAME:faceiation -h 
tmux send-keys -t $SESSIONNAME:faceiation "ssh peter@something.com" C-m

tmux new-window -a -n perception
tmux send-keys -t $SESSIONNAME:perception "ssh peter@something.com" C-m
tmux split-window -t $SESSIONNAME:perception -h 
tmux send-keys -t $SESSIONNAME:perception "ssh peter@something.com" C-m

tmux new-window -a -n amazon
tmux send-keys -t $SESSIONNAME:amazon "ssh ubuntu@something.com" C-m
tmux split-window -t $SESSIONNAME:amazon -h 
tmux send-keys -t $SESSIONNAME:amazon "ssh ubuntu@something.com" C-m


tmux attach -t $SESSIONNAME
