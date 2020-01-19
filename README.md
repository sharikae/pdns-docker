PowerDNS Server with Docker
===========
PowerDNSを使って、外向け権威DNS/内向けDNS/内向けキャッシュDNS/リクエスト振り分け用のdnsdistを構築できるdocker-compose

PowerDNS Adminと組み合わせることでWEBUI,RESTAPIを使ったレコード設定もできる

## 仕様
- インターネットからのリクエスト -> 外向け権威DNSのドメインのみ応答
- LANからのリクエスト -> 内向き権威DNS -> キャッシュDNSの順に応答

## セットアップ
- `{CHANGE_ME}`となっているところをいい感じに置き換える
- `dnsdist/config/dnsdist.conf`の`example.com`もいい感じに変更・追加する
- `docker-compose.yml`の`{YOUR_LOCAL_IP}`をDockerホストのIPアドレスに設定

- イメージのビルド
    ```shell script
    $ docker-compose build
    ```

- mysqlコンテナを起動しておく
    ```shell script
    $ docker-compose up -d pdns-db
    ```

- 外向け権威DNS,内向けDNSのマイグレーションを行う(`authoritative/assets/sql/pdns.sql`を流し込むだけのスクリプト)
    ```shell script
    $ docker-compose run authoritative create_db.sh
    $ docker-compose run local create_db.sh
    ```

- 本体を起動する
    ```shell script
    $ docker-compose up
    ```
