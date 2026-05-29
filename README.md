# Loan SDK Package

Flutter SDK for loan onboarding and financial workflow integration.

---

# Installation

Add the SDK dependency inside your Flutter host app `pubspec.yaml`.

```yaml
dependencies:
  loan_sdk_package: ^1.0.0
```

Run:

```bash
flutter pub get
```

---

# Android Configuration

## 1. Update Android SDK Configuration

### File Path

```text
android/app/build.gradle
```

or

```text
android/app/build.gradle.kts
```

### Required Setup

```gradle
android {
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    defaultConfig {
        minSdk = 24
    }
}
```

---

## 2. Add JitPack Repository

### File Path

```text
android/build.gradle
```

or

```text
android/settings.gradle
```

### Add

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven(url = "https://jitpack.io")
    }
}
```

---

## 3. Update Kotlin Version

### Required Kotlin Version

```text
2.2.20
```

### File Path

```text
android/build.gradle
```

or

```text
android/settings.gradle
```

### Add

#### Groovy

```gradle
ext.kotlin_version = '2.2.20'
```

#### Kotlin DSL

```gradle
plugins {
    id "org.jetbrains.kotlin.android" version "2.2.20" apply false
}
```

---

## 4. AndroidManifest Configuration

### File Paths

```text
android/app/src/main/AndroidManifest.xml
android/app/src/debug/AndroidManifest.xml
```

### Add

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <application
        android:allowBackup="false"
        android:enableOnBackInvokedCallback="false"
        tools:replace="android:label,android:allowBackup,android:enableOnBackInvokedCallback">

    </application>

</manifest>
```

---

# iOS Configuration

## Update iOS Deployment Target

### File Path

```text
ios/Podfile
```

### Update

```ruby
platform :ios, '14.0'
```

---

# Clean & Rebuild

Run the following commands:

```bash
flutter clean
```

```bash
flutter pub get
```

```bash
flutter run
```

---

# Import SDK

```dart
import 'package:loan_sdk_package/loan_sdk_package.dart';
```

---

# UAT Configuration

```dart
const clientId = "your_client_id";
const clientSecret = "your_client_secret";
const anchorId = "your_anchor_id";
const environment = "uat";
const program = "your_program_id";
```

---

# PROD Configuration

```dart
const clientId = "your_client_id";
const clientSecret = "your_client_secret";
const anchorId = "your_anchor_id";
const environment = "prod";
const program = "your_program_id";
```

---

# Open SDK

```dart
LoanSdkPackage.open(
  context: context,
  environment: environment,
  sdkRequest: SdkRequest.fromJson({
    "username": "9876543210",
    "source": "MOS",
    "program": program,
    "requestId": "REQ123456789",
    "puId": "samplePuId",
    "anchorId": anchorId,
    "channel": "SDK",
    "version": "v1",
    "userContext": {
      "pan": "ABCDE1234F",
      "name": "John Doe",
      "gender": "Male",
      "email": "john.doe@example.com",
      "dob": "01-01-1995",
      "address": {
        "addressLine1": "Sector 16A",
        "addressLine2": "Near Metro Station",
        "city": "Faridabad",
        "state": "Haryana",
        "pincode": "121002"
      }
    },
    "clientMeta": {
      "productNo": "PRD001",
      "productName": "Sample Product",
      "sumInsured": 50
    }
  }),
  clientId: clientId,
  clientSecret: clientSecret,

  onClose: ({
    required String message,
    required String status,
  }) {
    debugPrint("SDK Closed");
  },

  onSuccess: ({
    required String message,
    required String status,
  }) {
    debugPrint("SDK Success");
  },

  onFailure: ({
    required String message,
    required String status,
  }) {
    debugPrint("SDK Failure");
  },
);
```

---

# Required Versions Summary

| Configuration | Required Value |
|---|---|
| compileSdk | 36 |
| minSdk | 24 |
| ndkVersion | 27.0.12077973 |
| Kotlin Version | 2.2.20 |
| iOS Deployment Target | 14.0 |

---

# Support

For integration support or SDK related issues, please contact the SDK team.