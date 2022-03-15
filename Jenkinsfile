pipeline{
    agent any 
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'openjdk:11'
                }
            }
            agent none
            steps{
                script{
                    withSonarQubeEnv() {
                            sh 'chmod +x gradlew'
                            //sh './gradlew sonarqube'
                    }

                   
                }  
            }
        }
    }
}