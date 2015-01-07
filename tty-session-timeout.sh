# set a timeout policy for bash shell running on the console
# this file should be copied to the /etc/profile.d/ directory
if [ $(tty | grep "tty") ];
then 
   TMOUT=300;
   readonly TMOUT;
   export TMOUT;
   echo "Session will timeout in $($TMOUT/60) minutes"
fi

