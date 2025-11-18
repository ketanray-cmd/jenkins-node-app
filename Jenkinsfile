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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                        sh """
                            echo "Building Docker Image..."
                            docker build -t $DOCKER_USER/nodeapp:latest .
                        """
                    }
                }
            }
        }

        stage('Docker Login & Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push $DOCKER_USER/nodeapp:latest
                        """
                    }
                }
            }
        }

        stage('Deploy Container Locally') {
            steps {
                script {
                    sh """
                        docker rm -f nodeapp || true
                        docker run -d --name nodeapp -p 3000:3000 $DOCKER_USER/nodeapp:latest
                    """
                }
            }
        }
    }
}
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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                        sh """
                            echo "Building Docker Image..."
                            docker build -t $DOCKER_USER/nodeapp:latest .
                        """
                    }
                }
            }
        }

        stage('Docker Login & Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push $DOCKER_USER/nodeapp:latest
                        """
                    }
                }
            }
        }

        stage('Deploy Container Locally') {
            steps {
                script {
                    sh """
                        docker rm -f nodeapp || true
                        docker run -d --name nodeapp -p 3000:3000 $DOCKER_USER/nodeapp:latest
                    """
                }
            }
        }
    }
}
