pipeline{
    agent any
    stages{
        stage("Sonar Quality Check"){
            agent {
                docker {
                    image 'openjdk:11'
                }
            }
            steps{
<<<<<<< HEAD
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
=======
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') 
                    {
>>>>>>> 317b09e (jenkins update)
                            sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                            sh './gradlew sonarqube'   // used for checking gradlew with sonar rules
                          
                    }
            
                       }
                }
        }
    }
}

