FROM registry.access.redhat.com/hi/core-runtime:latest

RUN echo "Challenge flag: $(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)" > /var/tmp/otq-challenge-flag.txt
 
CMD cat /var/tmp/otq-challenge-flag.txt