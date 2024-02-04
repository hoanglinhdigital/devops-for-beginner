pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hoanglinhdigital/simple-vue-webpack.git'
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        // stage('Upload Artifacts') {
        //     steps {
        //         // Upload the artifact to S3
        //         sh 'aws s3 cp ${WORKSPACE}/target/dist/ s3://udemy-jenkins-linh/buildjob4/${BUILD_ID}/ --recursive'
        //     }
        // }
    }
}
