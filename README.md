# 🌤️ JustAWeather – Flutter Weather App

JustAWeather is a simple Flutter app with a sleek, modern weather app built with Flutter using Clean Architecture and MVVM. It displays real-time weather forecasts based on your current location or any city you search for. Built for performance, responsiveness, and customization.

---

## 📱 Features

- 🌍 Current weather by **location**
- 📅 **5-day forecast** with one entry per day
- 🔍 Search for cities and view their weather
- 🌙 Light & dark **theme support**
- 🌡️ Toggle between **Celsius and Fahrenheit**
- 📍 Persistent list of favorite locations
- 📴 Offline support with cached last forecast
- 🧭 Weather background changes based on condition (e.g. rain, snow, clear)
- ⚙️ Clean, scalable **feature-based folder structure** with **MVVM**
- 🔄 Smooth animations and transitions (60fps)

---

## 🧱 Architecture

The app follows **Clean Architecture + MVVM**, split into:

```
lib/
├── core/              # Shared utilities, themes, constants, services
├── config/            # GoRouter, DI, Localization
├── features/
│   ├── weather/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   │   ├── view/
│   │   │   └── viewmodel/
│   ├── settings/
│   └── locations/
└── main.dart
```

---

## 🧪 Tech Stack

- **Flutter** 3.x
- **Riverpod** for state management
- **GoRouter** for routing
- **Dio** + **Retrofit** for networking
- **Hive** / **SharedPreferences** for local storage
- **OpenWeatherMap API** for weather data
- **Geolocator** / **Geocoding** for location services
- **Freezed** for immutability
- **Hooks** for cleaner UI logic
- **Sentry** or **Talker** for error logging

---

## 🚀 Getting Started

### Prerequisites

- Flutter 3.x
- Dart 3.x
- Get your **OpenWeatherMap API key**: https://openweathermap.org/api

### Installation

```bash
git clone https://github.com/your-username/justaweather.git
cd justaweather
flutter pub get
```

---

## 🧪 Running the App

```bash
flutter run
```

For flavor support, themes, or multiple build configs:

```bash
flutter run --flavor development
```

---

## 🧪 Testing

```bash
flutter test
```

---

## 📷 Screenshots

| Home | Forecast | Search | Settings |
|------|----------|--------|----------|
| ![](screenshots/home.png) | ![](screenshots/forecast.png) | ![](screenshots/search.png) | ![](screenshots/settings.png) |

---

## 👨‍💻 Author

**Bon Ryan (@imsuperbon)**  
iOS & Flutter Engineer • Content Creator

---

## 📄 License

MIT © 2025 Bon Ryan
