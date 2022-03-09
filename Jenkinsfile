pipeline{
    agent any
    stages{
        stage("Sonar Quality Check"){
            // agent {
            //     docker {
            //         image 'openjdk:11'
            //     }
            // }
            agent none
            steps{
                script{
                    //withSonarQubeEnv("sonarqube-8.9.7") {  
                        sh 'pwd ;ls;md5sum build.gradle'
                        
                        sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                        
                        sh './gradlew sonarqube'   // used for checking gradlew with sonar rules                   
                    //}    
                }                                                                 
            }
        }
    }
}    
