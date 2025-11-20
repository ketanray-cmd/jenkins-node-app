# Use official Node image
FROM node:18
#
WORKDIR /app
####
####
COPY package*.json ./

#dfs
RUN npm install

COPY . .   
#
EXPOSE 3000
#
CMD ["npm", "start"]
