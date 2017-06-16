FROM cargomedia/base:latest

# Provision with puppet
WORKDIR '/tmp/puppet'
ADD puppet .
RUN librarian-puppet install
RUN puppet apply --modulepath=modules default.pp --detailed-exitcodes || [ $? -eq 2 ]
RUN apt-get update && apt-get install -y netcat curl redis-tools mysql-client
