pipeline {
    agent any
    environment{
        FULL_IMAGE = "430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:${VERSION}"
        TASK_DEFINITION =""
        NEW_TASK_DEFINITION=""
        NEW_TASK_INFO=""
        NEW_REVISION=""
        TASK_FAMILY="nodejs-task-definition"
    }
    stages {
        stage('Checkout using tag') {
            steps{
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: 'refs/tags/${VERSION}']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[url: 'git@github.com:hoanglinhdigital/nodejs-random-color.git', credentialsId: 'github-key-02142024']]
                ])
            }

        }
        stage('Build') {
            when {
                expression {
                    def action=env.ACTION 
                    return action == 'BuildAndDeploy' || action == 'OnlyBuild'
                }
            }
            steps {
                sh 'docker build -t nodejs-random-color:${VERSION} .'
            }
        }
        stage('Upload image to ECR') {
            when {
                expression {
                    def action=env.ACTION 
                    return action == 'BuildAndDeploy' || action == 'OnlyBuild'
                }
            }
            steps {
                sh 'aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com'

                sh 'docker tag nodejs-random-color:${VERSION} 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:${VERSION}'
                
                sh 'docker push 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:${VERSION}'
            }
        }
        
        stage('Update task definition and force deploy ecs service') {
            when {
                expression {
                    def action=env.ACTION 
                    return action == 'BuildAndDeploy' || action == 'OnlyDeploy'
                }
            }
            steps {
                sh '''
                    TASK_DEFINITION=$(aws ecs describe-task-definition --task-definition ${TASK_FAMILY} --region "ap-southeast-1")
                    NEW_TASK_DEFINITION=$(echo $TASK_DEFINITION | jq --arg IMAGE "${FULL_IMAGE}" '.taskDefinition | .containerDefinitions[0].image = $IMAGE | del(.taskDefinitionArn) | del(.revision) | del(.status) | del(.requiresAttributes) | del(.compatibilities) |  del(.registeredAt)  | del(.registeredBy)')
                    NEW_TASK_INFO=$(aws ecs register-task-definition --region "ap-southeast-1" --cli-input-json "$NEW_TASK_DEFINITION")
                    NEW_REVISION=$(echo $NEW_TASK_INFO | jq '.taskDefinition.revision')
                    aws ecs update-service --cluster udemy-devops-ecs-cluster --service nodejs-service --task-definition ${TASK_FAMILY}:${NEW_REVISION} --force-new-deployment
                '''
 
            }
        }
    }
}
