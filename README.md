# UAS Basis Data Lanjutan
## Membuat Database BookStore

Project ini menjelaskan tentang pembuatan database pada sebuat toko buku dengan nama database "bookstore". Serta penggunaan fungsi agregat pada potongan querynya, membuat trigger, tabel virtual (view), menerapkan query innerjoin, leftjoin, subquery, having, wildcards, serta melakukan backup database dengan *mysqldump*. 

Pada database ini dibuat 8 tabel yaitu:
- Tabel Authors untuk menyimpan data Penulis
- Tabel Categories untuk menyimpan data Kategori
- Tabel Publishers untuk menyimpan data Penerbit
- Tabel Books untuk menyimpan data buku, dan memiliki foreign key yang merujuk ke tabel Authors, Publishers, Categories, dan Stock
- Tabel Customers untuk menyimpan data pelanggan
- Tabel Orders untuk menyimpan data pesanan yang dilakukan oleh pelanggan, dengan foreign key ke tabel Customers.
- Tabel OrderDetails untuk menyimpan rincian tiap pesanan, menghubungkan pesanan dengan buku yang dipesan.
- Tabel Stock untuk menyimpan data stok buku, dengan foreign key ke tabel Books.

## Membuat tabel pada database BookStore
Query untuk membuat tabel pada database bookstore

```sh
-- Membuat tabel Authors
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE
);
-- Membuat tabel Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT
);
-- Membuat tabel Publishers
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    contact VARCHAR(255)
);
-- Membuat tabel Books
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    publisher_id INT,
    category_id INT,
    isbn VARCHAR(13) UNIQUE,
    price DECIMAL(10, 2) NOT NULL,
    publication_date DATE,
    stock_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
-- Membuat tabel Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    address TEXT
);
-- Membuat tabel Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Membuat tabel OrderDetails
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
-- Membuat tabel Stock
CREATE TABLE Stock (
    stock_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    quantity_available INT NOT NULL,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
```

## Relasi Antar Tabel

Berikut adalah ER Diagram dari database BookStore dengan relasi tabel seperti berikut:

![Alt text](ERDBookstore.png)

Berikut adalah penjelasan mengenai relasi antar tabel dalam skema database Bookstore:

- Authors dan Books:
Tabel Books memiliki kolom `author_id` yang merupakan *forein key* yang merujuk ke `author_id` di tabel Authors. Ini menunjukkan bahwa satu buku ditulis oleh satu penulis (relasi satu ke satu atau satu penulis bisa memiliki banyak buku).

- Categories dan Books:
Tabel Books memiliki kolom `category_id` yang merupakan *forein key* yang merujuk ke `category_id` di tabel Categories. Ini menunjukkan bahwa satu buku hanya dapat terhubung dengan satu kategori (relasi satu ke satu).

- Publishers dan Books:
Tabel Books memiliki kolom `publisher_id` yang merupakan *forein key* yang merujuk ke `publisher_id` di tabel Publishers. Ini menunjukkan bahwa satu buku diterbitkan oleh satu penerbit (relasi satu ke satu atau satu penerbit bisa memiliki banyak buku).

- Customers dan Orders:
Tabel Orders memiliki kolom `customer_id` yang merupakan *forein key* yang merujuk ke `customer_id` di tabel Customers. Ini menunjukkan bahwa satu pesanan dibuat oleh satu pelanggan (relasi satu ke satu atau satu pelanggan bisa memiliki banyak pesanan).

- Orders dan OrderDetails:
Tabel OrderDetails memiliki kolom `order_id` yang merupakan *forein key* yang merujuk ke `order_id` di tabel Orders. Ini menunjukkan bahwa satu detail pesanan terhubung dengan satu pesanan tertentu (relasi satu ke banyak).

- Books dan OrderDetails:
Tabel OrderDetails memiliki kolom `book_id` yang merupakan *forein key* yang merujuk ke `book_id` di tabel Books. Ini menunjukkan bahwa satu detail pesanan berhubungan dengan satu buku tertentu yang dipesan (relasi satu ke banyak).

- Books dan Stock:
Tabel Stock memiliki kolom `book_id` yang merupakan *forein key* yang merujuk ke `book_id` di tabel Books. Ini menunjukkan bahwa satu entri stok (jumlah buku yang tersedia) terhubung dengan satu buku tertentu (relasi satu ke satu atau satu buku dapat memiliki satu entri stok).

## Fungsi Agregat (`SUM`)
Query fungsi agregat
```sh
UPDATE Orders AS o
SET total_amount = (
    SELECT SUM(od.quantity * od.price)
    FROM OrderDetails AS od
    WHERE od.order_id = o.order_id
)
WHERE EXISTS (
    SELECT 1
    FROM OrderDetails AS od
    WHERE od.order_id = o.order_id
);
```
Query di atas adalah sebuah perintah SQL yang digunakan untuk memperbarui kolom `total_amount` di tabel `Orders`. Query ini menggunakan subquery dan fungsi agregat SUM untuk menghitung total jumlah dari setiap order berdasarkan detail order di tabel `OrderDetails`.

Fungsi Query:
Menghitung Total Amount: Query ini menghitung total jumlah (`total_amount`) untuk setiap order berdasarkan detail order di tabel `OrderDetails`.
Mengupdate Total Amount: Query ini mengupdate kolom `total_amount` di tabel `Orders` dengan hasil perhitungan dari subquery.

Query ini berguna untuk memastikan bahwa kolom `total_amount` di tabel `Orders` selalu diperbarui dengan benar berdasarkan detail order di tabel `OrderDetails`. Dengan menggunakan subquery dan fungsi agregat, query ini menghitung total jumlah secara dinamis dan memperbarui kolom `total_amount` hanya jika ada entri yang sesuai di tabel `OrderDetails`.

## Trigger

Trigger ini dibuat untuk menanggapi perubahan data di dalam tabel. Misalnya, ketika sebuah baris data dimasukkan ke dalam tabel, trigger dapat dipicu untuk melakukan tugas tambahan seperti memperbarui tabel lain, mengirim notifikasi, atau melakukan validasi data.

### Trigger 1
Query Trigger yang dibuat untuk membuat total_amount pada tabel orders menjadi otomatis berubah saat ada pelanggan yang membeli lebih dari satu buku 

```sh
DELIMITER //

CREATE TRIGGER calculate_order_total
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    

    SET total = NEW.quantity * NEW.price;
    
  
    UPDATE Orders
    SET total_amount = total_amount + total
    WHERE order_id = NEW.order_id;
END;
//

DELIMITER ;
```

Penjelasan Query:
1. DELIMITER //: Mengubah delimiter sementara dari ; ke //. Ini diperlukan karena perintah CREATE TRIGGER melibatkan beberapa pernyataan SQL dan kita perlu menggunakan delimiter berbeda untuk menyelesaikan definisi trigger.
2. CREATE TRIGGER calculate_order_total: Membuat trigger dengan nama calculate_order_total.
3. AFTER INSERT ON OrderDetails: Menentukan bahwa trigger ini akan dijalankan setelah (AFTER) setiap operasi INSERT pada tabel OrderDetails.
4. FOR EACH ROW: Menunjukkan bahwa trigger ini akan dijalankan untuk setiap baris yang dimasukkan ke tabel OrderDetails.
5. BEGIN ... END: Blok perintah yang akan dieksekusi oleh trigger.
6. DECLARE total DECIMAL(10, 2): Mendeklarasikan variabel lokal total dengan tipe data DECIMAL(10, 2) untuk menyimpan hasil perhitungan subtotal.
7. SET total = NEW.quantity * NEW.price: Menghitung subtotal dengan mengalikan quantity dan price dari baris baru (NEW) yang dimasukkan ke OrderDetails dan menyimpan hasilnya dalam variabel total.
8. UPDATE Orders ...: Mengupdate kolom total_amount pada tabel Orders.
   - SET total_amount = total_amount + total: Menambahkan nilai total yang baru dihitung ke total_amount yang ada.
   - WHERE order_id = NEW.order_id: Menentukan baris di tabel Orders yang akan diupdate, yaitu baris dengan order_id yang sama dengan order_id dari baris baru yang dimasukkan ke OrderDetails.
9. END;: Menandakan akhir dari blok perintah trigger.
10.//: Mengakhiri definisi trigger dengan delimiter yang ditentukan (//).
11.DELIMITER ;: Mengembalikan delimiter ke nilai default (;).

### Trigger 2
Query trigger Untuk mengubah quantity stok saat pada tabel orderdetails terjadi penambahan data pembelian, sehingga field quantity_available pada tabel stock akan berkurang otimatis

```sh
DELIMITER //

CREATE TRIGGER update_stock_after_order_detail
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    DECLARE change_amount INT;
    DECLARE book_id_temp INT;
    

    SELECT NEW.book_id, NEW.quantity INTO book_id_temp, change_amount;
    

    IF (SELECT COUNT(*) FROM Stock WHERE book_id = book_id_temp) > 0 THEN
        UPDATE Stock
        SET quantity_available = quantity_available - change_amount
        WHERE book_id = book_id_temp;
    ELSE
        INSERT INTO Stock (book_id, quantity_available)
        VALUES (book_id_temp, -change_amount); 
    END IF;
END //

DELIMITER ;
```
Penjelasan Query:

1. DELIMITER //: Mengubah delimiter sementara dari ; ke //. Ini diperlukan karena perintah CREATE TRIGGER melibatkan beberapa pernyataan SQL dan kita perlu menggunakan delimiter berbeda untuk menyelesaikan definisi trigger.
2. CREATE TRIGGER update_stock_after_order_detail: Membuat trigger dengan nama update_stock_after_order_detail.
3. AFTER INSERT ON OrderDetails: Menentukan bahwa trigger ini akan dijalankan setelah (AFTER) setiap operasi INSERT pada tabel OrderDetails.
4. FOR EACH ROW: Menunjukkan bahwa trigger ini akan dijalankan untuk setiap baris yang dimasukkan ke tabel OrderDetails.
5. BEGIN ... END: Blok perintah yang akan dieksekusi oleh trigger.
6. DECLARE change_amount INT: Mendeklarasikan variabel lokal change_amount dengan tipe data INT untuk menyimpan jumlah perubahan stok.
7. DECLARE book_id_temp INT: Mendeklarasikan variabel lokal book_id_temp dengan tipe data INT untuk menyimpan book_id dari baris baru yang dimasukkan ke OrderDetails.
8. SELECT NEW.book_id, NEW.quantity INTO book_id_temp, change_amount: Mengambil book_id dan quantity dari baris baru (NEW) yang dimasukkan ke OrderDetails dan menyimpannya ke dalam variabel book_id_temp dan change_amount.
9. IF (SELECT COUNT(*) FROM Stock WHERE book_id = book_id_temp) > 0 THEN: Mengecek apakah ada baris di tabel Stock dengan book_id yang sama dengan book_id_temp.
- Jika ada (COUNT(*) > 0), maka:
-- UPDATE Stock SET quantity_available = quantity_available - change_amount WHERE book_id = book_id_temp: Mengupdate kolom quantity_available pada tabel Stock dengan mengurangkan change_amount dari stok yang tersedia untuk book_id yang sesuai.
- Jika tidak ada (COUNT(*) = 0), maka:
-- INSERT INTO Stock (book_id, quantity_available) VALUES (book_id_temp, -change_amount): Menyisipkan baris baru ke tabel Stock dengan book_id yang sesuai dan quantity_available yang negatif (menandakan pengurangan stok).
10. END IF: Menandakan akhir dari blok IF.
11. END //: Menandakan akhir dari blok perintah trigger.
12. DELIMITER ;: Mengembalikan delimiter ke nilai default (;).
(optional) Third:

### View
View dalam konteks basis data adalah objek virtual yang menyajikan data yang diambil dari satu atau lebih tabel. View berfungsi seperti tabel, namun tidak menyimpan data secara fisik. Sebaliknya, view menyimpan definisi query yang akan dijalankan setiap kali view diakses.

Query untuk membuat sebuah view bernama OrderDetailsView yang menyajikan informasi lengkap tentang setiap order di toko buku, termasuk detail customer, buku yang dibeli, dan harga. 

```sh
CREATE VIEW OrderDetailsView AS
SELECT
    o.order_id,
    c.name AS customer_name,
    b.title AS book_title,
    od.quantity,
    b.price,
    od.quantity * b.price AS subtotal,
    o.total_amount
FROM
    Orders o
    JOIN Customers c ON o.customer_id = c.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
    JOIN Books b ON od.book_id = b.book_id;
```
1. CREATE VIEW OrderDetailsView AS:
   - Membuat sebuah view dengan nama OrderDetailsView. View adalah hasil dari sebuah query yang disimpan sebagai objek virtual di dalam database. View dapat digunakan seperti tabel biasa dalam operasi SELECT.
2. SELECT ...: Mendefinisikan kolom-kolom yang akan dimasukkan ke dalam view.
   - `o.order_id`: ID order dari tabel Orders.
   - `c.name AS customer_name`: Nama customer dari tabel Customers, dengan alias `customer_name`.
   - `b.title AS book_title`: Judul buku dari tabel Books, dengan alias `book_title`.
   - `od.quantity`: Jumlah buku yang dipesan dari tabel OrderDetails.
   - `b.price`: Harga per buku dari tabel Books.
   - `od.quantity * b.price AS subtotal`: Menghitung subtotal untuk setiap baris order dengan mengalikan jumlah buku (quantity) dengan harga buku (price), dengan alias subtotal.
   - `o.total_amount`: Total jumlah seluruh order dari tabel Orders.
3. FROM ...: Menentukan tabel-tabel yang digunakan dalam query.
   - `Orders o`: Tabel yang berisi informasi order, diberi alias o.
   - `Customers c`: Tabel yang berisi informasi customer, diberi alias c.
   - `OrderDetails od`: Tabel yang berisi detail dari setiap order, diberi alias od.
   - `Books b`: Tabel yang berisi informasi tentang buku-buku yang dibeli, diberi alias b.
4. JOIN ...: Menghubungkan tabel-tabel tersebut menggunakan kondisi join.
   - `JOIN Customers c ON o.customer_id = c.customer_id`: Menghubungkan tabel Orders dengan tabel Customers berdasarkan customer_id.
   - `JOIN OrderDetails od ON o.order_id = od.order_id`: Menghubungkan tabel Orders dengan tabel OrderDetails berdasarkan order_id.
   - `JOIN Books b ON od.book_id = b.book_id`: Menghubungkan tabel OrderDetails dengan tabel Books berdasarkan book_id.

#### Tampilan View 

![Alt text](tampilanview.jpeg)

### INNER JOIN
Operasi INNER JOIN dalam SQL digunakan untuk menggabungkan data dari dua tabel berdasarkan kondisi tertentu.

Query INNER JOIN
```sh
SELECT book_id, title, name, description
FROM Books
INNER JOIN Categories ON Books.category_id = Categories.category_id;
```
Fungsi Query:
- Menggabungkan Data: Query ini menggabungkan data dari tabel `Books` dan tabel `Categories` berdasarkan kolom `category_id`. Hanya baris yang memiliki kecocokan di kedua tabel yang akan ditampilkan dalam hasil.
- Mengambil Informasi Lengkap: Query ini mengumpulkan informasi lengkap tentang buku, termasuk `book_id`, `title` dari tabel `Books`, serta `name` dan `description` dari tabel `Categories`.

#### Tampilan INNER JOIN

![Alt text](innerjoin.jpeg)

### LEFT JOIN
Operasi LEFT JOIN dalam SQL digunakan untuk menggabungkan data dari dua tabel dan menyertakan semua baris dari tabel kiri (`Customers`), serta baris yang cocok dari tabel kanan (`Orders`). Jika tidak ada kecocokan, hasil dari tabel kanan akan berisi nilai NULL.

Query LEFT JOIN
```sh
SELECT Customers.name, Orders.order_id
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id
ORDER BY Customers.name;
```
Fungsi Query:
- Menggabungkan Data dengan Left Join: Query ini menggabungkan data dari tabel `Customers` dan tabel `Orders` berdasarkan kolom `customer_id`. Semua baris dari tabel `Customers` akan ditampilkan, dan jika tidak ada kecocokan di tabel `Orders`, kolom order_id akan berisi nilai NULL.
- Mengambil Informasi Pelanggan dan Order: Query ini menampilkan nama pelanggan dari tabel `Customers` dan ID order dari tabel `Orders`.
- Mengurutkan Data: Hasil query diurutkan berdasarkan nama pelanggan (`Customers.name`).
- 
#### Tampilan LEFT JOIN

![Alt text](leftjoin.jpeg)

### SUBQUERY
Subquery, atau sub-query, adalah sebuah query di dalam query lainnya. Subquery sering digunakan untuk melakukan operasi yang memerlukan data dari query lain sebagai bagian dari proses pengambilan datanya. Subquery dapat ditempatkan di dalam klausa SELECT, FROM, WHERE, atau HAVING dari query SQL utama.

Contoh Subquery
```sh
SELECT title, price
FROM Books
WHERE author_id IN (SELECT distinct author_id FROM Authors)
```

Fungsi Query:
- Memfilter Data: Query ini memfilter buku di tabel Books yang memiliki author_id yang ada di tabel Authors. Hanya buku-buku yang ditulis oleh penulis yang tercantum di tabel Authors yang akan ditampilkan dalam hasil.

#### Tampilan SUBQUERY

![Alt text](subquery.jpeg)

### HAVING
Klausa HAVING digunakan dalam SQL untuk memfilter hasil grup yang dihasilkan oleh klausa GROUP BY. Perbedaannya dengan klausa WHERE adalah sebagai berikut:
WHERE: Digunakan untuk memfilter baris sebelum pengelompokan dilakukan (sebelum GROUP BY).
HAVING: Digunakan untuk memfilter hasil grup setelah pengelompokan dilakukan (setelah GROUP BY).
Klausa HAVING memungkinkan untuk melakukan filter terhadap hasil grup berdasarkan nilai-nilai hasil agregat seperti SUM, COUNT, AVG, dll.

Contoh Query Having
```sh
SELECT 
    book_id,
    SUM(quantity) AS total_quantity
FROM 
    OrderDetails
GROUP BY 
    book_id
HAVING 
    SUM(quantity) > 3;
```
Fungsi Query:
- Mengelompokkan Data: Query ini mengelompokkan baris dalam tabel `OrderDetails` berdasarkan `book_id`.
- Menghitung Total Quantity: Menggunakan fungsi agregat `SUM` untuk menghitung jumlah total quantity untuk setiap `book_id`.
- Memfilter Hasil dengan `HAVING`: Menggunakan klausa `HAVING` untuk memfilter hanya grup-grup yang jumlah total quantity-nya lebih dari 3.

#### Tampilan HAVING

![Alt text](having.jpeg)

### WILDCARDS
Wildcard dalam konteks basis data, khususnya dalam SQL, merujuk pada karakter khusus yang digunakan untuk mencocokkan pola string. Wildcard memungkinkan untuk melakukan pencarian atau filter data yang tidak tepat atau tidak lengkap berdasarkan pola tertentu. Dua wildcard yang umum digunakan dalam SQL adalah `LIKE` dan `IN`.

Contoh Query Wildcards
```sh
SELECT * FROM Customers
WHERE name LIKE 'j%';
```
Untuk mencari dan mengembalikan semua data dari tabel Customers di mana nilai kolom name dimulai dengan huruf 'j'. Ini menggunakan wildcard % dalam klausa LIKE, yang mencocokkan nol atau lebih karakter apa pun setelah huruf 'j'.

#### Hasil

![Alt text](wildcardsj.jpeg)


```sh
SELECT * FROM Customers
WHERE name LIKE '%s';
```
Untuk mencari dan mengembalikan semua data dari tabel Customers di mana nilai kolom name diakhiri dengan huruf 's'. Ini menggunakan wildcard % dalam klausa LIKE, yang mencocokkan nol atau lebih karakter apa pun sebelum huruf 's'.

#### Hasil

![Alt text](wildcardss.jpeg)

## Backup MYSQLDUMP

Backup MySQL menggunakan mysqldump adalah proses untuk membuat salinan cadangan dari database MySQL secara keseluruhan atau sebagian

Query backup dengan mysqldump
```sh
mysqldump -u root -p bookstore > backup_bookstore.sql
```
Setelah menjalankan perintah tersebut, MySQL akan meminta untuk memasukkan kata sandi pengguna root. Setelah kata sandi dikonfirmasi, mysqldump akan membuat salinan struktur database bookstore beserta semua datanya dan menyimpannya dalam file `backup_bookstore.sql`.

