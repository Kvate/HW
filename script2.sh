#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 3 ]; then
  echo "Ошибка! Необходимо указать три аргумента."
  exit 1
fi

# Превращение поданые аргументы в переменные
FILE_PATH=$1
CURRENT_EXTENSION=$2
DESIRED_EXTENSION=$3

# Список поддерживаемых расширений
ALLOWED_EXTENSIONS=(txt pdf doc)

# Проверка текущего и желаемого расширений
for EXT in "$CURRENT_EXTENSION" "$DESIRED_EXTENSION"; do
  if [[ ! " ${ALLOWED_EXTENSIONS[*]} " =~ " $EXT " ]]; then
    echo "Расширение '$EXT' не поддерживается."
    echo "Поддерживаемые форматы: ${ALLOWED_EXTENSIONS[*]}."
    exit 1
  fi
done

# And finally...Меняем расширение
mv "$FILE_PATH" "${FILE_PATH%.*}.$DESIRED_EXTENSION"
# Вывод названия файла без пути
BASE_NAME=${FILE_PATH##*/}
echo "Успешный успех! Файл изменён на ${BASE_NAME%.*}.$DESIRED_EXTENSION."
