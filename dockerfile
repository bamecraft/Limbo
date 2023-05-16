FROM --platform=linux/amd64 ubuntu:latest
RUN sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@http://linux.yz.yamagata-u.ac.jp/ubuntu/@g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y --no-install-recommends
RUN apt-get install -y --no-install-recommends curl jq openjdk-19-jre-headless
RUN adduser --no-create-home --disabled-password --disabled-login --gecos '' 'bamecraft'
RUN mkdir /server && chown -R bamecraft:bamecraft /server
COPY --chown=bamecraft:bamecraft --chmod=700 entrypoint.sh /server/entrypoint.sh
