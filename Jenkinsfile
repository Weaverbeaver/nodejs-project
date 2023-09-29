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
                sh 'docker rm -f $(docker ps -aq) || true'
                sh 'docker stop nodejs-project || true'
                sh 'docker rm nodejs-project || true'
                sh 'docker rm mynginx || true'
            }
        }
        stage('build') {
            steps {
                // sh 'docker build -t nodejs-project:${BUILD_NUMBER} .'
                sh 'docker run -d -p 80:80 --name mynginx nginx:latest || true'
                sh "docker exec mynginx sh -c 'echo \"hello jenkins! ${SECRET_VAR}\" > /usr/share/nginx/html/index.html'"
            }
        }
        stage ('run') {
            steps {
                sh 'echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker tag nginx weaerbeaver/mynginx1:latest'
                sh 'docker push weaerbeaver/mynginx1:latest'
                // sh 'docker run -p 80:5000 --name nodejs-project -d nodejs-project:${BUILD_NUMBER}'
            }
        }
    }
}