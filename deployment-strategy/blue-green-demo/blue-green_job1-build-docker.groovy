pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps{
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: 'refs/tags/${VERSION}']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[url: 'git@github.com:hoanglinhdigital/nodejs-random-color-temp.git', credentialsId: 'github-key-02142024']]
                ])
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t nodejs-random-color:${VERSION} .'
            }
        }
        stage('Upload image to ECR') {
            steps {
                sh 'aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com'
                sh 'docker tag nodejs-random-color:${VERSION} 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:${VERSION}'
                sh 'docker push 430950558682.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-random-color:${VERSION}'
            }
        }
    }
}
