pipeline {
    agent any
        environment {
            AWS_ACCESS_KEY_ID     = credentials ('AWS_ACCESS_KEY_ID')
            AWS_SECRET_ACCESS_KEY = credentials ('AWS_SECRET_ACCESS_KEY')
            AWS_DEFAULT_REGION    = credentials ('AWS_DEFAULT_REGION')
        } 
    stages {
        stage("Production Approval") {
            when {
                anyOf {
                branch "main"
                }
            }
            steps {
                // Deployment Approval
                sh "echo ${env.BRANCH_NAME} Deployment Approval"
                emailext body: "A ${env.BRANCH_NAME} build is awaiting approval ${env.JOB_URL}", 
                    subject: "A ${env.BRANCH_NAME} deployment awaiting approval: ${currentBuild.fullDisplayName}",
                    from: "devops@blick.ng",
                    to: "adesoji@blick.ng"
                timeout(time: 10, unit: 'MINUTES') {
                    input "Deploy to ${env.BRANCH_NAME} env?"
                }
           }
        }
        
        stage('Deploy Lambda Function to prod') {
            when {
                anyOf {
                branch "main"
             }
         }
            steps {
                // Print to screen
                sh echo "Hello World - Thank you!"
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