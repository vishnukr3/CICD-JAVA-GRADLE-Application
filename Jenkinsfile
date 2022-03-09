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
                script{
                    withSonarQubeEnv("sonarqube-8.9.7") {  
                        sh 'pwd'
                        sh 'whoami'
                        sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                        sh './gradlew sonarqube'   // used for checking gradlew with sonar rules                   
                    }    
                }                                                                 
            }
        }
    }
}    
