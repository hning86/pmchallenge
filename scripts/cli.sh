az ml login

az account list -o table

az account set -s 'my sub name'

az group create -n 'amlrg' -l 'eastus2'

az configure --defaults group=amlrg

az ml workspace create -n 'myws'

az ml project create -n 'myproj' -w myws --path /tmp --template-url https://github.com/Azure/MachineLearningSamples-MNIST

az ml experiment submit -c local train.py

az ml computetarget create -n dsvm --type vm --sku S1

az ml experiment submit -c dsvm train.py

az ml history list -o table

az ml model list -o table

az ml experiment submit -c dsvm score.py

az ml deploy -m 'model id' -f score.py -d o16n.yml --type aci

