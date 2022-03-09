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
                        'chmod +x gradlew'      //used to execute permission to gradlew file
                        './gradlew sonarqube'   // used for checking gradlew with sonar rules
                         
                    }    
                }                                                                 
            }
        }
    }
}    
