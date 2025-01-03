# FROM node:20

# WORKDIR /app

# COPY package*.json ./

# RUN npm install

# COPY prisma ./prisma

# RUN npx prisma generate

# COPY . .

# EXPOSE 5555

# CMD ["node", "index.js"]



# FROM node:18-alpine

# WORKDIR /app

# COPY package*.json ./
# #마이그레이션 파일 포함
# COPY prisma ./prisma/    

# RUN npm install

# COPY . .

# EXPOSE 5555

# RUN npx prisma generate

# # 컨테이너 시작 시 마이그레이션 실행
# CMD npx prisma migrate deploy && node index.js



# # 명시적으로 amd64 플랫폼 지정
# FROM --platform=linux/amd64 node:18-slim

# WORKDIR /app

# COPY package*.json ./
# #마이그레이션 파일 포함
# COPY prisma ./prisma/    

# RUN npm install

# COPY . .

# EXPOSE 5555

# RUN npx prisma generate

# # 컨테이너 시작 시 마이그레이션 실행
# CMD npx prisma migrate deploy && node index.js


FROM node:20

WORKDIR /app

# OpenSSL 설치 명령어 추가
# RUN apt-get update -y && apt-get install -y openssl libssl-dev
# OpenSSL, PostgreSQL 클라이언트, netcat 설치
RUN apt-get update -y && \
    apt-get install -y openssl libssl-dev postgresql-client netcat-traditional && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY package*.json ./
COPY prisma ./prisma/    

RUN npm install

COPY . .

EXPOSE 8080

RUN npx prisma generate


# 시작 스크립트 생성
COPY start.sh /app/start.prod.sh
RUN chmod +x /app/start.prod.sh

# 컨테이너 실행 시점에 start.sh 실행
CMD ["/app/start.sh"]

# # # 엔트리포인트 설정
# ENTRYPOINT ["docker-entrypoint.sh"]


