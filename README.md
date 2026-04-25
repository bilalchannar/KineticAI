# KineticAI 🧬🦾

**KineticAI** is a state-of-the-art AI-powered physical monitoring and biomechanics platform. It leverages sensor fusion, machine learning, and generative AI to provide real-time tracking, injury risk detection, and personalized coaching for athletes and fitness enthusiasts.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini%20AI-8E75B2?style=for-the-badge&logo=google&logoColor=white)

---

## 🚀 Key Features

### 📡 Advanced Sensor Fusion
- **Motion Tracking:** Uses `sensors_plus` for high-frequency accelerometer and gyroscope data.
- **Environmental Awareness:** Monitors ambient light and noise levels to optimize training environments.
- **Biomechanical Analysis:** Real-time analysis of movement patterns using on-device TFLite models.

### 🤖 AI-Powered Coaching
- **Gemini Integration:** Personalized feedback and training adjustments powered by Google's Generative AI.
- **Injury Risk Detection:** Proactive alerts based on biomechanical anomalies.
- **Session Insights:** Intelligent summaries after every workout.

### 🗺️ Precision Mapping & Offline Support
- **Google Maps Integration:** Track outdoor runs and activities with precision.
- **Offline Maps:** `flutter_map` support with tile caching for training in remote areas.
- **Heatmaps:** Visualize training intensity and frequency with `flutter_heatmap_calendar`.

### 📊 Data & Analytics
- **Dynamic Charts:** Real-time data visualization using `fl_chart`.
- **Session History:** Securely stored via Firebase Firestore and Hive for local persistence.
- **Export Capabilities:** Export your sessions in CSV or JSON formats for deeper analysis.

### ☁️ Cloud Integration
- **Firebase Auth:** Secure user authentication.
- **Cloud Storage:** Backup and sync training sessions across devices.
- **Real-time Sync:** Instant synchronization of data across the ecosystem.

---

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (SDK >= 3.0.0)
- **State Management:** Riverpod (3.0.0-dev)
- **Database:** Hive (Local) & Cloud Firestore (Remote)
- **AI/ML:** TFLite & Google Generative AI (Gemini)
- **Navigation:** GoRouter
- **Mapping:** Google Maps Flutter & Flutter Map

---

## 📦 Getting Started

### Prerequisites
- Flutter SDK
- Android Studio / VS Code
- Firebase Project Setup
- Google Gemini API Key

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/bilalchannar/KineticAI.git
   cd kinetic_ai
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

Developed with ❤️ by [Bilal Channar](https://github.com/bilalchannar)
