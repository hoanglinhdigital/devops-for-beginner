pipeline {
    agent any

    tools {
        maven 'M3'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/hoanglinhdigital/simple-java-maven-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Upload Artifacts') {
            steps {
                // Upload the artifact to S3
                sh 'aws s3 cp ${WORKSPACE}/target/my-app-1.0-SNAPSHOT.jar s3://udemy-jenkins-linh/buildjob3/${BUILD_ID}/'
            }
        }
    }
}

