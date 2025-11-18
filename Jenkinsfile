pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ketanray-cmd/jenkins-node-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker Image..."
                    sh "docker build -t dockeruser881/nodeapp:latest ."
                }
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                  usernameVariable: 'USER',
                                                  passwordVariable: 'PASS')]) {
                    script {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push dockeruser881/nodeapp:latest"
                    }
                }
            }
        }

        stage('Deploy Container Locally') {
            steps {
                script {
                    sh "docker stop nodeapp || true"
                    sh "docker rm nodeapp || true"
                    sh "docker run -d --name nodeapp -p 3000:3000 dockeruser881/nodeapp:latest"
                }
            }
        }
    }
}

