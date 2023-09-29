FROM node:latest
WORKDIR /app
COPY . .
RUN npn install 
EXPOSE 5000
ENTRYPOINT ["npn", "start"]