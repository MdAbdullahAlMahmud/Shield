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

```
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
```

- `core/`: Contains core functionalities, such as API handling, models, services, and utilities.
- `features/`: Each feature (Chat, Video Call, File Sharing) is modularized within this directory.
- `injection_container/`: Set up and configure dependency injection using Kiwi.
- `main.dart`: Entry point of the application.
- `app.dart`: Central point for setting up the application, routing, and theme.

## 🚀 Getting Started

### Prerequisites

- **Flutter**: Ensure you have Flutter installed on your machine. Follow the official Flutter installation guide.
- **Supabase Account**: Create a free account on Supabase and set up your project.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/flutter-chat-app.git
   cd flutter-chat-app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**:
   - Create a `.env` file in the root directory and add your Supabase project URL and anon key.
   - Configure the database schema and tables as needed.

4. **Run the application**:
   ```bash
   flutter run
   ```

### Running with Different Flavors

The project supports multiple build variants (flavors) for different environments (e.g., development, staging, production).

To run the app with a specific flavor, use:
```bash
flutter run --flavor <flavor_name> -t lib/main_<flavor_name>.dart
```

For example:
```bash
flutter run --flavor development -t lib/main_development.dart
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps to contribute:

1. **Fork the repository**.
2. **Create a new branch** with a descriptive name.
3. **Make your changes**.
4. **Submit a pull request**.

## 📝 License

This project is licensed under the MIT License. See the LICENSE file for details.

## 💬 Contact

For any questions, suggestions, or issues, feel free to open an issue or contact me via email@example.com.
