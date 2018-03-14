#!/bin/sh

#SUB_NAME="Boston PM Subscription for Spark MIGRATED NO NEW SERVICES"
#REGION="eastus2"

SUB_NAME="WW EC Demo"
REGION="westcentralus"

RG_NAME="ninghairg"
EXP_ACCT_NAME="haiexpacct"
TMP_PATH='/tmp'

#az extension add -s https://adyadaexpaccount.blob.core.windows.net/cliextensionwheel/azure_cli_machinelearning-0.0.97-py2.py3-none-any.whl --pip-extra-index-urls https://azuremldownloads.azureedge.net/python-repository/preview
#az extension add -s https://azmlcliextensionstorage.blob.core.windows.net/o16n-extension/azure_cli_ml-0.1.0b3-py2.py3-none-any.whl
# set Azure sbuscription
echo set Azure Subscription
az account set -s "$SUB_NAME"

echo show current Azure Subscription
az account show

echo creating resource group...
az group create -n "$RG_NAME" -l "$REGION"

echo creating experimentation account...
az ml account experimentation create -n "$EXP_ACCT_NAME" -g "$RG_NAME"

#echo creating model management account...
#az ml account modelmanagement create -l eastus2 -n testmmsacct -g "$RG_NAME"

#echo setting model management account...
#az ml account modelmanagement set -n testmmsacct -g "$RG_NAME"

#echo creating mlc...
#az ml env setup -n testenv -l "$REGION" -g "$RG_NAME"

#echo showing mlc being created...
#az ml env show -g "$RG_NAME" -n testenv

#echo setting mlc...
#az ml env set -n testenv -g "$RG_NAME"

echo creating workspace...
az ml workspace create -n testws -a "$EXP_ACCT_NAME" -g "$RG_NAME"

echo remove /tmp/iris just in case
rm -rf $TMP_PATH/iris

echo creating Iris project...
az ml project create -n iris -a "$EXP_ACCT_NAME" -w testws -g "$RG_NAME" --path /tmp --template-url https://github.com/Azure/MachineLearningSamples-Iris

cd $TMP_PATH/iris

#pip install --index-url https://azuremldownloads.azureedge.net/python-repository/preview  --extra-index-url https://pypi.python.org/simple azureml-requirements
#pip install azure-ml-api-sdk==0.1.0a10

echo "running iris_sklearn.py locally..."
az ml experiment submit -c local iris_sklearn.py

echo "running iris_sklearn.py on local Docker..."
az ml experiment submit -c docker-python iris_sklearn.py

echo "running iris_spark.py on local Docker..."
az ml experiment submit -c docker-spark iris_spark.py

# back to script directory
# cd ~/git/pm_challenge/scripts
cd /data/git/pm_challenge/scripts

echo "deleting Iris project..."
az ml project delete -y -n iris -a "$EXP_ACCT_NAME" -w testws  -g "$RG_NAME"

echo "deleting local project folder..."
rm -rf {$TMP_PATH_NAME}/iris

echo deleting resource group...
az group delete -y -n "$RG_NAME"

echo "all cleaned up."
