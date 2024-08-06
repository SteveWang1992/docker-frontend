# Setup base build image
FROM node:16-alpine as builder

# Setup working directory
WORKDIR /usr/app

# Copy dependencies
COPY package.json .

# Install dependencies
RUN npm install

# Copy all the app file
COPY . .

# Build the app
RUN npm run build

# Setup nginx server
FROM nginx

# Copy the build assets
COPY --from=builder /usr/app/build /usr/share/nginx/html