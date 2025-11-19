pipeline {
    agent any

    options {
        skipDefaultCheckout(true)     // Prevent Jenkins auto-checkout that causes false SCM triggers
    }

    triggers {
        pollSCM('H/2 * * * *')        // Poll GitHub every 2 mins, build ONLY if commit changed
    }

    stages {

        stage('Checkout') {
            steps {
                deleteDir()           // Clean workspace to avoid false change detection
                checkout scm
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
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    script {
                        sh "echo \$PASS | docker login -u \$USER --password-stdin"
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

