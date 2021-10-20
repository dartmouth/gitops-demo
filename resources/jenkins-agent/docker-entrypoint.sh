#!/bin/bash

set -x
set -e

java $JAVA_ARGS $JAVA_OPTS -jar $JENKINS_JARFILE -jnlpUrl $JENKINS_JNLP_URL -secret $JENKINS_SECRET