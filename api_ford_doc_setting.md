src_dir: ./src
output_dir: ./api-doc
project: sieve_of_eratosthenes
summary: エラトステネスのふるいを用いて、指定の自然数以下の素数を調べるプログラムです。
author: gobytis
license: by-nc

## 使用方法

標準出力に n 以下の素数を表示する場合はコマンド ラインで
以下を実行してください (n = 10 の場合)。

```
> sieve_of_eratosthenes.exe 10
```

特定のファイルに n 以下の素数を出力する場合はコマンド ラインで
以下を実行してください (n = 10、出力ファイル名 primes.txt の場合)。
```
> sieve_of_eratosthenes.exe 10 primes.txt
```
