#!/bin/bash
# Função para exibir a ajuda
# show_help() {
#   # Implementação vai aqui
# }

# Definir variáveis padrão
LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false

# Parsear argumentos
# { Implementação vai aqui }

# Definir conjuntos de caracteres
LOWERCASE="abcdefghijklmnopqrstuvwxyz"
UPPERCASE="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
DIGITS="0123456789"
SYMBOLS="!@#$%^&*()-_=+[]{}|;:,.<>?/~"

CHARS=$LOWERCASE
if [[ $USE_UPPERCASE = true ]]; then
  CHARS+=$UPPERCASE
fi
if [[ $USE_DIGITS = true ]]; then
  CHARS+=$DIGITS
fi
if [[ $USE_SYMBOLS = true ]]; then
  CHARS+=$SYMBOLS
fi

PASSWORD=$(tr -dc $CHARS </dev/urandom | head -c $LENGTH)
echo "Senha gerada: $PASSWORD"

# Opcional: salvar a senha em um arquivo criptografado
# Implemente como essa senha será criptografada com o openssl
# echo $PASSWORD >>password.txt.enc
