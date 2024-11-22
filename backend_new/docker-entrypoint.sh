#!/bin/sh

# DB가 완전히 준비될 때까지 대기
echo "Waiting for database to be ready..."
npx wait-on tcp:db:5432 -t 20000

# 초기 마이그레이션 생성 (아직 없는 경우)
echo "Creating initial migration..."
npx prisma migrate dev --name init

# Prisma 마이그레이션 실행
echo "Running migrations..."
npx prisma migrate deploy

# Prisma 클라이언트 생성
echo "Generating Prisma Client..."
npx prisma generate

# 애플리케이션 시작
echo "Starting application..."
node index.js