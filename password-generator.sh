#!/bin/bash
show_help() {
  echo "Bem vindo ao password-generator! Versão 1.0, (c) 2024, Fabrício Moura Jácome, DIMAp, UFRN
Uso: ./password-generator.sh [OPÇÕES]
Opções:
  -l LENGTH  Especifica o tamanho da senha (padrão: 8)
  -u         Inclui letras maiúsculas na senha
  -d         Inclui dígitos na senha
  -s         Inclui símbolos na senha
  -h         Exibe essa ajuda
  -o         Salva a senha gerada em um arquivo
  -n NAME    Adiciona um nome a senha gerada
  -p         Exibe senhas geradas

O comportamento padrão do script é gerar uma senha de 8 caracteres minúsculos."
}

OUTPUT_FILE="passwords.txt"
list_pwds() {
  echo -e "\nSenhas existentes:"
  cat $OUTPUT_FILE
}

# Definir variáveis padrão
LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false
SAVE_PWD=false
LIST_PWDS=false
NAME=""
HAS_NAME=false

# Parsear argumentos
while getopts ":l:udshon:p" opt; do
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
  o)
    SAVE_PWD=true
    ;;
  n)
    HAS_NAME=true
    NAME=$OPTARG
    ;;
  p)
    LIST_PWDS=true
    ;;
  h)
    show_help
    exit
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

if [[ $LIST_PWDS = true ]]; then
  list_pwds
fi

if [[ $SAVE_PWD = true ]]; then
  if [[ $HAS_NAME = true ]]; then
    echo "$NAME: $PASSWORD" >>$OUTPUT_FILE
  elif [[ $HAS_NAME = false ]]; then
    echo "$PASSWORD" >>$OUTPUT_FILE
  fi
fi
