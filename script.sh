#docker run -itd --name=web -p 9000:80 nginx

#!/bin/bash
read -p "Enter file name : " filename
while read line
do 
if [[ "$line" == *"services:"* ]]; then
  continue
fi
if [[ "${line:0-1}" == ":" ]]; then
        cname=$line
	echo $cname
	continue
fi
key=`echo $line | aws -F: '{print $1}'`
value=`echo $line | aws -F: '{print $2}'`

if [[ "${key}" == "image:" ]]; then
        image=$value
fi
if [[ "${key}" == "port:" ]]; then
        port=$value
fi
docker run -itd --name=$cname -p $port $image
done < $filename
