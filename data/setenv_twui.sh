JAVA_OPTS="${JAVA_OPTS} -javaagent:/usr/share/tomcat8/lib/dd-java-agent.jar"
#JAVA_OPTS="${JAVA_OPTS} -D"
JAVA_OPTS="${JAVA_OPTS} -Ddd.service.name=twui"
JAVA_OPTS="${JAVA_OPTS} -Ddd.agent.host=localhost"
JAVA_OPTS="${JAVA_OPTS} -Ddd.agent.port=8126"
JAVA_OPTS="${JAVA_OPTS} -Ddd.sampler.type=AllSampler"
JAVA_OPTS="${JAVA_OPTS} -Ddd.sampler.rate=1.0"
export JAVA_OPTS
echo "Set JAVA_OPTS to [${JAVA_OPTS}]"
