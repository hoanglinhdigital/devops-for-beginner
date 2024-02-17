pipeline {
    agent any
    stages {
        stage('Switch traffic on ALB between port 80 and port 81') {
            steps {
                sh '''
                aws elbv2 modify-listener --listener-arn <listener-arn-for-port-80> --default-actions Type=forward,TargetGroupArn=<target-group-arn-for-blue>
                aws elbv2 modify-listener --listener-arn <listener-arn-for-port-81> --default-actions Type=forward,TargetGroupArn=<target-group-arn-for-green> 
                '''
            }
        }
    }
}
