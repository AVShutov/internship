FROM openjdk:8
# Install postgresql-client
RUN apt-get update && apt-get install -y postgresql-client

COPY ./Main.java /java-app/Main.java
COPY ./wait-for-postgres.sh /java-app/wait-for-postgres.sh

WORKDIR /java-app
RUN javac Main.java
CMD ["java", "Main"]