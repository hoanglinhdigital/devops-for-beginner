pipeline {
    agent any
    environment {
        ALB_ARN = 'arn:aws:elasticloadbalancing:ap-southeast-1:430950558682:loadbalancer/app/udemy-devops-alb/b05b5a89ff031cac'
        LISTENER_BLUE_ARN = ''
        LISTENER_GREEN_ARN = ''
        TG_BLUE_ARN = ''
        TG_GREEN_ARN = ''
    }
    stages {
        stage('Switch traffic on ALB between 2 listener and 2 target group') {
            steps {
                script {
                    sh '''
                    output_blue=$(aws elbv2 describe-listeners --load-balancer-arn ${ALB_ARN} | jq -r '.Listeners[0] | {ListenerArn, TargetGroupArn: .DefaultActions[0].TargetGroupArn}')
                    output_green=$(aws elbv2 describe-listeners --load-balancer-arn ${ALB_ARN} | jq -r '.Listeners[1] | {ListenerArn, TargetGroupArn: .DefaultActions[0].TargetGroupArn}')
                    
                    LISTENER_BLUE_ARN=$(echo $output_blue | jq -r '.ListenerArn')
                    LISTENER_GREEN_ARN=$(echo $output_green | jq -r '.ListenerArn')
                    TG_BLUE_ARN=$(echo $output_blue | jq -r '.TargetGroupArn')
                    TG_GREEN_ARN=$(echo $output_green | jq -r '.TargetGroupArn')

                    aws elbv2 modify-listener --listener-arn ${LISTENER_BLUE_ARN} --default-actions Type=forward,TargetGroupArn=${TG_GREEN_ARN}
                    aws elbv2 modify-listener --listener-arn ${LISTENER_GREEN_ARN} --default-actions Type=forward,TargetGroupArn=${TG_BLUE_ARN}
                    '''
                }
            }
        }
    }
}
