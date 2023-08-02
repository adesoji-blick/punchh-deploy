pipeline {
    agent any
        environment {
            AWS_ACCESS_KEY_ID     = credentials ('AWS_ACCESS_KEY_ID')
            AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
            AWS_DEFAULT_REGION    = credentials ('AWS_DEFAULT_REGION')
        } 

    stages {
        stage('Deploy Terraform Infrastructure') {
            steps {
                // Terraform Initialization
                sh "terraform init"

                // Terraform Apply
                sh "terraform apply --auto-approve"    
            }
        }
   }

   
    post {  
        always {
            echo 'One way or another, I have finished'
            sh "sudo docker system prune -a --volumes -f"
            deleteDir() /* clean up our workspace */
        }
        success {
            echo 'I succeeded!'
            emailext body: "Pipeline was successfully built ${env.BUILD_URL}", 
                subject: "Successful Pipeline: ${currentBuild.fullDisplayName}",
                from: "devops@blick.ng",
                to: "adesoji@blick.ng"
        }
        aborted {
            echo 'I aborted!'
            emailext body: "Pipeline was aborted: find details at ${env.BUILD_URL}", 
                subject: "Aborted Pipeline: ${currentBuild.fullDisplayName}",
                from: "devops@blick.ng",
                to: "adesoji@blick.ng"
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('
            emailext body: "Pipeline Build Failure ${env.BUILD_URL}", 
                subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                from: "devops@blick.ng",
                to: "adesoji@blick.ng"
        }
        changed {
            echo 'Things were different before...'
        }
    }

  }