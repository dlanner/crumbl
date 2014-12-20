crumbl
============

Command line tool for reading and writing encoded or encrypted Rails sessions

[![Build Status](https://api.travis-ci.org/dlanner/crumbl.png?branch=master)](https://travis-ci.org/dlanner/crumbl) 

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
$ crumbl encrypt "secret key base"
Data to encrypt: 
crumbl> {:session_type=>"admin"}
=> eXV1ckhjbHhiTjMrOFI1VzVWUzNrNnFSQnhFZzdWNE5iS2ZvaFRHRFBtaz0tLVQvNmhGSE5KeENFbWxUd0pHV2RLbnc9PQ==--7061c2425a407e5820d33d68739f54cf8a072ca3
```

#### Decode Rails 3 signed cookie:

```
# crumbl decode BAh7BjoRc2Vzc2lvbl90eXBlSSIJdXNlcgY6BkVU--b5ff66e18316d861087756523d129a17fcc801af
{"session_type"=>"user"}
```

#### Encode Rails 3 signed cookie:

```
$ crumbl encode "signing key"
Data to encode: 
crumbl> {:session_type=>"admin"}
=> BAh7BjoRc2Vzc2lvbl90eXBlSSIKYWRtaW4GOgZFVA==--c2d31489de15c835a8984011f0d36f44679ad5ad

```
