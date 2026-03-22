# FlutNews - Flutter Interview Task

A robust, beautifully designed News application built natively in Flutter, designed as a practical assignment presentation.

## Features & Highlights

This modular application satisfies and heavily expands upon the required assignment specifications:

*   **Public REST API Integration:** Cleanly fetches and parses live articles from NewsAPI (`apiService.fetchNews`).
*   **Fully Responsive Display:** Dynamically resizes based on constraints. Displays a refined vertical `ListView` on mobiles, and smoothly transitions into a 2-column or 3-column `GridView` on desktops and tablets to harness wider aspect ratios cleanly.
*   **Advanced Numerical Pagination:** Built from scratch to allow the user to effortlessly request specific pages, eliminating the jitter, duplicate glitches, and strict developer rate limits commonly caused by infinite scroll.
*   **Custom Shimmer Loading State:** Uses a natively built animated Shimmer (`_ShimmerNewsTile`) directly mapped to `ListView` and `GridView` constraints, completely replacing mundane loading spinners for a premium user feel.
*   **Intelligent Offline Caching:**
    *   **Accumulative Storage:** Uses `SharedPreferences` to cumulatively cache all previously pulled articles, ensuring no articles are overwritten or lost when offline.
    *   **Chunked Offline Pagination:** Safely intercepts network exceptions and mathematically slices the massive monolithic cache back into 10-article chunks, simulating a live server perfectly even in Airplane Mode.
*   **Graceful Status Management:**
    *   Complete `NewsBloc` integration capturing `Loading`, `Loaded`, and `Error` routing.
    *   Frictionless Error state resolving cleanly with an actionable `Retry` interface.
    *   Sleek empty-state routing (`No News Found`) allowing for intuitive pull-to-refresh swipe gestures inside an empty container using `AlwaysScrollableScrollPhysics`.
*   **UX/UI Customizations:**
    *   Animated custom Splash Screen rendering native logo drops.
    *   Modern dark-card neumorphic aesthetics featuring neon gradient glows, scaling interactiveness, and hover support.
    *   Links automatically routed directly to default OS web browsers using `url_launcher`.

## Project Structure

The project inherently observes rigorous separation of logic layers, adhering to Clean Architecture principles:

*   **`lib/bloc/`**: Core state management routing holding all states (`news_state.dart`), event handlers (`news_event.dart`), and logic hooks (`news_bloc.dart`).
*   **`lib/data/Model/`**: Holds strictly typed definition `news_model.dart` structuring the API payload securely.
*   **`lib/data/repository/`**: Exposes the `news_repository.dart` that intercepts service calls, handles dynamic cache appending, and serves mocked offline chunks.
*   **`lib/data/services/`**: Holds the `api_service.dart` interface tightly scoped around the NewsAPI HTTP handshake.
*   **`lib/ui/`**: Complete presentation layer housing the responsive `news_screen.dart`, interactive `news_tile.dart`, and customized `splash_screen.dart`.

## Packages Used

*   `flutter_bloc`: Highly dependable UI state rendering decoupling engine logic from widgets.
*   `http`: Safely routes API GET requests natively.
*   `shared_preferences`: Natively routes lightweight JSON strings permanently to the device disk for cumulative capability offline.
*   `url_launcher`: Offloads full-article view processing gracefully to native Chrome/Safari instances natively via intent filters.
*   `intl`: Gracefully decodes ISO timestamps and safely reformats publication dates globally.

## Setup Instructions

1. Ensure the Flutter SDK is correctly mapped locally (`flutter doctor`).
2. Run `flutter pub get` inside the terminal to install listed dependencies.
3. If running a Release android build `flutter build apk`, ensure the `AndroidManifest.xml` natively permits internet filtering (which is correctly already implemented in line 2).
4. Run `flutter run` on any connected emulation target.
