ENV=$1

if [[ -z $ENV || $ENV == '' ]]; then
    echo "Must provide an ENV name"
    exit 1
fi

export ANSIBLE_VAULT_PASSWORD_FILE=./.vault_pass.txt

ansible-playbook -i ./inventory_${ENV}.yml ./playbooks/dispatch_config.yml -v