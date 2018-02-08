sudo docker run -d --rm --name dd-agent \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v /proc/:/host/proc/:ro \
  -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
  -v /Users/davidjudge/git/demotests/xenialdocker/data/easyTravel-Docker/conf.d:/conf.d:ro \
  -e API_KEY=227319b2a645d2c8f09d72ae60dda1aa \
  -e SD_BACKEND=docker \
  -e NON_LOCAL_TRAFFIC=true \
  -e DD_APM_ENABLED=true \
  -p 8126:8126/tcp \
  datadog/docker-dd-agent:latest

