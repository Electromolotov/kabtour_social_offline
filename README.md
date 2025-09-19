# Kabtour Social – Offline MVP (Flutter)

This is an **offline-only social media system** for the Kabtour app. Users can create, view, and manage content **without internet**. All media and data are stored **persistently on-device** using Hive and the app documents directory.

## Key Screens
- **Main Screen (Feed):** browse all local posts.
- **Detail Content:** view post details.
- **Content Manager:** edit caption, archive/unarchive, delete.
- **Content Creation:** create content from **gallery** or **camera**.

## Architecture & Choices
- **Flutter + Material 3**
- **DI:** `get_it` for dependency injection (see `core/di/locator.dart`).
- **Storage:** `hive` for structured data; media files copied to app documents via `path_provider`.
- **Media:** `image_picker` for camera/gallery.
- **State:** `provider` + lightweight controllers.
- **Offline-first:** No network calls. Designed so a future SyncService can be introduced without touching UI.

## Assumptions
- Single local user (no auth). All content belongs to the device owner.
- Images only (videos can be added similarly by extending `MediaType`).
- Caption editing only (media replacement not implemented in MVP).

## Setup & Run
> Requires Flutter **3.22+** and Dart **3.3+**.

```bash
git clone <this-zip-extracted-folder> kabtour_social_offline
cd kabtour_social_offline

# 1) Bootstrap platform folders (only first time)
flutter create .

# 2) Get packages
flutter pub get

# 3) (Android) Ensure permissions in AndroidManifest (usually auto-merged by plugins).
#    If needed, open android/app/src/main/AndroidManifest.xml and add:
#    <uses-permission android:name="android.permission.CAMERA" />
#    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
#    (For older Android) <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

# 4) (iOS) In ios/Runner/Info.plist ensure keys exist:
#    NSCameraUsageDescription, NSPhotoLibraryUsageDescription

# 5) Run
flutter run
```

## Tests
- **Unit tests**: `flutter test`
- **Integration test** (basic app boot & UI presence): `flutter test integration_test`

## Folder Map
See `lib/` directory for layers (domain/data/application/presentation).

## Extending to Online Mode (later)
- Add `SyncService` with background queue for upload/download.
- Add user identity & remote IDs; keep Hive as local cache.
