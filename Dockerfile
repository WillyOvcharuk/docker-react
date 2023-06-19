FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# another stage starts when another 'FROM' is called
FROM nginx
# we can copy data from another stage by specifying '--from'
# than name of the phase in our case 'builder'
# from directory and to directory
COPY --from=builder /app/build /usr/share/nginx/html