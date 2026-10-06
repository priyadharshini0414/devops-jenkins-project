pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval') {
            steps {
                input message: 'Plan reviewed. Apply the changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Ansible Configure') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i inventory playbook.yml'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded. Website: http://localhost:8081'
        }
        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}
