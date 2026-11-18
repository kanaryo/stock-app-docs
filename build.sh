#!/bin/bash
set -e   # エラーが出たらそこで止まる

cd "$(dirname "$0")"
rm -rf out

echo "=== HTML5 ==="
dita --input=stock-app.ditamap --format=html5 --output=out/html

echo "=== PDF ==="
dita --input=stock-app.ditamap --format=pdf --output=out/pdf \
     --customization.dir="$PWD/pdf-custom"

echo "Done: out/html/index.html, out/pdf/stock-app.pdf"