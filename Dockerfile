FROM ubuntu:16.04

SHELL ["/bin/bash", "-c"]

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update

RUN apt-get install -y openjdk-8-jdk gcc ctags graphviz netpbm texlive texinfo

RUN apt-get install -y bc git make unzip wget

#Set locale
RUN apt-get install -y language-pack-en \
&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN useradd -m -d /home/user user \
&& chmod 777 -R /home/user ${DAIKONDIR} ${D4J_HOME}

RUN wget -nv http://plse.cs.washington.edu/daikon/download/daikon-5.7.2.tar.gz

ENV DAIKONDIR /home/user/daikon-5.7.2
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN tar zxf daikon-5.7.2.tar.gz --directory /home/user \
&& rm daikon-5.7.2.tar.gz \
&& source $DAIKONDIR/scripts/daikon.bashrc \
&& make -C $DAIKONDIR rebuild-everything-but-kvasir


RUN apt-get install -y maven ant

RUN apt-get install -y subversion perl 

RUN apt-get install -y cpanminus

ENV D4J_HOME /home/user/defects4j

RUN mkdir ${D4J_HOME} \
&& git clone https://github.com/rjust/defects4j.git ${D4J_HOME} \ 
&& cd ${D4J_HOME} \
&& cpanm --installdeps . \
&& ./init.sh

ENV PATH="${PATH}:${D4J_HOME}/framework/bin"

RUN apt-get install -y man vim nano

RUN apt-get install -y software-properties-common \
&& add-apt-repository ppa:openjdk-r/ppa \
&& apt-get update \
&& apt-get install -y openjdk-7-jdk 
ENV JAVA7_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN chown -R user /home/user/

COPY entrypoint.sh /entrypoint.sh
RUN chmod 555 /entrypoint.sh

USER user

ENTRYPOINT ["bash",  "/entrypoint.sh"]

CMD ["/bin/bash"]
