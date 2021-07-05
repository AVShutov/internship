#!/bin/bash
set -e
set -x

psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE DATABASE task6_db;
    \c task6_db;
    create table if not exists Students(
                id serial primary key,
                StudentId int not null,
                Student varchar (127) not null);

    create table if not exists Result(
                id serial primary key,
                StudentId int not null,
                Task1 varchar (127) not null,
                Task2 varchar (127) not null,
                Task3 varchar (127) not null,
                Task4 varchar (127) not null,
                Task5 varchar (127) not null);
    \copy Students(StudentId,Student) FROM '/data/Students.csv' DELIMITER ',' CSV HEADER;
    \copy Result(StudentId,Task1,Task2,Task3,Task4,Task5) FROM '/data/Result.csv' DELIMITER ',' CSV HEADER;
    CREATE USER replica_user WITH REPLICATION ENCRYPTED PASSWORD '${REPLICA_PASSWORD}';
    SELECT * FROM pg_create_physical_replication_slot('replication_slot_slave1');
EOSQL

#export PGPASSWORD="$POSTGRES_PASSWORD"
#psql -U postgres -h localhost -c "\copy Students(Student,StudentId) FROM './Students.csv' DELIMITER ',' CSV HEADER;" task6_db
#psql -U postgres -h localhost -c "\copy Result(StudentId,Task1,Task2,Task3,Task4,Task5) FROM './Result.csv' DELIMITER ',' CSV HEADER;" task6_db
