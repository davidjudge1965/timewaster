JAVA_OPTS="${JAVA_OPTS} -javaagent:${CATALINA_HOME}/lib/dd-java-agent.jar"
export JAVA_OPTS
echo "Set JAVA_OPTS to [${JAVA_OPTS}]"
