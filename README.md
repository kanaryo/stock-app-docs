# stock-app-docs

個人開発の株式ポートフォリオアプリ[「Kanai Stock App」](https://github.com/kanaryo/stock-app)の運用ドキュメントを、**DITA XML** で構造化して書いたサンプルプロジェクトです。

DITA Open Toolkit（DITA-OT）を使い、1つのソースから HTML5 と PDF、社内向けと社外向けの版を出力します。

> A sample DITA XML project that documents a personal stock portfolio app, built with DITA Open Toolkit into HTML5 and PDF (Japanese).

## 運用ガイド（PDF）
📄 **[stock-app 運用ガイドを見る（PDF）](samples/stock-app.pdf)**

## このプロジェクトで扱っていること

| 項目 | 内容 | 該当ファイル |
|---|---|---|
| 情報タイプ | concept（概念）、task（手順）、reference（参照情報）に分けて記述 | `topics/` |
| マップ | トピックの順番と階層を目次として定義 | `stock-app.ditamap` |
| conref | 注意書きを1か所で管理し、複数のトピックに差し込む | `common/shared.dita` |
| keyref | 製品名を変数としてマップで定義する | `stock-app.ditamap` |
| DITAVAL | `audience="internal"` の要素を社外向けの版から除外する | `filters/` |
| 日本語PDF | IPAexフォントを使うよう、PDFのフォント設定を上書きする | `pdf-custom/` |
| ビルドの自動化 | すべての出力を1つのスクリプトで作る | `build.sh` |

## フォルダ構成

```
stock-app-docs/
├── stock-app.ditamap          # マップ（目次・keyrefの定義）
├── topics/
│   ├── c_architecture.dita    # concept：システム構成
│   ├── t_deploy.dita          # task：デプロイ手順
│   └── r_env_vars.dita        # reference：環境変数一覧
├── common/
│   └── shared.dita            # conrefで再利用する部品
├── filters/
│   ├── public.ditaval         # 社外向け：社内向けの要素を除外
│   └── review.ditaval         # レビュー用：社内向けの要素を色付けで表示
├── pdf-custom/                # PDFの日本語フォント設定
│   ├── catalog.xml
│   └── fo/font-mappings.xml
└── build.sh                   # ビルドスクリプト
```

## 必要な環境

- Java 17 以上
- [DITA Open Toolkit](https://www.dita-ot.org/download) 4.4（`dita` コマンドに PATH が通っていること）
- 日本語フォント（IPAex）

Ubuntu（WSL）での例：

```bash
sudo apt install -y openjdk-21-jre-headless fonts-ipaexfont
```

## ビルド方法

```bash
./build.sh
```

| 出力先 | 内容 |
|---|---|
| `out/html/` | 社内向け HTML5 |
| `out/pdf/` | 社内向け PDF |
| `out/public/` | 社外向け HTML5（DITAVALで社内向けの手順を除外） |
| `out/public-pdf/` | 社外向け PDF |

個別に出力する場合：

```bash
# HTML5
dita --input=stock-app.ditamap --format=html5 --output=out/html

# PDF（日本語フォント設定を使用。customization.dir は絶対パスで指定する）
dita --input=stock-app.ditamap --format=pdf --output=out/pdf \
     --customization.dir="$PWD/pdf-custom"

# 社外向け（DITAVALで絞り込み）
dita --input=stock-app.ditamap --format=html5 --output=out/public \
     --filter=filters/public.ditaval
```

`out/` はビルド結果のため、Git の管理対象外にしています。
