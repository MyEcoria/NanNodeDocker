FROM ubuntu:24.04
CMD ["bash"]
RUN apt update -y && apt upgrade -y && apt install jq wget curl nano screen -y && apt clean
RUN wget https://github.com/MyEcoria/nano-env/releases/download/V1.1/nano_node -O nan_node
RUN chmod +x nan_node
RUN mv nan_node /bin/

COPY init.sh /usr/local/bin/init.sh

RUN chmod +x /usr/local/bin/init.sh

WORKDIR /root
USER root
ENTRYPOINT ["/usr/local/bin/init.sh"]