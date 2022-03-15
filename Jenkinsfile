pipeline{
    agent any 
    environment{
        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage("sonar quality check"){
            //agent {
                //docker {
                //    image 'openjdk:11'
              //  }
            //}
            agent none
            steps{
                script{
                    withSonarQubeEnv() {
                            //sh "sudo chmod 777  /var/run/docker.sock"
                            sh 'chmod +x gradlew'
                            sh './gradlew sonarqube'
                    }

                   
                }  
            }
        }
    }
}