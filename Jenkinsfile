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
                      //dir('/var/lib/jenkins/workspace/java-gradle-app/') {
                        //sh 'cd /var/lib/jenkins/workspace/java-gradle-app'
                        //sh "sudo chmod +x /var/run/docker.sock"
                        sh 'pwd'
                        sh 'whoami'
                        //sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                        //sh './gradlew sonarqube'   // used for checking gradlew with sonar rules
                      }    
                    }    
                }                                                                 
            }
        }
    }
}    
