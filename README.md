crumbl
============

Command line tool for reading and manipulating encoded or encrypted Rails cookies

# Installation
`gem install crumbl`

# Usage

#### Decrypt Rails 4 encrypted cookie:

```
$ crumbl decrypt "secret key base" RWRWZ0xHSEsrNmx1TlZFOEpmcCtNVEY4QjdKelNETWlNdVV0TnlCZU0zTnA4ejZka2ZCR2EyQStydGhOaTRySC0tOEQyMFc2SkpLejRidjV5V1ZBUXpEUT09--67e625ac91a2fecc9a3da7146a3a92b667e0ed17
{"session_type"=>"user"}
```

#### Encrypt Rails 4 cookie:
```
$ crumbl encrypt "secret key base" --data session_type:admin
QnprY1BXSlI3WFo1MkxlZmJ6REE3b1N2ZExFaHdqYncvYnNTcHZTL0dQbmZ3RVVwU3hxNmpiVkJtQmNOTW4zYy0tNitvbnhGQ0szbWtIOTU4czNzMnJSUT09--4f397df94a66a3449511485c76e130ac10a35f32
```

#### Decode Rails 3 signed cookie:

```
$ crumbl decode BAh7BkkiEXNlc3Npb25fdHlwZQY6BkVUSSIJdXNlcgY7AFQ=--ff2751f14c049e970cd817b6bbb6575b7c8a7bd8
{"session_type"=>"user"}
```

#### Encode Rails 3 signed cookie:

```
$ crumbl encode "signing key" --data session_type:admin
BAh7BkkiEXNlc3Npb25fdHlwZQY6BkVUSSIKYWRtaW4GOwBU--a44fc16d8c2f185e4b667c4276e790ae1d40c505
```
