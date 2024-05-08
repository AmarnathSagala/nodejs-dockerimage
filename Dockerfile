# FROM node:latest
# WORKDIR /usr/src/app
# COPY nodeapp/* /
# RUN npm install
# EXPOSE 3000
# CMD [ "npm","start" ]

FROM amazonlinux:3

WORKDIR /usr/src/app
COPY nodeapp/* /
RUN amazon-linux-extras enable nodejs && yum install -y nodejs

# Install dependencies
RUN npm install

EXPOSE 3000

# Install Apache httpd
RUN yum install -y httpd httpd-tools

# Open port 80 in the firewall (adjust firewall command based on your system)
RUN firewall-cmd --permanent --add-port=80/tcp
RUN firewall-cmd --reload  # Reload firewall rules

# **Note:** Opening port 80 exposes your server to potential attacks. Ensure proper security measures are in place before running this command in a production environment.

CMD [ "npm", "start" ]

