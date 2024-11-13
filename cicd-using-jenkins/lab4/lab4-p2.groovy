pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hoanglinhdigital/simple-vue-webpack.git'
            }
        }
        stage('Clear workspace') {
            steps {
                sh 'rm -rf ${WORKSPACE}/dist'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Upload Artifacts') {
            steps {
                // Upload the artifact to S3
                sh 'aws s3 cp ${WORKSPACE}/dist/ s3://udemy-test-web-hosting-linh/ --recursive'
            }
        }
    }
}
