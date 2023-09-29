pipeline{
    agent {
        label "agent"
    }
    environment{
        SECRET_VAR = credentials('secret_text')
    }
    stages {
        stage('init') {
            steps {
                sh 'sudo docker rm -f $(docker ps -aq) || true'
                sh 'sudo docker stop nodejs-project || true'
                sh 'sudo docker rm nodejs-project || true'
            }
        }
        stage('build') {
            steps {
                sh '#sudo docker build -t nodejs-project:${BUILD_NUMBER} .'
                sh 'sudo docker run -d -p 80:80 --name mynginx nginx:latest'
                sh "sudo docker exec mnginx sh -c 'echo \"hello jenkins! ${SECRET_VAR}\" > /user/share/nginx/html/index.html'"
            }
        }
        stage ('run') {
            steps {
                sh 'sudo docker run -p 80:5000 --name nodejs-project -d nodejs-project:${BUILD_NUMBER}'
            }
        }
    }
}