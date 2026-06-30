# 📥 Y2Save - Premium YouTube Video & Audio Downloader

A modern, fast, and responsive YouTube video and audio downloader web application built using **Next.js (React + API Routes)**, compiled with **Tailwind CSS v4 (Latest)**, and powered by the robust **yt-dlp** command-line utility. 

This application runs locally on your machine, enabling direct-to-disk high-speed downloads without server bandwidth restrictions or file size limitations.

---

## ✨ Features

- **Modern Glassmorphic UI**: Premium aesthetics using clean colors, gradients, dark/light mode toggles, micro-animations, and full mobile-first responsive design.
- **Subtitles & Multi-Audio Support**: Automatically detects and lets you choose dubbed audio languages (e.g. Hindi, French, Spanish) and subtitle tracks.
- **HQ Merging**: Downloads and merges high-resolution 1080p and 4K video streams with audio automatically using **FFmpeg**.
- **Download History & Favorites**: Persisted locally in the browser (LocalStorage) so your data stays on your machine.
- **Asynchronous Processing**: Background downloads prevent HTTP timeouts, with polling progress meters displaying percentages, speeds, and ETAs.
- **Comprehensive API Middleware**: Built-in IP rate limiting, input validation, and secure headers (similar to Helmet).
- **One-Click Actions**: One-click URL pasting, direct download-to-directory pathing, and quick re-downloads from history lists.

---

## 🛠️ Tech Stack

- **Frontend**: Next.js App Router, React 19, Framer Motion, Axios, React Query, Lucide Icons.
- **Backend (Next.js Route Handlers)**: Node.js, child-process spawns.
- **Styling**: Tailwind CSS v4.
- **Download Engine**: Python + `yt-dlp`.
- **Media Transcoder**: FFmpeg.

---

## 🚀 Setup & Installation

### Prerequisites

Ensure you have the following installed on your machine:
- **Node.js** (v18.0.0 or higher)
- **Python 3** (added to PATH)
- **FFmpeg** (added to PATH, needed for video/audio merging)

---

### Method 1: Local Run (Recommended)

1. **Clone or copy this folder** to your target directory.
2. **Install node dependencies**:
   ```bash
   npm install
   ```
3. **Verify yt-dlp is installed**:
   Install or upgrade `yt-dlp` using pip:
   ```bash
   python -m pip install -U yt-dlp
   ```
4. **Run the Development Server**:
   ```bash
   npm run dev
   ```
5. **Open the Application**:
   Navigate to [http://localhost:3000](http://localhost:3000) in your web browser.

---

### Method 2: Docker Setup

We provide a multi-stage Docker setup that bundles Node.js, Python, FFmpeg, and `yt-dlp` in a unified image.

1. **Build and start services using Docker Compose**:
   ```bash
   docker-compose up -d --build
   ```
2. **Open the Application**:
   Access the app at `http://localhost:3000`.

---

## 📝 API Documentation

### 1. Resolve Video Info
Get available download formats, resolutions, audio tracks, and subtitles for a YouTube URL.

- **Endpoint**: `/api/info`
- **Method**: `GET`
- **Parameters**: `url` (URL-encoded YouTube video URL)
- **Response Example**:
  ```json
  {
    "id": "UIGZtoGGPH4",
    "url": "https://www.youtube.com/watch?v=UIGZtoGGPH4",
    "title": "Example Video Title",
    "thumbnail": "https://img.youtube.com/vi/UIGZtoGGPH4/hqdefault.jpg",
    "duration": 240,
    "channel": "Channel Name",
    "formats": [
      {
        "formatId": "137",
        "ext": "mp4",
        "resolution": "1920x1080",
        "filesize": 474057507,
        "fps": 30,
        "isVideo": true,
        "isAudio": false
      }
    ]
  }
  ```

### 2. Trigger Download
Launch an asynchronous background download job.

- **Endpoint**: `/api/download`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "url": "https://www.youtube.com/watch?v=UIGZtoGGPH4",
    "formatId": "137",
    "audioFormatId": "140",
    "title": "Example Video Title"
  }
  ```
- **Response**:
  ```json
  {
    "downloadId": "a1b2c3d4e5",
    "status": "downloading",
    "message": "Download started in background."
  }
  ```

### 3. Track Progress
Get live statistics (percentage, size, speed, ETA) of an active download.

- **Endpoint**: `/api/progress`
- **Method**: `GET`
- **Parameters**: `id` (The generated `downloadId`)
- **Response**:
  ```json
  {
    "id": "a1b2c3d4e5",
    "status": "downloading",
    "progress": 42.5,
    "speed": "2.4 MiB/s",
    "eta": "00:12",
    "totalSize": "140.2MiB"
  }
  ```

### 4. Cancel Download
Kill the child downloader process and clean up temporary files.

- **Endpoint**: `/api/cancel`
- **Method**: `POST`
- **Body**:
  ```json
  {
    "id": "a1b2c3d4e5"
  }
  ```
- **Response**:
  ```json
  {
    "message": "Download cancelled successfully."
  }
  ```

---

## 🔒 Security & Optimization

- **Rate Limiting**: Built-in token bucket-like check by client IP address to prevent abuse.
- **Secure Headers**: Custom response headers including Content-Security-Policy (CSP), Strict-Transport-Security (HSTS), X-Frame-Options, X-Content-Type-Options.
- **Cross-Origin Resource Sharing (CORS)**: Configured safe CORS options.
- **Sanitized Filenames**: Overwrites characters unsafe for Windows/Unix filenames before writing to disk.

---

## 📄 License

This project is built for local development, academic purposes, and personal data backups. Please refer to individual platform terms before downloading copyrighted media.
