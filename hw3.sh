#!/bin/bash

# Создаем директорию terminal_task/results, если она еще не существует
mkdir -p terminal_task/results

# Преобразуем файл gff3 и создаем новую таблицу
awk '
BEGIN { FS="\t"; OFS="\t" }
$3 == "gene" && $9 ~ /gene_type=unprocessed_pseudogene/ {
    # Извлекаем название гена из 9-го поля
    match($9, /gene_name=[^;]+/, arr)
    gene_name = substr(arr[0], length("gene_name=")+1)
    
    # Оставляем нужные столбцы
    print $1, $4, $5, $7, gene_name
}' /root/hw/gencode.v41.basic.annotation.gff3 > terminal_task/results/intermediate.tsv

# Модифицируем таблицу согласно условиям
awk '
BEGIN { FS="\t"; OFS="\t" }
{
    if ($4 == "+") {
        # Ген на плюсовой цепи
        start = $2
        end = $2 + 1
    } else {
        # Ген на минусовой цепи
        start = $3
        end = $3 + 1
    }
    print $1, start, end, $4, $5
}' terminal_task/results/intermediate.tsv > terminal_task/results/result.tsv

# Удаляем промежуточный файл
rm terminal_task/results/intermediate.tsv
