#!/bin/bash

## ENV variabes used
## You can place them in env.properties to be loaded upon script start
# AZDO_PA=<Azure DevOps Personal Access Tocken>


## Set enviroment variables
set -a
. secrets/env.properties
set +a

### START

#Login ot AZDO using PAT credentials
#az devops login --organization $AZDO_ORG <<EOF
#$AZDO_PAT
#EOF

#Use azure login instead of azure DevOps PATH token
az login

az devops configure --defaults organization=$AZDO_ORG project=$AZDO_PRJ
RELEASE_ID=$(az pipelines release definition show --name data-ops-ADLS --query id -o tsv)
echo "Release id: $RELEASE_ID"

RELEASE_LIST=$(az pipelines release list --definition-id $RELEASE_ID --query '[[].name]' -o tsv)


#echo ${RELEASE_LIST[@]}

##Databricks 

##Auth with Databricks Tocken
databricks configure --token <<EOF
$DBCK_URL
$DBCK_TOKEN
EOF

DBKS_LIST=$(databricks workspace ls /build)

if [ -z "$DBKS_LIST" ]
then
    echo "Nothing in the folder"
else
    for value in $(echo $DBKS_LIST)
    do
        if [[ ${RELEASE_LIST[@]} =~ (^|[[:space:]])"$value"($|[[:space:]]) ]]
        then
            # whatever you want to do when array contains value
            echo "Contains: $value"
        else
            # whatever you want to do when array doesn't contains value
            echo "Does not contain $value"
        fi
    done
fi

#az devops logout