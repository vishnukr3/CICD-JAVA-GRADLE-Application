pipeline{
    agent any 
    //customWorkspace = /var/lib/jenkins/workspace/java-gradle-app
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
            //agent none
            steps{
                script{
                    withSonarQubeEnv() {
                            //sh "sudo chmod 777  /var/run/docker.sock"
                            //ws('/var/lib/jenkins/workspace/java-gradle-app') {
                            sh 'chmod +x gradlew'
                            sh 'pwd'
                            sh './gradlew sonarqube'
                    }
                    //}

                   
                }  
            }
        }
    }
}