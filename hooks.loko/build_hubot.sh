#!/usr/bin/env bash

set -xeo pipefail

mkdir -p ${CANDIR}/etc/supervisord.d


cp -r ${SRCDIR}/bin ${CANDIR}
cp -r ${SRCDIR}/scripts ${CANDIR}
cp ${SRCDIR}/external-scripts.json ${CANDIR}
cp ${SRCDIR}/hubot-scripts.json ${CANDIR}
cp ${SRCDIR}/package.json ${CANDIR}
cp ${SRCDIR}/etc/hubot.conf.loko_itmpl ${CANDIR}/etc/supervisord.d

