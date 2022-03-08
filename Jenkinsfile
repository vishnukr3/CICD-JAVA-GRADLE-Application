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
                        //sh "sudo chmod +777 /var/run/docker.sock"
                        //'chmod 777 gradlew'      //used to execute permission to gradlew file
                        sh './gradlew sonarqube'   // used for checking gradlew with sonar rules
                    }    
                }                                                                 
            }
        }
    }
}    
