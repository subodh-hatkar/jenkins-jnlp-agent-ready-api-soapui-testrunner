FROM jenkins/inbound-agent:4.6-1-jdk11 as jnlp

FROM smartbear/ready-api-soapui-testrunner:3.4.5

RUN yum -y update && \
	yum -y install git jq libncurses5 make maven nodejs unzip uuid-runtime wget

ARG MVN_APP=maven
ARG MVN_VERSION=3.6.3
RUN wget http://mirror.olnevhost.net/pub/apache/${MVN_APP}/${MVN_APP}-3/${MVN_VERSION}/binaries/apache-${MVN_APP}-${MVN_VERSION}-bin.tar.gz \
    -O apache-${MVN_APP}-${MVN_VERSION}.tar.gz && \
    tar -zxvf apache-${MVN_APP}-${MVN_VERSION}.tar.gz && \
    mv apache-${MVN_APP}-${MVN_VERSION} /usr/local/apache-${MVN_APP} && \
    rm -rf apache-${MVN_APP}.tar.gz

ENV JAVA_HOME=/usr/java/openjdk-12
ENV M2_HOME=/usr/local/apache-maven
ENV M2=$M2_HOME/bin
ENV PATH=$M2:$PATH

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]