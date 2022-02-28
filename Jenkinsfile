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
        stage('identifying misconfigs using datree in helm charts'){
            steps{
                script{

                    dir('kubernetes/') {                                      // to go inside kubernetes dir
                        withEnv(['DATREE_TOKEN=7kzZPYzuxZWctdJRmPYddz']) {         //I have added my datree token 
                              sh 'helm datree test myapp/'
                        }
                    }
                }
            }
        }
        stage("pushing the helm charts to nexus"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_pass', variable: 'docker_password')]) {         //pushing to nexus needed credentials like we have done this in prev stages
                          dir('kubernetes/') {     // all the command should be run inside kubernetes folder that why we use this step
                             sh '''
                                 helmversion=$( helm show chart myapp | grep version | cut -d: -f 2 | tr -d ' ')
                                 tar -czvf  myapp-${helmversion}.tgz myapp/
                                 curl -u admin:$docker_password http://34.125.214.226:8081/repository/helm-hosted/ --upload-file myapp-${helmversion}.tgz -v       
                            '''                                                                                                                                       //The heml version could be get by "helm show chart" in kubernetes directory     
                          }
                    }
                }
            } 
        } 
        stage('Deploying application on k8s cluster') {
            steps {
               script{
                   withCredentials([kubeconfigFile(credentialsId: 'kubernetes-config', variable: 'KUBECONFIG')]) {
                        dir('kubernetes/') {
                          sh 'helm upgrade --install --set image.repository="34.125.214.226:8083/springapp" --set image.tag="${VERSION}" myjavaapp myapp/ '    //it's a very inportant and efficient script ie,myjavaapp is our release name so whatever the release name if it is already there then it will upgraded otherwise it will do helm install.
                        }
                    }
               }
            }
        }      

    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "deekshith.snsep@gmail.com";  
		}
	   }    
    }  
}             

