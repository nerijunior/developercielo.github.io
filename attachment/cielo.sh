#!/bin/bash
if [ $EUID != 0 ]; then
    echo 'Você precisa ser root para instalar certificados.'
    exit $?
fi

# Diretório onde os certificados serão instalados
cert_path=`openssl version -d|sed 's/.*\"\(.*\)\"/\1/g'`/certs

# Path para o certificado da Cielo
ecommerce=$cert_path/ecommerce-cielo.crt
# Path para o certificado da intermediária
intermediaria=$cert_path/intermediaria-cielo.crt
# Path para o certificado raiz
raiz=$cert_path/raiz-cielo.crt

# Instalação do certificado raiz
echo "Criando certificado raiz em $raiz"

(cat << 'RAIZ-CIELO'
-----BEGIN CERTIFICATE-----
MIIEPjCCAyagAwIBAgIESlOMKDANBgkqhkiG9w0BAQsFADCBvjELMAkGA1UEBhMC
VVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50
cnVzdC5uZXQvbGVnYWwtdGVybXMxOTA3BgNVBAsTMChjKSAyMDA5IEVudHJ1c3Qs
IEluYy4gLSBmb3IgYXV0aG9yaXplZCB1c2Ugb25seTEyMDAGA1UEAxMpRW50cnVz
dCBSb290IENlcnRpZmljYXRpb24gQXV0aG9yaXR5IC0gRzIwHhcNMDkwNzA3MTcy
NTU0WhcNMzAxMjA3MTc1NTU0WjCBvjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVu
dHJ1c3QsIEluYy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50cnVzdC5uZXQvbGVnYWwt
dGVybXMxOTA3BgNVBAsTMChjKSAyMDA5IEVudHJ1c3QsIEluYy4gLSBmb3IgYXV0
aG9yaXplZCB1c2Ugb25seTEyMDAGA1UEAxMpRW50cnVzdCBSb290IENlcnRpZmlj
YXRpb24gQXV0aG9yaXR5IC0gRzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC6hLZy254Ma+KZ6TABp3bqMriVQRrJ2mFOWHLP/vaCeb9zYQYKpSfYs1/T
RU4cctZOMvJyig/3gxnQaoCAAEUesMfnmr8SVycco2gvCoe9amsOXmXzHHfV1IWN
cCG0szLni6LVhjkCsbjSR87kyUnEO6fe+1R9V77w6G7CebI6C1XiUJgWMhNcL3hW
wcKUs/Ja5CeanyTXxuzQmyWC48zCxEXFjJd6BmsqEZ+pCm5IO2/b1BEZQvePB7/1
U1+cPvQXLOZprE4yTGJ36rfo5bs0vBmLrpxR57d+tVOxMyLlbc9wPBr64ptntoP0
jaWvYkxN4FisZDQSA/i2jZRjJKRxAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAP
BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBRqciZ60B7vfec7aVHUbI2fkBJmqzAN
BgkqhkiG9w0BAQsFAAOCAQEAeZ8dlsa2eT8ijYfThwMEYGprmi5ZiXMRrEPR9RP/
jTkrwPK9T3CMqS/qF8QLVJ7UG5aYMzyorWKiAHarWWluBh1+xLlEjZivEtRh2woZ
Rkfz6/djwUAFQKXSt/S1mja/qYh2iARVBCuch38aNzx+LaUa2NSJXsq9rD1s2G2v
1fN2D807iDginWyTmsQ9v4IbZT+mD12q/OWyFcq1rca8PdCE6OoGcrBNOTJ4vz4R
nAuknZoh8/CbCzB428Hch0P+vGOaysXCHMnHjf87ElgI5rY97HosTvuDls4MPGmH
VHOkc8KT/1EQrBVUAdj8BbGJoX90g5pJ19xOe4pIb4tF9g==
-----END CERTIFICATE-----
RAIZ-CIELO
) > $raiz

echo "Instalando o certificado raiz"

# Criando um link simbólico para o certificado utilizando seu hash
ln -s $raiz $cert_path/`openssl x509 -noout -hash -in $raiz`.0 &> /dev/null

# Verificando se o certificado foi instalado corretamente
openssl verify -CApath $cert_path $raiz

# Instalação do certificado da intermediária
echo "Criando certificado da intermediária em $intermediaria"

(cat << 'INTERMEDIARIA-CIELO'
-----BEGIN CERTIFICATE-----
MIIFAzCCA+ugAwIBAgIEUdNg7jANBgkqhkiG9w0BAQsFADCBvjELMAkGA1UEBhMC
VVMxFjAUBgNVBAoTDUVudHJ1c3QsIEluYy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50
cnVzdC5uZXQvbGVnYWwtdGVybXMxOTA3BgNVBAsTMChjKSAyMDA5IEVudHJ1c3Qs
IEluYy4gLSBmb3IgYXV0aG9yaXplZCB1c2Ugb25seTEyMDAGA1UEAxMpRW50cnVz
dCBSb290IENlcnRpZmljYXRpb24gQXV0aG9yaXR5IC0gRzIwHhcNMTQxMDIyMTcw
NTE0WhcNMjQxMDIzMDczMzIyWjCBujELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUVu
dHJ1c3QsIEluYy4xKDAmBgNVBAsTH1NlZSB3d3cuZW50cnVzdC5uZXQvbGVnYWwt
dGVybXMxOTA3BgNVBAsTMChjKSAyMDEyIEVudHJ1c3QsIEluYy4gLSBmb3IgYXV0
aG9yaXplZCB1c2Ugb25seTEuMCwGA1UEAxMlRW50cnVzdCBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eSAtIEwxSzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANo/ltBNuS9E59s5XptQ7lylYdpBZ1MJqgCajld/KWvbx+EhJKo60I1HI9Ltchbw
kSHSXbe4S6iDj7eRMmjPziWTLLJ9l8j+wbQXugmeA5CTe3xJgyJoipveR8MxmHou
fUAL0u8+07KMqo9Iqf8A6ClYBve2k1qUcyYmrVgO5UK41epzeWRoUyW4hM+Ueq4G
RQyja03Qxr7qGKQ28JKyuhyIjzpSf/debYMcnfAf5cPW3aV4kj2wbSzqyc+UQRlx
RGi6RzwE6V26PvA19xW2nvIuFR4/R8jIOKdzRV1NsDuxjhcpN+rdBQEiu5Q2Ko1b
Nf5TGS8IRsEqsxpiHU4r2RsCAwEAAaOCAQkwggEFMA4GA1UdDwEB/wQEAwIBBjAP
BgNVHRMECDAGAQH/AgEAMDMGCCsGAQUFBwEBBCcwJTAjBggrBgEFBQcwAYYXaHR0
cDovL29jc3AuZW50cnVzdC5uZXQwMAYDVR0fBCkwJzAloCOgIYYfaHR0cDovL2Ny
bC5lbnRydXN0Lm5ldC9nMmNhLmNybDA7BgNVHSAENDAyMDAGBFUdIAAwKDAmBggr
BgEFBQcCARYaaHR0cDovL3d3dy5lbnRydXN0Lm5ldC9ycGEwHQYDVR0OBBYEFIKi
cHTdvFM/z3vU981/p2DGCky/MB8GA1UdIwQYMBaAFGpyJnrQHu995ztpUdRsjZ+Q
EmarMA0GCSqGSIb3DQEBCwUAA4IBAQA/HBpb/0AiHY81DC2qmSerwBEycNc2KGml
jbEnmUK+xJPrSFdDcSPE5U6trkNvknbFGe/KvG9CTBaahqkEOMdl8PUM4ErfovrO
GhGonGkvG9/q4jLzzky8RgzAiYDRh2uiz2vUf/31YFJnV6Bt0WRBFG00Yu0GbCTy
BrwoAq8DLcIzBfvLqhboZRBD9Wlc44FYmc1r07jHexlVyUDOeVW4c4npXEBmQxJ/
B7hlVtWNw6f1sbZlnsCDNn8WRTx0S5OKPPEr9TVwc3vnggSxGJgO1JxvGvz8pzOl
u7sY82t6XTKH920l5OJ2hiEeEUbNdg5vT6QhcQqEpy02qUgiUX6C
-----END CERTIFICATE-----
INTERMEDIARIA-CIELO
) > $intermediaria

echo "Instalando certificado da intermediária"

# Criando um link simbólico para o certificado utilizando seu hash
ln -s $intermediaria $cert_path/`openssl x509 -noout -hash -in $intermediaria`.0 &> /dev/null

# Verificando se o certificado foi instalado corretamente
openssl verify -CApath $cert_path $intermediaria

# Instalação do certificado Cielo
echo "Criando certificado ecommerce da Cielo em $ecommerce"

(cat << 'ECOMMERCE-CIELO'
-----BEGIN CERTIFICATE-----
MIIFaTCCBFGgAwIBAgIRAMmqLfik3lvdAAAAAFDYAn8wDQYJKoZIhvcNAQELBQAw
gboxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1FbnRydXN0LCBJbmMuMSgwJgYDVQQL
Ex9TZWUgd3d3LmVudHJ1c3QubmV0L2xlZ2FsLXRlcm1zMTkwNwYDVQQLEzAoYykg
MjAxMiBFbnRydXN0LCBJbmMuIC0gZm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxLjAs
BgNVBAMTJUVudHJ1c3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgLSBMMUswHhcN
MTYwNTA0MTQyMDU2WhcNMTcwNTA0MTQ1MDU0WjBwMQswCQYDVQQGEwJCUjESMBAG
A1UECBMJU2FvIFBhdWxvMRAwDgYDVQQHEwdCYXJ1ZXJpMRMwEQYDVQQKEwpDSUVM
TyBTLkEuMSYwJAYDVQQDDB0qLmNpZWxvZWNvbW1lcmNlLmNpZWxvLmNvbS5icjCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK+yJA1je0bn2gxJxtr5Dngn
GlrBWTUSIiUsQvwdlNq+JFfuqjXXYMd1oFFX5ADG8cioLF/dYQiHp43FjK74Wd5H
yfORXXQSWM5HC+yspVBYj9wJdZZyscpTfsGEdVUsMzo4r8TJgqSWuNtDE8H79w16
mDuIK46SNh6IhpaLuZk2gmY41lydUqyfggkk4U+DRnTw1LK02DOhkRwSJdwmXhyj
i4I36DU1egDf9p0LhVfUh5Elvbz0V1eFZpcxpSej41xg4/TGdl0jCBBrSB3TsB5g
UtF81NlctxhY3IbLenfJqxJ2n6dRsq5ScErSXiayr6ntDv24LFmC0s77Ko2MMyUC
AwEAAaOCAbEwggGtMA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcD
AQYIKwYBBQUHAwIwMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5lbnRydXN0
Lm5ldC9sZXZlbDFrLmNybDBLBgNVHSAERDBCMDYGCmCGSAGG+mwKAQUwKDAmBggr
BgEFBQcCARYaaHR0cDovL3d3dy5lbnRydXN0Lm5ldC9ycGEwCAYGZ4EMAQICMGgG
CCsGAQUFBwEBBFwwWjAjBggrBgEFBQcwAYYXaHR0cDovL29jc3AuZW50cnVzdC5u
ZXQwMwYIKwYBBQUHMAKGJ2h0dHA6Ly9haWEuZW50cnVzdC5uZXQvbDFrLWNoYWlu
MjU2LmNlcjBFBgNVHREEPjA8gh0qLmNpZWxvZWNvbW1lcmNlLmNpZWxvLmNvbS5i
coIbY2llbG9lY29tbWVyY2UuY2llbG8uY29tLmJyMB8GA1UdIwQYMBaAFIKicHTd
vFM/z3vU981/p2DGCky/MB0GA1UdDgQWBBR87HomjWY8CWiKRmbR6cdXU1RAnDAJ
BgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBAQCwvXohd147ZT8Z/cVsd4u2e/BQ
ySz8rFHYTFQ2W0U3oQnxjp2lBbcJeC3u2301+H2rAJ9ONPQ/AUxpXFYgWduWOqF4
ysEJL1baWVmhsYDpGSi++NR1BP+xVwDHqp1aJ5uMh2O3GwfC31cLA1g0mgbBbkwo
ZZJpDuFsHpppD9CO4jp8JGMDeKj2nT70lFuddcjfHugeABOOIRE/1lhHFQIZimsY
c4KQ+nidWy+IyNOqmyEx+gZ7sfbuv11SIeqWO3z2r60LhrHEcyDtF4tRmDz+v9Qx
Y1kEhCBcVTO+0qI10kaRDYDg4shmjq6kTcUcQJLA6bYQ13Ygr3DxgBRuHcN7
-----END CERTIFICATE-----
ECOMMERCE-CIELO
) > $ecommerce

echo "Instalando certificado ecommerce da Cielo"

# Criando um link simbólico para o certificado utilizando seu hash
ln -s $ecommerce $cert_path/`openssl x509 -noout -hash -in $ecommerce`.0 &> /dev/null

# Verificando se o certificado foi instalado corretamente
openssl verify -CApath $cert_path $ecommerce

# Exibindo informações do certificado instalado
openssl x509 -in $ecommerce -text -noout
