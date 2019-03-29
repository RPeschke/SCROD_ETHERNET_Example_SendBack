import csv
with open('py_scripts/data.csv', newline='') as csvfile:
    inDAtaSize = len(csvfile.readlines())

with open('py_scripts/data.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    print(inDAtaSize)
    for row in reader:
        print(row['data_0'], row['data_1'])