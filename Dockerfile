# First stage - Building the application
# Use node:16-a;pine image as a parent image
FROM node:16-alpine AS build

# Create app directory
WORKDIR /usr/src/app/

# Copy package.json files to the working directory
COPY ./package.json/ /usr/src/app/

# Install app dependencies
RUN npm install

# Copy the source files
COPY . /usr/src/app/

# Build the React app for production
RUN npm run build


# Second stage - Serve the application
FROM ubuntu 
RUN apt update 
COPY --from=build /usr/src/app/ /var/www/html/
RUN apt install -y apache2
EXPOSE 80
CMD [“apache2ctl”, “-D”, “FOREGROUND”]
