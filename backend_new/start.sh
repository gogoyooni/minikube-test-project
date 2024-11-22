#!/bin/sh

# # DB가 완전히 준비될 때까지 대기
# echo "Waiting for database to be ready..."
# npx wait-on tcp:db:5432 -t 20000

# # 초기 마이그레이션 생성 (아직 없는 경우)
# echo "Creating initial migration..."
# npx prisma migrate dev --name init

# # Prisma 마이그레이션 실행
# echo "Running migrations..."
# npx prisma migrate deploy

# # Prisma 클라이언트 생성
# echo "Generating Prisma Client..."
# npx prisma generate

# # 애플리케이션 시작
# echo "Starting application..."
# node index.js



# # DB가 완전히 준비될 때까지 대기 (타임아웃 증가)
# echo "Waiting for database to be ready..."
# npx wait-on tcp:db:5432 -t 60000

# # 초기 마이그레이션 생성
# echo "Creating initial migration..."
# npx prisma migrate dev --name init --skip-seed --skip-generate

# # Prisma 클라이언트 생성
# echo "Generating Prisma Client..."
# npx prisma generate

# # 애플리케이션 시작
# echo "Starting application..."
# node index.js

echo "Waiting for database..."
while ! nc -z db 5432; do
    echo "Waiting for database connection..."
    sleep 2
done

echo "Database is ready!"
sleep 5

# 데이터베이스 스키마 생성
echo "Creating database schema..."
npx prisma db push --accept-data-loss

# 초기 마이그레이션 생성 및 적용
echo "Running database migrations..."
npx prisma migrate dev --name init --create-only
npx prisma migrate deploy

# Prisma Client 생성
echo "Generating Prisma Client..."
npx prisma generate

# 서버 시작
echo "Starting server..."
NODE_ENV=development exec node index.js