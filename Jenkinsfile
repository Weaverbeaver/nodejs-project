pipeline{
    agent any
    stages{
        stage('init'){
            steps {
                sh 'docker stop nodejs-project || true'
                sh 'docker rm nodejs-project || true'
            }
        }
        stage('build') {
            steps {
                sh 'docker build -t nodejs-project:${BUILD_NUMBER} .'
            }
        }
        stage ('run') {
            steps {
                sh 'docker run -p 80:5000 --name nodejs-project -d nodejs-project:${BUILD_NUMBER}'
            }
        }
    }
}