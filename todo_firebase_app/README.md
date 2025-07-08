# To-Do List App with Firebase

Aplikasi daftar tugas (to-do list) berbasis Flutter dengan backend Firebase.

## Fitur
- Login & Register (Email/Password)
- Tambah, edit, hapus, centang tugas
- Data realtime dengan Firestore
- Logout

## Cara Menjalankan
1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Aktifkan Authentication (Email/Password) dan Firestore
3. Download file konfigurasi `google-services.json` (Android) dan/atau `GoogleService-Info.plist` (iOS) lalu letakkan di folder yang sesuai
4. Jalankan perintah berikut:
   ```
   flutter pub get
   flutter run
   ```

## Dependency Utama
- firebase_core
- firebase_auth
- cloud_firestore

## Catatan
- Pastikan sudah setup Firebase sesuai petunjuk di atas.
