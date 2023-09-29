pipeline{
    agent {
        label "agent"
    }
    stages {
        stage('init') {
            steps {
                sh 'sudo docker stop nodejs-project || true'
                sh 'sudo docker rm nodejs-project || true'
            }
        }
        stage('build') {
            steps {
                sh 'sudo docker build -t nodejs-project:${BUILD_NUMBER} .'
            }
        }
        stage ('run') {
            steps {
                sh 'sudo docker run -p 80:5000 --name nodejs-project -d nodejs-project:${BUILD_NUMBER}'
            }
        }
    }
}