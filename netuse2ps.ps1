net use > .\temp.txt ; get-content .\temp.txt | select -Skip 3 | set-content .\temp2.txt | move .\temp2.txt .\temp.txt | import-csv .\temp2.txt -delimiter " " | Export-Csv -path .\temp.csv
