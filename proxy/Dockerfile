# Node LTS 10.15 with alpine
# (a lightweight distribution)
FROM node:10.15.3-alpine
LABEL maintainer="Arthur D. <https://www.arthurdufour.com/>"

# creates a directory for the app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# install the app
COPY package*.json ./
RUN npm install

EXPOSE 3001

# bundle all source code
COPY . . 
