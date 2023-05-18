ENV=$1

if [[ -z $ENV || $ENV == '' ]]; then
    echo "Must provide an ENV name"
    exit 1
fi

export ANSIBLE_VAULT_PASSWORD_FILE=./.vault_pass.txt
EXPORT_NAME=export_${ENV}_$(date "+%Y%m%d.%H%M%S")
EXPORT_DIR=../${EXPORT_NAME}

echo "Exporting $ENV to $EXPORT_DIR"

ansible-playbook -i ./inventories/${ENV}.yml \
    --extra-vars "input_tags=labels,credentials,projects,inventories,inventory_sources,hosts,groups,job_templates,roles output_path=$EXPORT_DIR" \
    ./playbooks/export.yml

echo "Exported $ENV to $EXPORT_DIR"
