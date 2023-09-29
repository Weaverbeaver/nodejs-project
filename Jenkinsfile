pipeline{
    agent {
        label "agent"
    }
    environment{
        SECRET_VAR = credentials('secret_text')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    }
    stages {
        stage('init') {
            steps {
                sh 'sudo docker rm -f $(docker ps -aq) || true'
                sh 'sudo docker stop nodejs-project || true'
                sh 'sudo docker rm nodejs-project || true'
                sh 'sudo docker rm mynginx || true'
            }
        }
        stage('build') {
            steps {
                sh '#sudo docker build -t nodejs-project:${BUILD_NUMBER} .'
                sh 'sudo docker run -d -p 80:80 --name mynginx nginx:latest || true'
                sh "sudo docker exec mynginx sh -c 'echo \"hello jenkins! ${SECRET_VAR}\" > /usr/share/nginx/html/index.html'"
            }
        }
        stage ('run') {
            steps {
                sh 'echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'sudo docker tag nginx weaerbeaver/mynginx1:latest'
                sh 'sudo docker push weaerbeaver/mynginx1:latest'
                sh '#sudo docker run -p 80:5000 --name nodejs-project -d nodejs-project:${BUILD_NUMBER}'
            }
        }
    }
}