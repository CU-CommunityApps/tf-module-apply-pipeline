#!/bin/bash

set +e
terraform plan -detailed-exitcode -input=false -no-color -refresh=true -out=plan.out
PLAN_EXIT=$?
set -e

echo "Plan exit code: $PLAN_EXIT"

if [ $PLAN_EXIT -eq 0 ]; then
    echo "No changes to be applied. Stopping pipeline execution."
    PIPELINE_NAME=${CODEBUILD_INITIATOR#codepipeline/}
    
    echo "Pipeline name is $PIPELINE_NAME"
    
    EXECUTION_ID=$(aws codepipeline get-pipeline-state --name ${PIPELINE_NAME} --query 'stageStates[?actionStates[?latestExecution.externalExecutionId==`'${CODEBUILD_BUILD_ID}'`]].latestExecution.pipelineExecutionId' --output text)
    
    echo "Execution ID is $EXECUTION_ID"
    
    aws codepipeline stop-pipeline-execution \
        --pipeline-name $PIPELINE_NAME \
        --pipeline-execution-id $EXECUTION_ID \
        --no-abandon \
        --reason "No changes to be applied. Stopping pipeline execution."

elif [ $PLAN_EXIT -eq 2 ]; then
    terraform show plan.out > plan.txt
    echo "Changes need to be applied."
    exit 0
else
    echo "Error"
    exit $PLAN_EXIT
fi
