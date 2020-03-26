CREATE DATABASE tokobuku_coswick
ON
(
	NAME = tokobuku_coswick_dat,
	FILENAME = 'E:\4_PBD_HOME\tokobuku_coswick.mdf',
	SIZE = 10MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5MB
)

LOG ON
(
	NAME = 'tokobuku_coswick_log',
	FILENAME = 'E:\4_PBD_HOME\tokobuku_coswick.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB
)

USE tokobuku_coswick

CREATE TABLE penulis_coswick(
		id_penulis INTEGER PRIMARY KEY NOT NULL,
		nama_depan VARCHAR (30) NOT NULL,
		nama_belakang VARCHAR (30),
		email VARCHAR (50));

		INSERT INTO penulis_coswick(id_penulis,nama_depan,nama_belakang,email)
		VALUES (1,'Andrea','Hirata','andrea@gmail.com'),
		(2,'Tere','Liye','tereliye@gmail.com'),
		(3,'Raditya','Dika','Rdika@gmail.com');

		SELECT * FROM penulis_coswick


CREATE TABLE pemebeli_coswick(
		id_pemebeli INTEGER PRIMARY KEY NOT NULL,
		nama VARCHAR (50) NOT NULL,
		tanggal_lahir DATETIME NULL,
		no_telp VARCHAR (50) NULL);


		INSERT INTO pemebeli_coswick(id_pemebeli,nama,tanggal_lahir,no_telp)
		VALUES (11,'Rahma Maulani','2000-04-05','+6281347254054'),
		(12,'Dwi Rahmawati','2000-03-29','+6285768254054'),
		(13,'Rasyid Ridla','1998-07-15','+6281347298754');

		SELECT * FROM pemebeli_coswick

CREATE TABLE penerbit_coswick(
		id_penerbit INTEGER PRIMARY KEY NOT NULL,
		nama VARCHAR (100) NOT NULL,
		jalan VARCHAR (50),
		kelurahan VARCHAR (50),
		kecamatan VARCHAR (50),
		kabupaten VARCHAR (50),
		provinsi VARCHAR (50) NOT NULL);

		INSERT INTO penerbit_coswick(id_penerbit,nama,jalan,kelurahan,kecamatan,kabupaten,provinsi)
		VALUES (1,'Andrea Hirata','Kenanga 3','Condongcatur','Depok','Sleman','DIY'),
		(2,'Tere Liye','Teratai 7','Selomartani','Gambir','Menteng','Jakarta Selatan'),
		(3,'Andrea Hirata','Kenanga 3','Maguwoharjo','Senen','Kemayoran','Jakarta Utara');

		SELECT * FROM penerbit_coswick



CREATE TABLE buku_coswick(
		id_buku INTEGER PRIMARY KEY NOT NULL,
		judul VARCHAR (100) NOT NULL,
		jenis VARCHAR (50) NULL,
		harga VARCHAR (50) NULL,
		id_penerbit INTEGER NOT NULL,
		
		CONSTRAINT FK_BUKU_PENERBIT FOREIGN KEY (id_penerbit) REFERENCES penerbit_coswick (id_penerbit)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,);

		INSERT INTO buku_coswick(id_buku,judul,jenis,harga,id_penerbit)
		VALUES (6,'Laskar Pelangi','novel','30.000',1),
		(7,'Negeri para Pedebah','fiksi','76.000',2),
		(8,'Koala Kumal','novel','83.000',3);

		SELECT * FROM buku_coswick


CREATE TABLE pembelian_coswick(
		id_buku INTEGER NOT NULL,
		id_pemebeli INTEGER NOT NULL,
		tgl_beli DATETIME NOT NULL,
		jumlah INTEGER,
		
		CONSTRAINT FK_PEMBELIAN_BUKU FOREIGN KEY (id_buku) REFERENCES buku_coswick (id_buku)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,

		CONSTRAINT FK_PEMBELIAN_PEMBELI FOREIGN KEY (id_pemebeli) REFERENCES pemebeli_coswick (id_pemebeli)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	

		CONSTRAINT PK_PEMBELIAN PRIMARY KEY (id_buku,id_pemebeli));

		INSERT INTO pembelian_coswick(id_buku,id_pemebeli,tgl_beli,jumlah)
		VALUES (6,11,'2019-12-28',4),
		(7,12,'2019-12-31',2),
		(8,13,'2020-01-01',5);

		SELECT * FROM pembelian_coswick
		 

CREATE TABLE riwayat_penulis_coswick(
		id_penulis INTEGER NOT NULL,
		id_buku INTEGER NOT NULL,
		tahun INTEGER,
		
		CONSTRAINT FK_RIWAYAT_PENULIS FOREIGN KEY (id_penulis) REFERENCES penulis_coswick (id_penulis)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,

		CONSTRAINT FK_RIWAYAT_BUKU FOREIGN KEY (id_buku) REFERENCES buku_coswick (id_buku)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
		
		CONSTRAINT PK_RIWAYAT_PENULIS PRIMARY KEY (id_penulis,id_buku));

		INSERT INTO riwayat_penulis_coswick(id_penulis,id_buku,tahun)
		VALUES (1,6,2016),
		(2,7,2008),
		(3,8,2019);
		
		SELECT * FROM riwayat_penulis_coswick


CREATE TABLE penerbit_telp_coswick(
		no_telp VARCHAR (100) PRIMARY KEY NOT NULL,
		id_penerbit INTEGER NOT NULL,
		
		CONSTRAINT FK_NOTELP_PENERBIT FOREIGN KEY (id_penerbit) REFERENCES penerbit_coswick (id_penerbit)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,);

		INSERT INTO penerbit_telp_coswick(no_telp,id_penerbit)
		VALUES (+6281575820294,1),
		(+6283872149631,2),
		(+6287669500347,3);

		
		SELECT * FROM penerbit_telp_coswick

--4. [10 POIN] Buatlah 1 contoh query UPDATE dengan suatu kondisi dan menggunakan operator kondisi--

	
		UPDATE penerbit_coswick
		SET nama = 'Graha Pustaka'
		WHERE jalan = 'Teratai 7'
		AND id_penerbit = 2;

		SELECT * FROM penerbit_coswick ;


		UPDATE KELAS
		SET NIP = 20180102
		WHERE IDKELAS BETWEEN 1 AND 3;



--Buatlah 5 contoh query SELECT dengan menerapkan join/operator kondisi/fungsi agregasi/group by/order by/having!--

--1. MELIHAT SEMUA NAMA PEMBELI
	SELECT  nama  FROM pemebeli_coswick
	WHERE NAMA LIKE '%I'
	ORDER BY NAMA ASC

--2. MELIHAT DATA ID_BUKU, JUDUL, ID_PEMBELI, JUMLAH (dari 2 table)
	 SELECT B.ID_BUKU, B.JUDUL, P.ID_PEMEBELI, P.JUMLAH
	 FROM BUKU_COSWICK B LEFT JOIN PEMBELIAN_COSWICK P
	 ON B.ID_BUKU = P.ID_BUKU 
	 ORDER BY ID_BUKU DESC


-- 3. Mencari jumlah buku yang terjual lebih dari 2 buah--
	SELECT B.JUDUL,SUM (P.jumlah) 'jumlah terjual'
	from  buku_coswick B LEFT JOIN pembelian_coswick P
	ON B.id_buku = P.id_buku
	WHERE jumlah>2
	GROUP BY judul

--4. Menampilkan Tahun terbit buku dari terbaru ke terlama--
	SELECT rw.TAHUN, b.JUDUL, bt.NAMA
	FROM riwayat_penulis_coswick rw LEFT JOIN buku_coswick b
	ON rw.id_buku = b.id_buku
	LEFT JOIN penerbit_coswick bt
	ON b.id_penerbit = bt.id_penerbit
	ORDER BY tahun DESC


--5.Menampilkan judul buku yang dibeli oleh pembeli yang lahirnya tanggal 05-04-2000
	SELECT b.JUDUL, p.nama, p.tanggal_lahir
	FROM buku_coswick b LEFT JOIN pembelian_coswick pm
	ON b.id_buku = pm.id_buku
	LEFT JOIN pemebeli_coswick p
	ON pm.id_pemebeli = p.id_pemebeli
	WHERE p.tanggal_lahir ='2000-04-05'



