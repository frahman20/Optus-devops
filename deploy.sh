#!/bin/bash

# Please ensure that you have the correct AWS credentials configured.
# Enter the name of the stack, the parameters file name, the template name, then changeset condition, and finally the region name.

if [ $# -ne 4 ]; then
    echo "Enter stack name, parameters file name, template file name to create, set changeset value (true or false), and enter region name. "
    exit 0
else
    STACK_NAME=$1
    TEMPLATE_NAME=$2
    CHANGESET_MODE=$3
    REGION=$4
fi

if [[ "cloudformation/"$TEMPLATE_NAME != *.yaml ]]; then
    echo "CloudFormation template $TEMPLATE_NAME does not exist. Make sure the extension is *.yaml and not (*.yml)"
    exit 0
fi

if [[ $CHANGESET_MODE == "true" ]] || [[ $CHANGESET_MODE == "True" ]]; then
    aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-body file://$PWD/$TEMPLATE_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --region $REGION
else
    aws cloudformation deploy \
    --stack-name $STACK_NAME \
    --template-body file://$PWD/$TEMPLATE_NAME \
    --capabilities CAPABILITY_NAMED_IAM \
    --region $REGION \
    --no-execute-changeset
fi
