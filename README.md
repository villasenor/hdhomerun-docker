# hdhomerun-docker

hdhomerun_config in Docker! I use this in a Kubernetes CronJob to reset my HD Homerun device regularly (it seems to lock up). Unfortunately, there is no documented REST API...you have to use this CLI. I threw this together quickly, so it's not perfect, but it works! I'm publishing this repo on the off chance it is helpful to someone in the future.

My Kubernetes CronJob to restart my HD Homerun is below:
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: reset-hdhomerun
spec:
  schedule: "0 */12 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hdhomerun-docker
            image: <private registry>/hdhomerun-docker:latest
            imagePullPolicy: IfNotPresent
            command:
            - /bin/sh
            - -c
            - cd libhdhomerun && ./hdhomerun_config <hd_homerun_ip> set /sys/restart self
          restartPolicy: Never
```
