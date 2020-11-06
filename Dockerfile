FROM jenkins/inbound-agent:4.6-1-jdk11 as jnlp

FROM smartbear/ready-api-soapui-testrunner:3.4.5

RUN yum -y install git jq libncurses5 make maven nodejs unzip uuid-runtime wget

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENV JAVA_HOME=/usr/java/openjdk-12

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]