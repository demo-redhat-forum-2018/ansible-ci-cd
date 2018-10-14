#!/bin/bash
oc login https://openshift.openhybridcloud.io:8443 -u demo -p redhat123

git checkout step-1

ansible-galaxy install -r requirements.yml --roles-path=roles

ansible-playbook apply.yml -i inventory/ -e target=bootstrap
#ansible-playbook apply.yml -i inventory/ -e target=tools
ansible-playbook apply.yml -i inventory/ -e target=apps

oc tag mono-ci-cd/coolstore:latest mono-ci-cd/coolstore:promoteToTest
oc tag mono-ci-cd/coolstore:latest mono-ci-cd/coolstore:promoteToProd

oc rollout latest coolstore -n mono-test
oc rollout latest coolstore-blue -n mono-prod
oc rollout latest coolstore-green -n mono-prod

git checkout master

rm -rf roles