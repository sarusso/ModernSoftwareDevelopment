#!/bin/bash

COMMAND="docker pull gcc:5.4"
echo -e "\n\nWill now pull gcc 5.4 Docker container"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="docker run gcc:5.4 gcc -v"
echo -e "\n\nWill now run "gcc -v" command inside the gcc:5.4 Docker container"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND



COMMAND="docker run -v$PWD/:/data gcc:5.4 gcc --verbose -o /data/Test/test.bin /data/Test/test.c"
echo -e "\n\nWill now compile the Test/test.c inside the gcc:5.4 Docker container using volumes"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND

COMMAND="ls -alh Test"
echo -e "\n\nWill now list the contents of the 'Test' directory to show that there is a new 'test.bin' file"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="docker run -v$PWD/:/data gcc:5.4 /data/Test/test.bin"
echo -e "\n\nWill now run the Test/test.bin binary inside the gcc:5.4 Docker container using volumes"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND



# Inside the container
COMMAND="docker run -it gcc:5.4 bash"
echo -e "\n\nWill now execute a bash shell inside the gcc5:4 container in interactive mode (-it) so that we can have a look around.\n"
echo -e "Try 'ps -ef', 'ip addr show dev eth0', and opening a new terminal window and typing there 'docker ps'. Then, type 'exit' to execute."
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND



# Dockerfile
COMMAND="cat Test/Dockerfile"
echo -e "\n\nWill now show you the Test/Dockerfile content, since we are using it as source for building our own container"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="docker build --no-cache Test -testcontainer"
echo -e "\n\nWill now build our own container (without cache), tagging it as 'testcontainer'. This will copy the test.c file inside the container and then build it using  container's gcc  (no volumes)."
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="docker build Test -t testcontainer"
echo -e "\n\nIf we build again the 'testcontainer' exactly as we just did without disabling the cache, Docker is smart enough to re-use what he already built."
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="docker run testcontainer /opt/test.bin"
echo -e "\n\nLet's now run run out 'testocontainer' and execute the '/opt/test.bin' executable that is part of the container (no volumes)"
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND


COMMAND="exit 0"
echo -e "\n\nWell done, this is the end of the tutorial."
echo -e "\nCommand: $COMMAND"
read -p "Press enter to execute..."
echo ""

$COMMAND





