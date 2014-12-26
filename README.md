crumbl
============

Command line tool for reading and writing encoded or encrypted Rails sessions

[![Build Status](https://api.travis-ci.org/dlanner/crumbl.png?branch=master)](https://travis-ci.org/dlanner/crumbl) 

# Installation
`gem install crumbl`

# Usage

```
$ crumbl help
Commands:
  crumbl decode [COOKIE]              # Decode a Rails 3 cookie [COOKIE]
  crumbl decrypt [KEY BASE] [COOKIE]  # Decrypt Rails 4 [COOKIE] using secret key base [KEY BASE]
  crumbl encode [KEY]                 # Encode [DATA] as a Rails 3 cookie signed with secret key [KEY]
  crumbl encrypt [KEY BASE]           # Encrypt Rails 4 [DATA] using secret key base [KEY BASE]
  crumbl help [COMMAND]               # Describe available commands or one specific command
```

#### Decrypt Rails 4 encrypted cookie:

```
$ crumbl decrypt "secret key base" V25qdmEwZVp3ME9HNXU5ZkxzM2srQlFrcU1FQ3dGYit1YmtlRVVnVVRROD0tLTI0U2t1cXZhNDhucGtxMnIyVTFXN2c9PQ==--62bb4aa196b53de5cc993e6377be37d704aaf372
{:session_type=>"user"}
```

#### Encrypt Rails 4 cookie:

```
$ crumbl encrypt "secret key base"
Data to encrypt: 
crumbl> {:session_type=>"admin"}
=> Z1FpV2FHRjVXQmtRQUJiamo4Vm1XSThpK0xVMlVNSUVFblpRODAvcFA0WT0tLWNlSW4zdzM1VGNmNHZNR1pSVUxMaUE9PQ==--da1cab0cf5b4a6429c9afba06294dcee5da32172
```

#### Decode Rails 3 signed cookie:

```
# crumbl decode BAhJIh17OnNlc3Npb25fdHlwZT0+ImFkbWluIn0GOgZFVA==--4f4881f111cd39dc06b8189580088b1472daf045
{:session_type=>"admin"}
```

#### Encode Rails 3 signed cookie:

```
$ crumbl encode "signing key"
Data to encode: 
crumbl> {:session_type=>"admin"}
=> BAhJIh17OnNlc3Npb25fdHlwZT0+ImFkbWluIn0GOgZFVA==--4f4881f111cd39dc06b8189580088b1472daf045
```

# Options

#### JSON Input:

```
$ crumbl encrypt "secret key base"
Data to encrypt: 
crumbl> {"allowed_ip": "1.2.3.4"}
=> K0hjc1FYdW9hUWVkRFA2MFhHVFE4dmhWalVCSndITWtlanhVRW1ZYmM3TT0tLXhvQm1EZWZhRnZLT3E3SFgzQTFhU3c9PQ==--b9e14fdf3c4f216824a3336079853b63cbaf5d47
```