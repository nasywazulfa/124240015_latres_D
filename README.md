# latres
# Elora Mart - Aplikasi Toko Online Flutter
**Latihan Responsi Praktikum Mobile SI-D**

Aplikasi ini adalah aplikasi toko online sederhana yang menjual berbagai macam produk. Data produk diambil secara *real-time* dari API Eksternal (`https://dummyjson.com/products`). Aplikasi ini dibuat untuk memenuhi kriteria Latihan Responsi Praktikum Mobile.

## Fitur Utama
1. **Autentikasi (Login):** User wajib login dengan username bebas dan password berupa NIM mahasiswa.
2. **Session Management:** Menggunakan `SharedPreferences` untuk menyimpan sesi login. User tidak perlu login ulang saat aplikasi ditutup dan dibuka kembali (selama belum logout).
3. **Bottom Navigation:** Terdapat 2 tab utama yaitu **Home** dan **Profile**.
4. **Home:** Menampilkan daftar produk dari API, sapaan user, dan tombol menuju halaman Cart.
5. **Detail Produk:** Menampilkan informasi lengkap produk. Terdapat fitur tambah/kurang *quantity* (0 < qty <= stok) dan tombol *Add to Cart*.
6. **Keranjang (Cart):** Menggunakan database lokal `Hive`. Keranjang bersifat *private* (hanya menampilkan produk yang ditambahkan oleh user yang sedang login). Terdapat fitur hapus item.
7. **Profile:** Menampilkan informasi user, foto profil, deskripsi, dan tombol Logout.

## Library yang Digunakan
*   `http` : Untuk melakukan HTTP Request ke API DummyJSON.
*   `hive` & `hive_flutter` : Sebagai database lokal (NoSQL) untuk menyimpan data keranjang belanja.
*   `shared_preferences` : Untuk menyimpan data session (login).
*   `get` (GetX) : Untuk state management ringan, navigasi halaman, dan notifikasi (Snackbar).

## Struktur Folder Project
Berikut adalah penjelasan struktur folder di dalam direktori `lib/`:

```text
lib/
│
├── main.dart                  # Entry point aplikasi, inisialisasi Hive, Session, dan Tema (Pink Soft)
│
├── models/                    # Berisi definisi model data
│   ├── product_model.dart     # Model untuk menampung data produk dari API
│   ├── cart_model.dart        # Model Hive untuk menyimpan data keranjang
│   └── cart_model.g.dart      # File generator Hive (otomatis dari build_runner)
│
├── services/                  # Berisi logika bisnis dan koneksi ke pihak ketiga
│   ├── api_service.dart       # Layanan untuk mengambil data dari API DummyJSON
│   ├── hive_service.dart      # Layanan untuk CRUD (Create, Read, Update, Delete) keranjang di Hive
│   └── session_service.dart   # Layanan untuk mengelola session login (SharedPreferences)
│
└── views/                     # Berisi semua halaman UI (User Interface)
    ├── login_page.dart        # Halaman Login
    ├── main_page.dart         # Halaman kerangka utama (berisi Bottom Navigation Bar)
    ├── home_page.dart         # Halaman utama (menampilkan list produk)
    ├── detail_page.dart       # Halaman detail produk & pemilihan qty
    ├── cart_page.dart         # Halaman keranjang belanja
    └── profile_page.dart      # Halaman profil user & tombol logout

