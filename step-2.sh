#!/bin/bash

oc login https://openshift.openhybridcloud.io:8443 -u demo -p redhat123
oc delete project mono-dev mono-test

git checkout step-2-ovh

ansible-galaxy install -r requirements.yml --roles-path=roles

ansible-playbook apply.yml -i inventory/ -e target=tools
ansible-playbook apply.yml -i inventory/ -e target=apps

oc login  https://ocp-rh-forum.northeurope.cloudapp.azure.com:8443 -u demo -p redhat123
git checkout step-2-azure

ansible-galaxy install -r requirements.yml --roles-path=roles

ansible-playbook apply.yml -i inventory/ -e target=bootstrap
ansible-playbook apply.yml -i inventory/ -e target=apps

git checkout master