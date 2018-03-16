#!/bin/sh
set -x

SUB_NAME="Boston PM Subscription for Spark MIGRATED NO NEW SERVICES"
REGION="eastus2euap"

#SUB_NAME="WW EC Demo"
#REGION="westcentralus"

RG_NAME="ninghairg"
EXP_ACCT_NAME="haiexpacct"
CUR_PATH=$(pwd)
TMP_PATH='/tmp'
PROJ_NAME='mysample'
SAMPLE='iris'
SAMPLE_ENTRY='iris_sklearn.py'
SAMPLE_TARGET='local'

#az extension add -s https://adyadaexpaccount.blob.core.windows.net/cliextensionwheel/azure_cli_machinelearning-0.0.97-py2.py3-none-any.whl --pip-extra-index-urls https://azuremldownloads.azureedge.net/python-repository/preview
#az extension add -s https://azmlcliextensionstorage.blob.core.windows.net/o16n-extension/azure_cli_ml-0.1.0b3-py2.py3-none-any.whl
# set Azure sbuscription
az account set -s "$SUB_NAME"

#show current Azure Subscription
az account show

# creat resource group
az group create -n "$RG_NAME" -l "$REGION"

# create experimentation account
az ml account experimentation create -n "$EXP_ACCT_NAME" -g "$RG_NAME"

#create model management account
#az ml account modelmanagement create -l eastus2 -n testmmsacct -g "$RG_NAME"

#set model management account
#az ml account modelmanagement set -n testmmsacct -g "$RG_NAME"

#create mlc
#az ml env setup -n testenv -l "$REGION" -g "$RG_NAME"

#show mlc being created
#az ml env show -g "$RG_NAME" -n testenv

#set mlc
#az ml env set -n testenv -g "$RG_NAME"

#create workspace
az ml workspace create -n testws -a "$EXP_ACCT_NAME" -g "$RG_NAME"

#remove /tmp/$SAMPLE just in case
rm -rf $TMP_PATH/$PROJ_NAME

#create sample project
az ml project create -n $PROJ_NAME -a "$EXP_ACCT_NAME" -w testws -g "$RG_NAME" --path /tmp --template-url https://github.com/Azure/MachineLearningSamples-$SAMPLE

cd $TMP_PATH/$PROJ_NAME

#pip install --index-url https://azuremldownloads.azureedge.net/python-repository/preview  --extra-index-url https://pypi.python.org/simple azureml-requirements
#pip install azure-ml-api-sdk==0.1.0a10

#run script locally
az ml experiment submit -c $SAMPLE_TARGET $SAMPLE_ENTRY

#back to script directory
cd $CUR_PATH

#delete project
az ml project delete -y -n $SAMPLE -a "$EXP_ACCT_NAME" -w testws  -g "$RG_NAME"

#delete local project folder
rm -rf $TMP_PATH/$PROJ_NAME

#delete resource group
az group delete -y -n "$RG_NAME"
