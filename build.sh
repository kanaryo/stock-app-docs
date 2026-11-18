#!/bin/bash
set -e   # エラーが出たらそこで止まる

cd "$(dirname "$0")"
rm -rf out

echo "=== HTML5 ==="
dita --input=stock-app.ditamap --format=html5 --output=out/html

echo "=== PDF ==="
dita --input=stock-app.ditamap --format=pdf --output=out/pdf \
     --customization.dir="$PWD/pdf-custom"

echo "=== HTML5 (public) ==="
dita --input=stock-app.ditamap --format=html5 --output=out/public \
     --filter=filters/public.ditaval

echo "=== PDF (public) ==="
dita --input=stock-app.ditamap --format=pdf --output=out/public-pdf \
     --filter=filters/public.ditaval \
     --customization.dir="$PWD/pdf-custom"

echo "Done: out/html, out/pdf (internal) / out/public, out/public-pdf (public)"