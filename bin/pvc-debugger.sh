#!/usr/bin/env bash

if [ -z "$1" ] ; then
	echo "Usage: $0 <pvc>"
	exit 1
fi

pvc="$1"
podname="pvc-dbg-${USER}-$(date +'%s')"
image=busybox
path=/data

overrides=$(cat << EOF
{
  "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    "name": "$podname",
    "labels":{"app":"pvc-debugger"}
  },
  "spec": {
    "containers": [
      {
        "name": "debugger",
        "image": "$image",
	"args": ["/bin/sh"],
        "stdin": true,
        "stdinOnce": true,
        "tty": true,
        "volumeMounts": [
          {
            "mountPath": "$path",
            "name": "volume-to-debug"
          }
        ]
      }
    ],
    "volumes":[
      {
        "name":"volume-to-debug",
        "persistentVolumeClaim":{
          "claimName":"$pvc"
        }
      }
    ]
  }
}
EOF
)

echo $podname
echo "$pvc will be mounted at $path"
kubectl run $podname -it --rm --image $image --restart="Never" --overrides="$overrides" -- /bin/sh


