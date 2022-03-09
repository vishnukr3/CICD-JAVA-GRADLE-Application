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
                    //withSonarQubeEnv(credentialsId: "sonar-token") {  
                        sh 'pwd ;ls;md5sum build.gradle'
                        
                        sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                        
                        sh './gradlew sonarqube'   // used for checking gradlew with sonar rules                   
                    //}   
                }
                timeout(time: 1, unit: 'HOURS') {
                    def waitForQualityGate()       
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"   
            
                    }
                         
            
                }                                                               
            }
        }
    }
}    
