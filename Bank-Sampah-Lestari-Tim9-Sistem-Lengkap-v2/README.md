# Sistem Informasi Bank Sampah Lestari — Kelurahan Airmadidi
**Final Project Analisis dan Perancangan Sistem · Tim 9 (YTTA)**

## Pembaruan Fitur Pencairan Saldo Nasabah & Konfirmasi Bendahara
- **Pengajuan Pencairan Mandiri oleh Nasabah**: Nasabah dapat mengajukan pencairan saldo langsung dari akunnya (`Menu Ajukan Pencairan Saldo`).
- **Konfirmasi Bendahara (Ibu Sintia)**: Pengajuan dari nasabah masuk dengan status `Menunggu Konfirmasi` dan saldo belum terpotong sebelum dikonfirmasi oleh Bendahara (`Menu Konfirmasi Pengajuan Nasabah`).
- **Validasi Aturan Bisnis Otomatis**:
  - Saldo nasabah mencukupi & tidak ada pengajuan ganda yang masih pending.
  - Penarikan reguler minimal **Rp 50.000** dan maksimal **1 kali per bulan**.
  - Khusus bulan **Desember**, nasabah dapat menarik **seluruh saldo** tanpa batas minimal dan tanpa batas frekuensi.

## Akun Uji Per Aktor
1. **Ketua (Ibu Meiske Rondonuwu)** -> Username: `ketua` | Password: `ketua123`
2. **Petugas Timbang (Pak Yopi / Ibu Lina)** -> Username: `petugas` (atau `lina`) | Password: `petugas123`
3. **Bendahara (Ibu Sintia)** -> Username: `bendahara` | Password: `bendahara123`
4. **Nasabah (Maria Kaligis)** -> Username / No. Buku: `BS-001` | Password: `123456`
