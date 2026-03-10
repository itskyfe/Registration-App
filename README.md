# 📱 Flutter Event Registration App

Aplikasi **Event Registration** adalah aplikasi Flutter sederhana yang digunakan untuk melakukan pendaftaran peserta event.
Aplikasi ini dibuat menggunakan **Flutter + Provider State Management** untuk mengelola data peserta secara dinamis.

Aplikasi memiliki fitur utama seperti:

* Form registrasi peserta
* Menampilkan daftar peserta
* Melihat detail peserta
* Menghapus peserta
* Dark mode
* Validasi form

---

# 🧩 Fitur Aplikasi

## 1. Form Registrasi Peserta

Halaman utama aplikasi berisi form untuk mendaftarkan peserta event.

Field yang tersedia:

* Nama lengkap
* Email
* Jenis kelamin
* Program studi

Form memiliki **validasi input**, misalnya:

* Nama minimal 3 karakter
* Email harus memiliki format valid
* Program studi harus dipilih

Setelah data valid, pengguna dapat menekan tombol **Daftar Sekarang** untuk menyimpan data peserta.

---

## 2. Daftar Peserta

Setelah registrasi berhasil, pengguna dapat membuka halaman **Daftar Peserta**.

Halaman ini menampilkan:

* Nama peserta
* Email peserta
* Avatar otomatis dari huruf pertama nama

Pengguna dapat:

* Melihat detail peserta
* Menghapus peserta dari daftar

---

## 3. Detail Peserta

Halaman detail menampilkan informasi lengkap peserta seperti:

* Nama
* Email
* Jenis kelamin
* Program studi
* Tanggal lahir
* Umur peserta

Informasi ditampilkan menggunakan **ListTile dan Card UI** agar lebih rapi dan mudah dibaca.

---

## 4. Hapus Peserta

Pada halaman daftar peserta terdapat **ikon delete**.

Jika ditekan:

* Data peserta akan dihapus dari list
* State aplikasi diperbarui menggunakan Provider
* Snackbar muncul sebagai notifikasi

---

## 5. Dark Mode

Aplikasi menyediakan fitur **Dark Mode Toggle** pada AppBar.

Ketika tombol ditekan:

* Tema aplikasi berubah dari **Light Mode ke Dark Mode**
* State tema dikelola oleh `RegistrationProvider`.

---

Berikut **penjelasan kode dari project Flutter yang kamu kirim**. Penjelasan ini bisa langsung kamu gunakan untuk **laporan atau dokumentasi README** karena dijelaskan berdasarkan **file dan fungsi utama**.

---

# :gear: Penjelasan Kode

## 1️⃣ main.dart

File `main.dart` merupakan **entry point** dari aplikasi Flutter.

### Fungsi utama

* Menginisialisasi Provider
* Menjalankan aplikasi
* Mengatur theme
* Mengatur navigasi antar halaman

### Inisialisasi Provider

```dart
runApp(
  ChangeNotifierProvider(
    create: (_) => RegistrationProvider(),
    child: const MyApp(),
  ),
);
```

Penjelasan:

* `ChangeNotifierProvider` digunakan untuk menyediakan **state global aplikasi**
* `RegistrationProvider` akan digunakan untuk mengelola data peserta

---

### Widget MyApp

```dart
class MyApp extends StatelessWidget
```

Widget ini merupakan **root widget aplikasi**.

---

### Consumer Provider

```dart
Consumer<RegistrationProvider>
```

Digunakan untuk **mendengarkan perubahan state** dari provider.

Jika state berubah (misalnya dark mode), maka UI akan **update otomatis**.

---

### Pengaturan Theme

```dart
theme: ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: provider.themeColor),
),
```

Theme menggunakan **Material Design 3**.

Warna utama aplikasi berasal dari:

```
provider.themeColor
```

---

### Dark Mode

```dart
themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light
```

Jika `isDarkMode = true` maka aplikasi menggunakan **dark theme**.

---

### Routing Halaman

```dart
routes: {
  '/': (context) => const RegistrationPage(),
  '/list': (context) => const RegistrantListPage(),
  '/detail': (context) => const RegistrantDetailPage(),
}
```

Navigasi halaman menggunakan **Named Routes**:

| Route     | Halaman         |
| --------- | --------------- |
| `/`       | Form Registrasi |
| `/list`   | Daftar Peserta  |
| `/detail` | Detail Peserta  |

---

## 2️⃣ registration_page.dart (Halaman Registrasi)

Halaman ini digunakan untuk **mendaftarkan peserta baru**.

Widget menggunakan:

```
StatefulWidget
```

karena form memiliki **state yang berubah**.

---

### Form Controller

```dart
final TextEditingController _name = TextEditingController();
final TextEditingController _email = TextEditingController();
```

Digunakan untuk **mengambil input dari TextFormField**.

---

### GlobalKey Form

```dart
final _formKey = GlobalKey<FormState>();
```

Digunakan untuk melakukan **validasi form**.

---

## Field Input

Form memiliki beberapa input:

#### Nama

```dart
TextFormField
```

Validasi:

```
- Tidak boleh kosong
- Minimal 3 karakter
```

---

#### Email

Validasi:

```
- Tidak boleh kosong
- Harus mengandung "@"
```

---

#### Gender

Menggunakan:

```dart
RadioListTile
```

Pilihan:

```
Laki-laki
Perempuan
```

---

#### Program Studi

Menggunakan:

```
DropdownButtonFormField
```

Pilihan program studi:

* Teknik Informatika
* Sistem Informasi
* Teknik Komputer
* Data Science
* Desain Komunikasi Visual

---

### Tombol Daftar

```dart
ElevatedButton.icon
```

Ketika ditekan:

1️⃣ Validasi form
2️⃣ Membuat objek `Registrant`

```dart
final registrant = Registrant(...)
```

3️⃣ Menambahkan data ke provider

```dart
provider.addRegistrant(registrant);
```

4️⃣ Menampilkan Snackbar

```dart
SnackBar(
  content: Text("${registrant.name} berhasil didaftarkan"),
)
```

---

### Reset Form

```dart
OutlinedButton
```

Fungsi reset:

* menghapus isi text field
* mengembalikan gender ke default
* menghapus pilihan prodi

---

## 3️⃣ registrant_list_page.dart (Daftar Peserta)

Halaman ini menampilkan **seluruh peserta yang sudah terdaftar**.

---

### State Search

```dart
String search = "";
```

Digunakan untuk **fitur pencarian peserta**.

---

### Filter Data

```dart
final data = provider.registrants.where((r) {
  return r.name.toLowerCase().contains(search.toLowerCase());
}).toList();
```

Fungsi ini melakukan:

```
filter peserta berdasarkan nama
```

---

### Search Field

```dart
TextField
```

Ketika user mengetik:

```dart
setState(() {
  search = v;
});
```

Daftar peserta akan **terfilter secara realtime**.

---

### ListView.builder

Digunakan untuk menampilkan daftar peserta.

```dart
ListView.builder
```

Setiap item menampilkan:

* Avatar
* Nama
* Email

---

### Avatar

```dart
CircleAvatar(
  child: Text(registrant.name[0]),
)
```

Avatar otomatis menggunakan **huruf pertama nama peserta**.

---

### Delete Peserta

```dart
provider.removeRegistrant(registrant.id);
```

Data akan dihapus dari provider.

Setelah itu muncul notifikasi:

```
Snackbar: "Nama peserta dihapus"
```

---

### Navigasi ke Detail

```dart
Navigator.pushNamed(
  context,
  "/detail",
  arguments: registrant.id,
);
```

Mengirim **ID peserta** ke halaman detail.

---

## 4️⃣ registrant_detail_page.dart (Detail Peserta)

Halaman ini menampilkan **informasi lengkap peserta**.

---

### Mengambil Argument Route

```dart
final id = ModalRoute.of(context)!.settings.arguments as String;
```

Mengambil **ID peserta dari halaman sebelumnya**.

---

### Mengambil Data dari Provider

```dart
context.read<RegistrationProvider>().getById(id);
```

Mengambil data peserta berdasarkan ID.

---

### Tampilan UI

Data ditampilkan menggunakan:

```
CircleAvatar
ListTile
```

Informasi yang ditampilkan:

* Email
* Gender
* Program Studi
* Tanggal lahir
* Umur peserta

---

## 5️⃣ registrant_model.dart (Model Data)

File ini mendefinisikan **struktur data peserta**.

Properti model:

```dart
id
name
email
gender
programStudi
dateOfBirth
registeredAt
```

---

### Getter Age

```dart
int get age
```

Digunakan untuk menghitung umur berdasarkan tanggal lahir.

---

### Format Tanggal

```dart
formattedDateOfBirth
formattedRegisteredAt
```

Digunakan untuk **mengubah format tanggal menjadi string**.

---

## 6️⃣ registration_provider.dart (State Management)

Provider ini bertugas **mengelola data peserta**.

Class:

```
RegistrationProvider extends ChangeNotifier
```

---

### List Penyimpanan Peserta

```dart
final List<Registrant> _registrants = [];
```

Data peserta disimpan dalam list.

---

### Getter Data

```dart
List<Registrant> get registrants
```

Digunakan untuk mengambil semua peserta.

---

### Jumlah Peserta

```dart
int get count => _registrants.length;
```

Digunakan untuk menampilkan jumlah peserta di AppBar.

---

### Tambah Peserta

```dart
void addRegistrant(Registrant registrant)
```

Menambahkan peserta ke dalam list.

Setelah itu:

```
notifyListeners()
```

UI akan **update otomatis**.

---

### Hapus Peserta

```dart
void removeRegistrant(String id)
```

Menghapus peserta berdasarkan ID.

---

### Ambil Peserta Berdasarkan ID

```dart
Registrant? getById(String id)
```

Digunakan untuk halaman **detail peserta**.

---

### Validasi Email

```dart
bool isEmailRegistered(String email)
```

Digunakan untuk mengecek apakah email sudah pernah terdaftar.

---

### Sort Peserta

```dart
void sortByName()
```

Mengurutkan peserta berdasarkan **nama (alphabet)**.

---

## :framed_picture:	Tampilan Aplikasi

### Light Mode
<img width="309" height="673" alt="image" src="https://github.com/user-attachments/assets/e90a08ec-023a-4b82-9590-f087dc2d8b74" />
<img width="308" height="671" alt="image" src="https://github.com/user-attachments/assets/052ecc72-4f0b-4795-aef2-eb78746a1f7b" />
<img width="308" height="670" alt="image" src="https://github.com/user-attachments/assets/4e53d5a5-fb79-49c7-ad78-3b3011ff3e53" />
<img width="310" height="673" alt="image" src="https://github.com/user-attachments/assets/a0bcfd34-dfbe-4964-9bbb-3ed0a963b15a" />
<img width="312" height="670" alt="image" src="https://github.com/user-attachments/assets/8fb59c7f-8c41-46bc-95ef-51c564aba1f7" />
<img width="313" height="671" alt="image" src="https://github.com/user-attachments/assets/8ff85d4f-d11e-4d7e-a950-1e08f7a2d909" />

### Dark Mode
<img width="311" height="665" alt="image" src="https://github.com/user-attachments/assets/28cc6c80-5431-4a39-b14d-5c409cb1bf49" />
<img width="314" height="676" alt="image" src="https://github.com/user-attachments/assets/c3c8b145-6b2b-45c7-8bc5-697b3602db92" />
<img width="312" height="669" alt="image" src="https://github.com/user-attachments/assets/79bc1481-1826-471d-936d-25c4fdf8c6ab" />
<img width="311" height="671" alt="image" src="https://github.com/user-attachments/assets/c64954fa-841a-4380-93ad-68f60636529e" />
<img width="311" height="667" alt="image" src="https://github.com/user-attachments/assets/ca5a307d-3573-42a2-bfa7-05fb90d48086" />
<img width="310" height="669" alt="image" src="https://github.com/user-attachments/assets/81cba87b-d141-4675-8ab1-4142d9f4e12b" />
