oc login https://openshift.openhybridcloud.io:8443 -u demo -p redhat123

git checkout step-1

ansible-galaxy install -r requirements.yml --roles-path=roles

ansible-playbook apply.yml -i inventory/ -e target=bootstrap -e "filter_tags=cicd_project"
ansible-playbook apply.yml -i inventory/ -e target=tools

git checkout master

rm -rf roles