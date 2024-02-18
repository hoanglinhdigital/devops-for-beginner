pipeline {
    agent any
    stages {
        stage('Stop all task in a cluster') {
            steps {
                sh '''
                    aws ecs list-tasks --cluster "${CLUSTER_NAME}" | jq -r ".taskArns[]" | xargs -n1 aws ecs stop-task --no-cli-pager --cluster "${CLUSTER_NAME}" --task
                    aws ecs update-service --cluster ${CLUSTER_NAME} --service nodejs-service --desired-count 0
                '''
            }
        }
    }
}
