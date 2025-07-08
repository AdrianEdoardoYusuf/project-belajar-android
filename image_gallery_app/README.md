# Image Gallery App

Aplikasi galeri gambar sederhana berbasis Flutter.

## Fitur
- Mengambil banyak gambar dari galeri perangkat
- Menampilkan gambar dalam grid
- Permission handler untuk akses galeri

## Cara Menjalankan
1. Jalankan perintah berikut di terminal:
   ```
   flutter pub get
   flutter run
   ```
2. Untuk Android/iOS, tambahkan permission berikut:
   - **Android:**
     Tambahkan di `android/app/src/main/AndroidManifest.xml`:
     ```xml
     <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
     <uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
     ```
   - **iOS:**
     Tambahkan di `ios/Runner/Info.plist`:
     ```xml
     <key>NSPhotoLibraryUsageDescription</key>
     <string>App membutuhkan akses ke galeri foto Anda.</string>
     ```

## Dependency Utama
- image_picker
- permission_handler
