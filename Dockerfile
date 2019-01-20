# the build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# the run phase to download nginx and start the container
FROM nginx
# aws bs will map directly to the port 80 
EXPOSE 80 
# copy the result file from the build phase to the /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html