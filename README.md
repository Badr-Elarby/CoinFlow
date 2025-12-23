# CoinFlow
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Badr-Elarby/CoinFlow/tree/dev)

CoinFlow is a comprehensive and modern cryptocurrency tracking application built with Flutter. It offers real-time market data, seamless portfolio management, and a clean, responsive user interface for both light and dark modes. The app is powered by the CoinGecko API for live data and uses Firebase for secure user authentication.

## Features

- **Real-time Market Data:** Track prices, market caps, and volume for thousands of cryptocurrencies.
- **Secure Authentication:** User sign-up and login with Firebase (Email & Password), including support for biometric authentication (Fingerprint/Face ID).
- **Portfolio Management:** Add and monitor your crypto holdings, view total asset value, and track daily performance with dynamic charts.
- **Detailed Coin Insights:** Access detailed information for any cryptocurrency, including historical price charts (1D, 1W, 1M, 3M, 1Y), market statistics, and project descriptions.
- **Market Overview:** Get a quick snapshot of the crypto market with global stats on the home screen.
- **Discover:** Stay updated with dedicated sections for "Trending Now" and "Top Gainers".
- **Dynamic Theming:** Smoothly switch between a polished light mode and a sleek dark mode.
- **Responsive UI:** The interface is designed to adapt gracefully to different screen sizes and orientations.
- **Crypto Purchase Simulation:** A feature to simulate the process of buying cryptocurrency.

## Architecture

CoinFlow is built with a clean, feature-first architecture that promotes scalability and maintainability.

- **State Management:** **Bloc/Cubit** for predictable and robust state management.
- **Navigation:** **GoRouter** for a declarative and powerful routing solution.
- **Networking:** **Dio** for making API requests, integrated with a **Repository Pattern** to abstract data sources.
- **Dependency Injection:** **GetIt** for managing dependencies and decoupling components.
- **Data Sources:**
  - **CoinGecko API:** For all cryptocurrency market data.
  - **Firebase Authentication:** For user management.
- **Code Generation:** Utilizes `json_serializable` and `retrofit` to minimize boilerplate code for models and API clients.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK (version 3.9.2 or higher)
- An IDE such as Android Studio or VS Code

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/badr-elarby/coinflow.git
    cd coinflow
    ```

2.  **Configure API Key:**
    The project uses the CoinGecko API. You will need an API key to make requests.

    - Create a new file at `lib/core/networking/api_secrets.dart`.
    - Add your CoinGecko API key to the file as follows:
      ```dart
      // lib/core/networking/api_secrets.dart
      class ApiSecrets {
        static const String apiKey = 'YOUR_COINGECKO_API_KEY';
      }
      ```

3.  **Set up Firebase:**
    This project is configured to use Firebase for authentication. To connect it to your own Firebase project:
    - Ensure you have the Firebase CLI installed.
    - Run the following command and follow the prompts to connect your Firebase project:
      ```sh
      flutterfire configure
      ```
    This will generate your own `firebase_options.dart` and update the necessary platform-specific files.

4.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

5.  **Run the code generator:**
    This step is necessary to generate files for dependency injection, JSON serialization, and API clients.
    ```sh
    dart run build_runner build --delete-conflicting-outputs
    ```

6.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Structure

The project follows a feature-first directory structure to keep the codebase organized and modular.

```
lib/
├── core/                  # Shared utilities, services, and widgets
│   ├── app_cubit/         # Global app state (theming, connectivity)
│   ├── di/                # Dependency injection setup (GetIt)
│   ├── helpers/           # Utility functions (regex, shared_pref)
│   ├── networking/        # API client, error handling, interceptors
│   ├── responsive/        # Responsive layout helpers
│   ├── routing/           # App navigation (GoRouter)
│   ├── shared_widgets/    # Reusable widgets (buttons, text fields)
│   └── theming/           # App themes, colors, and text styles
│
└── features/              # Individual feature modules
    ├── auth/              # Authentication (sign-in, sign-up)
    ├── buy_crypto/        # Crypto purchase simulation
    ├── coin_details/      # Detailed coin view with charts
    ├── home/              # Main home screen
    ├── market/            # Crypto market list and search
    ├── onboarding/        # First-time user onboarding screens
    ├── portfolio/         # User's portfolio and holdings
    ├── settings/          # App settings (e.g., dark mode)
    └── splash/            # Splash screen
