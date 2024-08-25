# 📱 Sheild - Flutter Chat App with Real-Time Chat, Video Call, and File Sharing

Welcome to the **Shield**! This open-source project is a feature-rich mobile application built using Flutter, allowing users to engage in real-time chat, video calls, and file sharing. The project utilizes Supabase and WebSocket to ensure a smooth and responsive user experience, and is designed with scalability and flexibility in mind, thanks to a well-organized architecture and modern Flutter development practices.

## 🎯 Features

- **Real-Time Chat**: Instant messaging with support for text, images, and emojis.
- **Video Call**: High-quality, low-latency video calling using WebRTC.
- **File Sharing**: Share images, documents, and other files seamlessly.
- **Authentication**: Secure user authentication and management with Supabase.
- **Multi-Flavor Support**: Easily switch between different build variants using Flutter's flavoring system.
- **State Management**: Efficient and scalable state management using GetX.
- **Routing**: Simplified and powerful navigation using GoRouter.
- **Dependency Injection**: Clean architecture with Kiwi for dependency injection.

## 🛠️ Technology Stack

- **Flutter**: Cross-platform mobile development framework.
- **Supabase**: Open-source Firebase alternative for backend services.
- **WebSocket**: Real-time communication protocol for chat and video calling.
- **GetX**: Lightweight and powerful state management solution.
- **GoRouter**: Declarative routing for Flutter.
- **Kiwi**: Dependency injection container for Dart.
- **Flutter Flavors**: Manage multiple build variants with ease.

## 📂 Project Structure

```bash
lib/
├── core/
│   ├── api/
│   ├── models/
│   ├── services/
│   └── utils/
├── features/
│   ├── chat/
│   ├── video_call/
│   └── file_share/
├── injection_container/
│   └── kiwi_injection.dart
├── main.dart
└── app.dart
