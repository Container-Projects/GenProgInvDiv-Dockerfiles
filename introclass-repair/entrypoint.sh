#!/bin/bash
source ${DAIKONDIR}/scripts/daikon.bashrc

cd
git clone --single-branch --branch Yiwei-Lyu-mini-proj https://github.com/squaresLab/genprog4java.git \
&& cd genprog4java \
&& mvn package

export GP4J_HOME=$(pwd)

cd

git clone --single-branch --branch patch-diversity-evaluation https://github.com/squaresLab/genprog4java.git gp4j-patch-div-eval \
&& cd gp4j-patch-div-eval \
&& mvn package

cd
git clone --single-branch --branch whitebox-only https://github.com/squaresLab/GenProgInvDiv-IntroClassJava-Scripts.git IntroClassScripts
#&& cd IntroClassScripts
#&& bash preprocessIntroClassJava.sh ${ICJ_HOME}
exec "$@"
