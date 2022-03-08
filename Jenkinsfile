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
                        -D sonar.login=admin \
                        -D sonar.password=sonar \
                        -D sonar.host.url=http://34.125.171.139:9000/"
                        //sh "sudo chmod +777 /var/run/docker.sock"
                        sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                        sh './gradlew sonarqube'   // used for checking gradlew with sonar rules
                    }    
                }                                                                 
            }
        }
    }
}    
