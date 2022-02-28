FROM ubuntu:latest

LABEL maintainer="psai0987@gmail.com"

RUN apt-get update && apt-get -y install cron

RUN export LANGUAGE=C.UTF-8; export LANG=C.UTF-8; export LC_ALL=C.UTF-8; export DEBIAN_FRONTEND=noninteractive

COPY entrypoint /entrypoint.sh
COPY my_bash /bin/my_bash
COPY root /etc/cron.d/root
RUN apt-get update -y && \
    apt-get install apt-transport-https ca-certificates wget gnupg -y && \
    wget -q -O - "https://repos.ripple.com/repos/api/gpg/key/public" | apt-key add - && \
    echo "deb https://repos.ripple.com/repos/rippled-deb focal stable" | tee -a /etc/apt/sources.list.d/ripple.list && \
    apt-get update -y && \
    apt-get install rippled -y && \
    rm -rf /var/lib/apt/lists/* && \
    export PATH=$PATH:/opt/ripple/bin/ && \
    chmod +x /entrypoint.sh && \
    echo '#!/bin/bash' > /usr/bin/server_info && echo '/entrypoint.sh server_info' >> /usr/bin/server_info && \
    chmod +x /usr/bin/server_info

RUN ln -s /opt/ripple/bin/rippled /usr/bin/rippled
RUN chmod +x /bin/my_bash

CMD ["cron", "-f"]

EXPOSE 51235

ENTRYPOINT [ "/entrypoint.sh" ]
