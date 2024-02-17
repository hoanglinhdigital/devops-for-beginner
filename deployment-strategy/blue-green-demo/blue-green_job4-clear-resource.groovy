pipeline {
    agent any
    stages {
        stage('Stop all task in a cluster') {
            steps {
                sh '''
                    aws ecs list-tasks --cluster ${CLUSTER_NAME} --service nodejs-service --query 'taskArns' --output text | xargs -I {} aws ecs stop-task --cluster ${CLUSTER_NAME} --task {}
                    aws ecs update-service --cluster ${CLUSTER_NAME} --service nodejs-service --desired-count 0
                '''
            }
        }
    }
}
