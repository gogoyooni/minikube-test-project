#!/bin/sh

echo "Waiting for database..."
while ! nc -z db 5432; do
    echo "Waiting for database connection..."
    sleep 2
done

echo "Database is ready!"
sleep 5

# Prisma 설정
echo "Setting up database..."
npx prisma generate

# Production 환경에서는 db push 사용
echo "Pushing database schema..."
npx prisma db push --accept-data-loss

# 서버 시작 (production 모드)
echo "Starting server..."
NODE_ENV=production exec node index.js