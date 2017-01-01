FROM openjdk
MAINTAINER Yuri Freire "yurifrl@outlook.com"

RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module sudo

RUN mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

# ENV ECLIPSE_URL http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/oxygen/M4/eclipse-java-oxygen-M4-linux-gtk-x86_64.tar.gz
ENV ECLIPSE_URL http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/neon/2/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz
RUN wget $ECLIPSE_URL -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

ADD run /usr/local/bin/eclipse
RUN chmod +x /usr/local/bin/eclipse

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/local/bin/eclipse
