# Use an official Node.js runtime as the base image
FROM node:18

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

COPY . .

# Expose the port on which the application will run
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
