# 📱 Shield - Flutter Chat App with Real-Time Chat, Video Call, and File Sharing

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

- `core/`: Contains core functionalities, such as API handling, models, services, and utilities.
- `features/`: Each feature (Chat, Video Call, File Sharing) is modularized within this directory.
- `injection_container/`: Set up and configure dependency injection using Kiwi.
- `main.dart`: Entry point of the application.
- `app.dart`: Central point for setting up the application, routing, and theme.

## 🚀 Getting Started

### Prerequisites

- **Flutter**: Ensure you have Flutter installed on your machine. Follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
- **Supabase Account**: Create a free account on [Supabase](https://supabase.io/) and set up your project.

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/your-username/flutter-chat-app.git
   cd flutter-chat-app

