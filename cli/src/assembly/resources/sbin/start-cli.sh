#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

# You can put your env variable here
# export JAVA_HOME=$JAVA_HOME

if [ -z "${IOTDB_CLI_HOME}" ]; then
  export IOTDB_CLI_HOME="$(cd "`dirname "$0"`"/..; pwd)"
fi


MAIN_CLASS=org.apache.iotdb.cli.Cli


CLASSPATH=""
for f in ${IOTDB_CLI_HOME}/lib/*.jar; do
  CLASSPATH=${CLASSPATH}":"$f
done


if [ -n "$JAVA_HOME" ]; then
    for java in "$JAVA_HOME"/bin/amd64/java "$JAVA_HOME"/bin/java; do
        if [ -x "$java" ]; then
            JAVA="$java"
            break
        fi
    done
else
    JAVA=java
fi

PARAMETERS="$@"

# if [ $# -eq 0 ]
# then
# 	PARAMETERS="-h 127.0.0.1 -p 6667 -u root -pw root"
# fi

# Added parameters when default parameters are missing
if [[ $PARAMETERS =~ "-h" ]]
then
  PARAMETERS=$PARAMETERS
else
  PARAMETERS="$PARAMETERS -h 127.0.0.1"
fi
if [[ $PARAMETERS =~ "-p" ]]
then
  PARAMETERS=$PARAMETERS
else
  PARAMETERS="$PARAMETERS -p 6667"
fi
if [[ $PARAMETERS =~ "-u" ]]
then
  PARAMETERS=$PARAMETERS
else
  PARAMETERS="$PARAMETERS -u root"
fi
if [[ $PARAMETERS =~ "-pw" ]]
then
  PARAMETERS=$PARAMETERS
else
  PARAMETERS="$PARAMETERS -pw root"
fi

# echo $PARAMETERS

exec "$JAVA" -cp "$CLASSPATH" "$MAIN_CLASS" $PARAMETERS


exit $?
