#!/bin/bash
source ${DAIKONDIR}/scripts/daikon.bashrc

cd
git clone --single-branch --branch mutation-testing-with-invariants https://github.com/squaresLab/genprog4java.git \
&& cd genprog4java \
&& mvn package

export GP4J_HOME=$(pwd)

cd
git clone --single-branch --branch mutation-testing-with-invariants https://github.com/squaresLab/GenProgScripts.git

exec "$@"
