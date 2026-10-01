# PRIVATE SETUP (tim internal) — full setup tanpa lisensi masuk git

> Untuk repo private internal. Lisensi **tidak pernah di-commit** — disebar via SSH/`scp` terenkripsi antar mesin.

## Konsep
```
mesin-A (sudah ada ~/idapro-9.0/ida.hexlic)
   --scp via SSH-->  mesin-B (baru clone repo ini)
                          --setup-license.sh--> ~/idapro-9.0/ida.hexlic (mode 600)
```
Git hanya berisi `assets/ida.hexlic.example` + scripts. File asli lewat jalur SSH saja.

## 1. Syarat
- SSH antar mesin bisa (key, bukan password): `ssh-copy-id user@mesin-B`
- IDA sudah terinstall di kedua mesin (lihat INSTALL-LINUX/WINDOWS-ID.md)
- Repo ini sudah di-clone di kedua mesin

## 2. Kirim lisensi A → B (jalankan di A)
```bash
# cek dulu lisensi lokal A ada:
./scripts/setup-license.sh --check

# kirim ke B (ganti user/host/path):
./scripts/sync-license.sh push user@mesin-B
# atau path custom:
./scripts/sync-license.sh push user@mesin-B --ida-dir /opt/idapro-9.0
```

## 3. Tarik lisensi dari A (jalankan di B)
```bash
./scripts/sync-license.sh pull user@mesin-A
```

## 4. Verifikasi di B
```bash
./scripts/setup-license.sh --check
./scripts/check-ida.sh
./scripts/check-legal.sh   # harus LEGAL CLEAN (repo tetap bersih)
```

## Windows
```powershell
# pastikan OpenSSH client aktif (Settings > Optional features)
scripts\Setup-License.ps1              # cek lokal
scp user@mesin-A:"/home/user/idapro-9.0/ida.hexlic" "$env:TEMP\ida.hexlic"
scripts\Setup-License.ps1 -Src "$env:TEMP\ida.hexlic"
Remove-Item "$env:TEMP\ida.hexlic" -Force
```

## Aturan tim (WAJIB)
1. Jangan pernah `git add *.hexlic` — `check-legal.sh` + CI akan gagalkan push.
2. Lisensi hanya di `~/idapro-9.0/ida.hexlic` (mode 600), backup di password manager, bukan di git.
3. Karyawan keluar → revoke akses SSH + ganti lisensi via Hex-Rays.
4. Audit berkala: `./scripts/check-legal.sh` di semua clone.
