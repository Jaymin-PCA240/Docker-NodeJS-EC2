##############################
# Stage 1 – builder
##############################
FROM public.ecr.aws/docker/library/node:18-alpine AS builder
WORKDIR /app

# install deps
COPY package.json package-lock.json tsconfig.json ./
RUN npm install

# copy source and compile
COPY src ./src
RUN npm run build          # -> creates /app/dist

##############################
# Stage 2 – runtime
##############################
FROM public.ecr.aws/docker/library/node:18-alpine
WORKDIR /app

# copy only what we actually need
COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

# Expose port
EXPOSE 3000

CMD ["npm", "start"]
