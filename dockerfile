FROM --platform=linux/amd64 ubuntu:latest

# Change mirror server
RUN sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@http://linux.yz.yamagata-u.ac.jp/ubuntu/@g' /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y --no-install-recommends

# Install required packages
RUN apt-get install -y --no-install-recommends curl jq openjdk-19-jre-headless

# Create server folder
RUN adduser --no-create-home --disabled-password --disabled-login --gecos '' 'bamecraft'
RUN mkdir /server && chown -R bamecraft:bamecraft /server
COPY --chown=bamecraft:bamecraft --chmod=755 entrypoint.sh /server/entrypoint.sh
WORKDIR /server

# Execute entrypoint (when container starts)
ENTRYPOINT ["/server/entrypoint.sh"]
