f# 🌸 Flower Shop - Flutter E-commerce Application

## 💻 Project Description

### 🎯 Overview
Flower Shop is a modern Flutter e-commerce application designed to provide a seamless and engaging flower shopping experience. The application follows Clean Architecture principles with a feature-based modular structure to ensure scalability, maintainability, and high performance.

The app allows users to browse products, manage carts, complete secure payments, manage delivery addresses, and track orders, all within a smooth and responsive user interface.

---

## 🏗️ Architecture and Structure

The project follows a **Modified Clean Architecture** approach to ensure clear separation of concerns and maintainable code structure.

| Layer | Folder(s) | Role & Responsibilities |
| :--- | :--- | :--- |
| **Presentation** | `presentation` (screens, widgets, cubits) | Handles UI rendering and user interaction using Bloc/Cubit for state management. |
| **Domain** | `domain` (entities, repos, usecases) | Contains business logic, entities, and repository contracts independent of data sources. |
| **Data** | `data` (models, datasource, repos) | Handles API calls, local storage, and data mapping between models and entities. |
| **Core / API** | `core/api_manager` | Centralized networking using Dio & Retrofit with interceptors and error handling. |

---

## ✨ Key Features

- **Authentication & Security**
  - Login and Registration flow
  - OTP verification
  - Secure session management

- **Home & Discovery**
  - Dynamic homepage with banners and categories
  - Best seller products
  - Smart search functionality

- **Shopping Experience**
  - Advanced cart management using `CartCubit`
  - Product details with image galleries
  - Smooth multi-step checkout process

- **Payments Integration**
  - Stripe payment integration
  - External payment redirection handling
  - Emulator testing flow for successful payments

- **Location & Address Management**
  - Google Maps integration
  - Multiple saved addresses
  - Geolocation support

- **Profile & Personalization**
  - User profile dashboard
  - Language switching (Arabic / English)
  - Theme switching
  - Order history tracking

- **Notifications**
  - Firebase Cloud Messaging (FCM)
  - Local notifications for order updates

- **State Management**
  - Bloc/Cubit architecture
  - Reactive UI updates

- **Localization**
  - easy_localization with RTL support

- **Dependency Injection**
  - GetIt & Injectable for scalable dependency management

---

## 🖼️ ScreenShots

### 🔐 Authentication
<div style="display: flex; gap: 10px;">
  <img src="assets/ScreenShots/login.png" width="150"/>
  <img src="assets/ScreenShots/register.png" width="150"/>
  <img src="assets/ScreenShots/forgot_pass.png" width="150"/>
  <img src="assets/ScreenShots/reset_password.png" width="150"/>
  <img src="assets/ScreenShots/otp.png" width="150"/>
</div>

---

### 🏠 Home & Discovery
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/ScreenShots/home.png" width="150"/>
  <img src="assets/ScreenShots/categories.png" width="150"/>
  <img src="assets/ScreenShots/search.png" width="150"/>
  <img src="assets/ScreenShots/filter.png" width="150"/>
  <img src="assets/ScreenShots/product_details.png" width="150"/>
</div>

---

### 🛍️ Cart & Checkout
<div style="display: flex; gap: 10px;">
  <img src="assets/ScreenShots/cart.png" width="150"/>
  <img src="assets/ScreenShots/checkout.png" width="150"/>
  <img src="assets/ScreenShots/payment.png" width="150"/>
</div>

---

### 📍 Address & Location
<div style="display: flex; gap: 10px;">
  <img src="assets/ScreenShots/add_address.png" width="150"/>
  <img src="assets/ScreenShots/saved_address.png" width="150"/>
  <img src="assets/ScreenShots/location_permission.png" width="150"/>
</div>

---

### 👤 Profile & Settings
<div style="display: flex; gap: 10px; flex-wrap: wrap;">
  <img src="assets/ScreenShots/Profile.png" width="150"/>
  <img src="assets/ScreenShots/ar_profile.png" width="150"/>
  <img src="assets/ScreenShots/language.png" width="150"/>
  <img src="assets/ScreenShots/notifications.png" width="150"/>
  <img src="assets/ScreenShots/orders.png" width="150"/>
</div>

---

### 📄 Additional Screens
<div style="display: flex; gap: 10px;">
  <img src="assets/ScreenShots/about_us.png" width="150"/>
  <img src="assets/ScreenShots/terms_and_cond.png" width="150"/>
  <img src="assets/ScreenShots/notification_per.png" width="150"/>
</div>

---

## 🚀 Getting Started

```bash
git clone <your-repo-link>
cd flower_shop
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
