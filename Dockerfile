FROM jenkins/inbound-agent:4.3-9-alpine as jnlp

FROM smartbear/ready-api-soapui-testrunner:3.4.5

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENV JAVA_HOME=/usr/java/openjdk-12 

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]