FROM tomcat:9.0
#
# https://hub.docker.com/_/tomcat/
#
# CATALINA_BASE:   /usr/local/tomcat
# CATALINA_HOME:   /usr/local/tomcat
# CATALINA_TMPDIR: /usr/local/tomcat/temp
# JRE_HOME:        /usr
# CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar


# ENV var=${var}
# service.name	dd.service.name	DD_SERVICE_NAME	unnamed-java-app
# writer.type	dd.writer.type	DD_WRITER_TYPE	DDAgentWriter
# agent.host	dd.agent.host	DD_AGENT_HOST	localhost
# agent.port	dd.agent.port	DD_AGENT_PORT	8126
# sampler.type	dd.sampler.type	DD_SAMPLER_TYPE	AllSampler
# sampler.rate	dd.sampler.rate	DD_SAMPLER_RATE	1.0


ENV DD_SERVICE_NAME ttui
ENV DD_WRITER_TYPE DDAgentWriter
ENV DD_AGENT_HOST localhost
ENV DD_AGENT_PORT 8126
ENV D_SAMPLER_TYPE AllSampler
ENV DD_SAMPLER_RATE 1.0

# Deploy easyTravel Business Backend Application
# COPY build/backend.war ${CATALINA_HOME}/webapps/

# The Tomcat Manager can be access using '/tomcat' context
# RUN mv ${CATALINA_HOME}/webapps/ROOT ${CATALINA_HOME}/webapps/tomcat

# Make easyTravel Business Backend application base '/' context
# RUN mv ${CATALINA_HOME}/webapps/backend.war ${CATALINA_HOME}/webapps/ROOT.war

# ENV ET_RUNTIME_DEPS "bash curl netcat-openbsd openssl"
# RUN apk add --no-cache ${ET_RUNTIME_DEPS}

# COPY build/scripts/wait-for-cmd.sh /usr/local/bin

COPY build/TimeWasterUI.war ${CATALINA_HOME}/webapps/
COPY build/scripts/setenv.sh ${CATALINA_HOME}/bin/
COPY build/scripts/run-process.sh /

EXPOSE 8080

CMD /run-process.sh
