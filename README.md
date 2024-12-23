Nama : Dwi Ayu Setiawati
NIM : 362358302073
Kelas : 2A TRPL

![Screenshot (42)](https://github.com/user-attachments/assets/caef9c3d-3933-41ef-a123-9d9846c8ff6c)

1. Model Weather
   Tujuan: Membuat model data cuaca untuk merepresentasikan data cuaca yang diambil dari API.
   Properti:
  cityName: Nama kota.
  temperature: Suhu dalam derajat Celsius.
  description: Deskripsi cuaca (contoh: "clear sky").
  humidity: Kelembapan dalam persentase.
  Metode Factory fromJson: Mengonversi data JSON dari API menjadi objek Weather.

2. Service untuk Fetch Data Cuaca
   Tujuan: Mengambil data cuaca dari API OpenWeatherMap menggunakan HTTP.
    API Key: Kunci otentikasi untuk mengakses layanan API.
    Metode fetchWeather:
    Menerima nama kota (city) sebagai parameter.
    Mengambil data dari URL API dengan parameter nama kota dan kunci API.
    Mengembalikan hasil sebagai data JSON jika status respons 200.
    Melempar exception jika ada masalah (misalnya status kode tidak 200).

3. Widget untuk Menampilkan Data Cuaca
   Tujuan: Menampilkan data cuaca dalam bentuk kartu (card) dengan ikon, nama kota, suhu, deskripsi, dan kelembapan.
   Properti weather: Objek cuaca yang diterima sebagai input untuk ditampilkan.

4. Halaman Utama (HomeScreen)
   WeatherService: Objek untuk memanggil layanan API.
  cities: Daftar kota default.
  selectedCity: Kota yang dipilih pengguna (default: Jakarta).
  weather: Menyimpan data cuaca dari API.
  cityController: Kontrol untuk menangani input teks dari pengguna.

5. Widget Halaman Utama
   Input Pencarian Kota: Menggunakan TextField untuk memasukkan nama kota.
  Ikon Refresh: Memanggil ulang fetchWeather untuk memperbarui data cuaca.
  Menampilkan Data: Jika weather null, spinner akan ditampilkan. Jika data tersedia, widget WeatherList akan ditampilkan.

6. Fungsi Utama
   Fungsi main: Menjalankan aplikasi Flutter.
  MyApp: Mengatur tema aplikasi dan mengarahkan ke HomeScreen.

1. Default Kota: Aplikasi menampilkan data cuaca untuk kota default (Jakarta).
2. Input Kota Baru: Pengguna memasukkan nama kota di TextField, lalu menekan tombol pencarian.
3. Panggilan API: Aplikasi memanggil data cuaca untuk kota tersebut menggunakan API OpenWeatherMap.
4. Tampilan Cuaca: Data cuaca ditampilkan dalam bentuk kartu di layar utama.





