if [ "$1" == "" ]; then
        logfile="/var/nginx/logs/access.log"
else
        logfile=$1
fi

tail -n 100000 $logfile|awk -F '<->' '{
        resp_time=substr($10,5)
        app_time=substr($19,5)
        d=resp_time-app_time
        if(resp_time > 0 && app_time >0 &&  d>=0 && d<2000) {
                n++
                t+=d
                if(d>1000) {
                        #print $0
                }
        }
}END{
        print n,t,t/n
}'
