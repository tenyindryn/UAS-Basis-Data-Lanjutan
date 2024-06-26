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

## Trigger

Trigger ini dibuat untuk menanggapi perubahan data di dalam tabel. Misalnya, ketika sebuah baris data dimasukkan ke dalam tabel, trigger dapat dipicu untuk melakukan tugas tambahan seperti memperbarui tabel lain, mengirim notifikasi, atau melakukan validasi data.

Query Trigger yang dibuat untuk melakukan update pada field .....

```sh
node app
```

Second Tab:

```sh
gulp watch
```

(optional) Third:

```sh
karma test
```

#### Building for source

For production release:

```sh
gulp build --prod
```

Generating pre-built zip archives for distribution:

```sh
gulp build dist --prod
```

## Docker

Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 8080, so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:${package.json.version} .
```

This will create the dillinger image and pull in the necessary dependencies.
Be sure to swap out `${package.json.version}` with the actual
version of Dillinger.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply map port 8000 of the host to
port 8080 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 8000:8080 --restart=always --cap-add=SYS_ADMIN --name=dillinger <youruser>/dillinger:${package.json.version}
```

> Note: `--capt-add=SYS-ADMIN` is required for PDF rendering.

Verify the deployment by navigating to your server address in
your preferred browser.

```sh
127.0.0.1:8000
```

## License

MIT

**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)

   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]: <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>
   [PlMe]: <https://github.com/joemccann/dillinger/tree/master/plugins/medium/README.md>
   [PlGa]: <https://github.com/RahulHP/dillinger/blob/master/plugins/googleanalytics/README.md>
