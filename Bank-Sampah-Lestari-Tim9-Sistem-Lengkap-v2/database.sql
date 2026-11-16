-- Skema Database Physical Bank Sampah Lestari (Kelurahan Airmadidi)
-- Tim 9 (YTTA) — Termasuk Tabel Pengajuan Pencairan Nasabah

CREATE DATABASE IF NOT EXISTS bank_sampah;
USE bank_sampah;

CREATE TABLE PENGURUS_USER (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    nama_pengurus VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Ketua', 'Petugas Timbang', 'Bendahara') NOT NULL,
    status_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE NASABAH (
    id_nasabah INT AUTO_INCREMENT PRIMARY KEY,
    nomor_buku VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    alamat VARCHAR(200),
    password VARCHAR(255) NOT NULL,
    saldo_terkini DECIMAL(12,2) DEFAULT 0.00,
    status_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE JENIS_SAMPAH (
    id_jenis INT AUTO_INCREMENT PRIMARY KEY,
    nama_jenis VARCHAR(50) UNIQUE NOT NULL,
    status_aktif BOOLEAN DEFAULT TRUE
);

CREATE TABLE HARGA_BULANAN (
    id_harga INT AUTO_INCREMENT PRIMARY KEY,
    id_jenis INT NOT NULL,
    periode_bulan CHAR(7) NOT NULL,
    harga_per_kg DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_jenis) REFERENCES JENIS_SAMPAH(id_jenis)
);

CREATE TABLE TRANSAKSI_SETOR (
    id_setor INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_petugas INT NOT NULL,
    tanggal_setor DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_bruto_rp DECIMAL(12,2) NOT NULL,
    potongan_kas_rp DECIMAL(12,2) NOT NULL,
    total_netto_rp DECIMAL(12,2) NOT NULL,
    status_koreksi BOOLEAN DEFAULT FALSE,
    alasan_koreksi TEXT,
    FOREIGN KEY (id_nasabah) REFERENCES NASABAH(id_nasabah),
    FOREIGN KEY (id_petugas) REFERENCES PENGURUS_USER(id_user)
);

CREATE TABLE DETAIL_SETOR (
    id_detail_setor INT AUTO_INCREMENT PRIMARY KEY,
    id_setor INT NOT NULL,
    id_jenis INT NOT NULL,
    berat_kg DECIMAL(8,2) NOT NULL,
    harga_satuan_rp DECIMAL(10,2) NOT NULL,
    subtotal_rp DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_setor) REFERENCES TRANSAKSI_SETOR(id_setor),
    FOREIGN KEY (id_jenis) REFERENCES JENIS_SAMPAH(id_jenis)
);

CREATE TABLE PENGAJUAN_PENARIKAN (
    id_pengajuan INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    tanggal_pengajuan DATETIME DEFAULT CURRENT_TIMESTAMP,
    tanggal_rencana_ambil DATE NOT NULL,
    jumlah_ajukan_rp DECIMAL(12,2) NOT NULL,
    catatan_nasabah TEXT,
    status_pengajuan ENUM('Menunggu Konfirmasi', 'Disetujui', 'Ditolak') DEFAULT 'Menunggu Konfirmasi',
    id_bendahara INT NULL,
    tanggal_proses DATETIME NULL,
    alasan_tolak TEXT,
    FOREIGN KEY (id_nasabah) REFERENCES NASABAH(id_nasabah),
    FOREIGN KEY (id_bendahara) REFERENCES PENGURUS_USER(id_user)
);

CREATE TABLE PENARIKAN_SALDO (
    id_penarikan INT AUTO_INCREMENT PRIMARY KEY,
    id_nasabah INT NOT NULL,
    id_bendahara INT NOT NULL,
    tanggal_tarik DATETIME DEFAULT CURRENT_TIMESTAMP,
    jumlah_tarik_rp DECIMAL(12,2) NOT NULL,
    status_koreksi BOOLEAN DEFAULT FALSE,
    alasan_koreksi TEXT,
    FOREIGN KEY (id_nasabah) REFERENCES NASABAH(id_nasabah),
    FOREIGN KEY (id_bendahara) REFERENCES PENGURUS_USER(id_user)
);

CREATE TABLE PENJUALAN_PENGEPUL (
    id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
    id_ketua INT NOT NULL,
    tanggal_jual DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ketua) REFERENCES PENGURUS_USER(id_user)
);

CREATE TABLE DETAIL_PENJUALAN (
    id_detail_jual INT AUTO_INCREMENT PRIMARY KEY,
    id_penjualan INT NOT NULL,
    id_jenis INT NOT NULL,
    berat_catatan_kg DECIMAL(8,2) NOT NULL,
    berat_pengepul_kg DECIMAL(8,2) NOT NULL,
    susut_kg DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (id_penjualan) REFERENCES PENJUALAN_PENGEPUL(id_penjualan),
    FOREIGN KEY (id_jenis) REFERENCES JENIS_SAMPAH(id_jenis)
);
