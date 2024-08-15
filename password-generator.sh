#!/bin/bash
show_help() {
  echo "Bem vindo ao password-generator! Versão 1.0, (c) 2024, Fabrício Moura Jácome, DIMAp, UFRN
Uso: ./password-generator.sh [OPÇÕES]
Opções:
  -l [COMPRIMENTO] : comprimento da senha
  -u               : incluir letras maiúsculas
  -d               : incluir números
  -s               : incluir símbolos
  -h               : exibir essa mensagem de ajuda

O comportamento padrão do script é gerar uma senha de 8 caracteres minúsculos."
}

# Definir variáveis padrão
LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false

# Parsear argumentos
while getopts ":l:udsh" opt; do
  case "$opt" in
  l)
    LENGTH=$OPTARG
    ;;
  u)
    USE_UPPERCASE=true
    ;;
  d)
    USE_DIGITS=true
    ;;
  s)
    USE_SYMBOLS=true
    ;;
  h)
    show_help
    ;;
  esac
done

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
