# StockView

A Flutter application that provides cryptocurrency market data and analysis, inspired by TradingView.

This app displays a list of top cryptocurrencies and provides a detailed view for each coin, including an interactive candlestick chart and buy recommendations based on technical analysis strategies.

## Features

- **Top 20 Coin List**: Displays the top 20 cryptocurrencies sorted by market capitalization.
- **Interactive Candlestick Chart**: The detail screen features a candlestick chart with the following functionalities:
  - **Zoom**: Use the mouse wheel to zoom in and out.
  - **Pan**: Click and drag to pan the chart horizontally.
  - **Crosshair/Trackball**: Tap on the chart to see detailed information for a specific data point.
- **Technical Analysis**: Automatically analyzes chart data to provide buy recommendations.
  - **Strategies**: 20-day Moving Average, Rising Divergence (simplified).
  - **Visual Indicators**: Buy recommendations are clearly marked on the chart.
- **TradingView-inspired Design**: Features a professional dark theme, clear data visualization, and a responsive layout.

## Tech Stack

- **Framework**: Flutter
- **Architecture**: Clean Architecture (Data, Domain, Presentation layers) with MVVM pattern.
- **State Management**: Provider
- **Charting**: `syncfusion_flutter_charts`
- **Data Source**: CoinGecko API
- **Typography**: `google_fonts`

## Getting Started

### Prerequisites

- Flutter SDK installed.
- A configured IDE (like VS Code or Android Studio).

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/odododot/repository.git
   cd repository
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the application:**
   ```sh
   flutter run
   ```

## Project Structure

The project follows the principles of Clean Architecture to ensure a separation of concerns, making the codebase scalable and maintainable.

- `lib/`
  - `main.dart`: The entry point of the application, responsible for setting up dependency injection.
  - `data/`: Contains the data layer, responsible for fetching data from remote (API) and local sources.
    - `model/`: Data Transfer Objects (DTOs).
    - `data_source/`: Interfaces and implementations for data sources.
    - `repository/`: Implementation of the domain layer's repository interface.
  - `domain/`: Contains the core business logic and rules of the application.
    - `entity/`: Core business objects.
    - `repository/`: Abstract repository interfaces.
    - `use_case/`: Individual business logic units.
  - `presentation/`: Contains the UI layer, built using the MVVM pattern.
    - `view/`: The Flutter widgets (screens).
    - `viewmodel/`: The ViewModels (`ChangeNotifier`s) that hold the UI state.
    - `widget/`: Reusable UI components.