pipeline {

    agent any

    environment {
        DOCKER_USER = credentials('dockerhub-creds').username
        DOCKER_PASS = credentials('dockerhub-creds').password
        IMAGE = "yourdockerhubusername/jenkins-node-app"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE:latest .'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Login to DockerHub') {
            steps {
                sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                '''
            }
        }

        stage('Push to DockerHub') {
            steps {
                sh 'docker push $IMAGE:latest'
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f nodeapp || true
                    docker run -d -p 3000:3000 --name nodeapp $IMAGE:latest
                '''
            }
        }
    }
}

