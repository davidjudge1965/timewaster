#!/bin/bash
# ET_DATABASE_LOCATION=${ET_DATABASE_LOCATION:-'localhost:27017'}

echo "Pulling the Datadog Java Agent"
cd /tmp
wget -O dd-java-agent.jar 'https://search.maven.org/remote_content?g=com.datadoghq&a=dd-java-agent&v=LATEST'
ls -l dd-java-agent.jar
echo "Copying the file to ${CATALINA_HOME}/lib"
cp /tmp/dd-java-agent.jar ${CATALINA_HOME}/lib
echo "Done pulling the DD java agent"
ls -l ${CATALINA_HOME}/lib

#echo "Setting the parameters for DD Java agent"
#JAVA_OPTS="${JAVA_OPTS} -javaagent:/opt/tomcat/lib/dd-java-agent.jar"
##JAVA_OPTS="${JAVA_OPTS} -D"
#JAVA_OPTS="${JAVA_OPTS} -Ddd.service.name=backend"
#JAVA_OPTS="${JAVA_OPTS} -Ddd.agent.host=172.17.0.1"
#JAVA_OPTS="${JAVA_OPTS} -Ddd.agent.port=8126"
#JAVA_OPTS="${JAVA_OPTS} -Ddd.sampler.type=AllSampler"
#JAVA_OPTS="${JAVA_OPTS} -Ddd.sampler.rate=1.0"
#export JAVA_OPTS
#echo "Set JAVA_OPTS to [${JAVA_OPTS}]"

# Wait for the database to start serving connections.
# echo "Waiting for the easyTravel database on ${ET_DATABASE_LOCATION}"
# wait-for-cmd.sh "nc -z `echo ${ET_DATABASE_LOCATION} | sed 's/:/ /'`" 360

${CATALINA_HOME}/bin/catalina.sh run
