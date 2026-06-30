# Base image with Node.js
FROM node:20-alpine AS base

# Install python3, ffmpeg, and build dependencies
RUN apk add --no-cache python3 py3-pip ffmpeg build-base

# Create a symlink for python
RUN ln -sf python3 /usr/bin/python

# Create virtual environment and install yt-dlp inside it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir yt-dlp

# Set up working directory
WORKDIR /app

# Install dependencies first (leverage Docker caching)
COPY package*.json ./
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build Next.js project
RUN npm run build

# Expose server port
EXPOSE 3000

# Set environment to production
ENV NODE_ENV=production
ENV PORT=3000

# Run Next.js server
CMD ["npm", "start"]
