withCredentials([usernamePassword(credentialsId: 'dblogin', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    sh '''
        echo "Username: $USERNAME"
        echo "Password: $PASSWORD"
    '''
}