# this is multi stage "base means alias name"
FROM openjdk:11 as base 
WORKDIR /app
#COPY . . --> MEANS what ever in our codes to /app in the docker  the second dot means working dir of docker ie, /app
COPY . .                         
RUN chmod +x gradlew
RUN ./gradlew build 

FROM tomcat:9
WORKDIR webapps
#the below step we're used base ie, /app of openjdk container is coped and pushed to /webapps of tomcat 
#sampleWeb-0.0.1-SNAPSHOT.war : the artifact name which we can get from build.gradle
COPY --from=base /app/build/libs/sampleWeb-0.0.1-SNAPSHOT.war .
#the below code is very imp bcoz whenever we access our app we should give http://ip:port/ sampleWeb-0.0.1-SNAPSHOT.war, this is not good that is y we reomed root directory and rename war file to root.war
RUN rm -rf ROOT && mv sampleWeb-0.0.1-SNAPSHOT.war ROOT.war
