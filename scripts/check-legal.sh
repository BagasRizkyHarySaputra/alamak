#!/bin/bash
# check-legal.sh — pastikan repo tidak bocor lisensi/installer
# Dipakai: ./scripts/check-legal.sh  (exit 1 kalau kotor)
# Hanya flag HIGH-CONFIDENCE: isi hexlic asli, file biner sensitif, .gitignore lemah.
# Kata edukasi seperti "jangan pakai crack/keygen" di docs TIDAK di-flag.
set -u
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FAIL=0
echo "== Legal check: $REPO_ROOT =="

# 1. Pattern high-confidence (isi lisensi asli). Exclude checker itu sendiri + .git
if grep -rIn --exclude-dir=.git --exclude="check-legal.sh" --exclude="Check-Legal.ps1" --exclude="legal-check.yml" -E "48-1337-DEAD|BEGIN IDA LICENSE|48-[0-9A-F]{4}-[A-Z]{4}-[0-9A-F]{2}" "$REPO_ROOT" 2>/dev/null; then
  echo "[FAIL] isi lisensi IDA terdeteksi di atas" >&2
  FAIL=1
else
  echo "[OK] tidak ada isi lisensi (48-1337 / BEGIN IDA LICENSE)"
fi

# 2. File biner/sensitif yang tidak boleh ada
BAD_FILES=$(find "$REPO_ROOT" -path "$REPO_ROOT/.git" -prune -o -type f \( \
  -name "*.hexlic" -o -name "*.run" -o -name "core.*" -o -name "*.bak" -o -name "*.bak2" \
  -o -name "*.idb" -o -name "*.i64" \) -print 2>/dev/null)
if [ -n "$BAD_FILES" ]; then
  echo "[FAIL] file terlarang ditemukan:" >&2; echo "$BAD_FILES" >&2; FAIL=1
else
  echo "[OK] tidak ada file *.hexlic/*.run/core.*/*.bak/*.idb/*.i64"
fi

# 3. .gitignore wajib block
for must in "hexlic" "core.*" "*.bak" "idapro"; do
  if grep -qF "$must" "$REPO_ROOT/.gitignore" 2>/dev/null; then echo "[OK] .gitignore memblokir: $must"
  else echo "[FAIL] .gitignore BELUM memblokir: $must" >&2; FAIL=1; fi
done

if [ $FAIL -eq 0 ]; then echo "== LEGAL CLEAN =="
else echo "== LEGAL DIRTY — perbaiki sebelum push! ==" >&2; exit 1; fi
