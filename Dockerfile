FROM openjdk:17
ADD target/assesment-0.0.1-SNAPSHOT.jar assesment.jar
ENTRYPOINT ["java","-jar","assesment.jar"]