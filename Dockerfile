FROM node:lts-alpine as development

ENV NODE_ENV=development

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Build and Run Tests
FROM node:lts-alpine as builder

COPY --from=development /app /app

WORKDIR /app

RUN npm run build

# Build Production Image
FROM node:lts-alpine as production

ENV NODE_ENV=production

WORKDIR /app

COPY --from=builder ./app/dist ./dist

COPY package* ./

RUN npm install --only=production

CMD ["npm", "start"]