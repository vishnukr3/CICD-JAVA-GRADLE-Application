pipeline{
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"    //used to get build id of jenkins and it is just for identifying the build
    }
    stages{
        stage("Sonar Quality Check"){
            agent {
                docker {
                    image 'openjdk:11'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                            sh 'chmod +x gradlew'      //used to execute permission to gradlew file
                            sh './gradlew sonarqube'   // used for checking gradlew with sonar rules
                                                                                 
                    }
                    timeout(time: 1, unit: 'HOURS') {
                      def qg = waitForQualityGate()         //it a fn which get us JSON and it will stores on qg. and that fn will check for qiality analysis on our code
                      if (qg.status != 'OK') {
                           error "Pipeline aborted due to quality gate failure: ${qg.status}"
                      }
                    }
            
                }
            }
        }
        stage("docker build & docker push"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_password')]) {     //create docker_pass credential in jenkins and also create env variable in jenkins as docker_password
                             sh '''  
                                docker build -t 34.125.214.226:8083/springapp:${VERSION} .
                                docker login -u admin -p $docker_password 34.125.214.226:8083 
                                docker push  34.125.214.226:8083/springapp:${VERSION}
                                docker rmi 34.125.214.226:8083/springapp:${VERSION}              
                            '''
                                       //sh ''' : is used to execute multiple commands
                    }
                }
            } 
        }
    }  
}             

