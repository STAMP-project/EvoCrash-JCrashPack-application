# This class reads each of the crashes as an input from CSV file (input.csv)

import os
import csv
class Input():
    inputs_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)),"inputs")
    csv_filename = "one.csv"
    useful_indexes = [0,1,2,3,5,10,11,12,13,14,15]
    def fetchInputs(self):

        titles = []
        result = []
        csv_file = open(os.path.join(self.inputs_dir,self.csv_filename))
        reader = csv.reader(csv_file)
        row_counter = 0
        for row in reader:
            print (row_counter)
            if row_counter > 0:
                if row[3] != "":
                    input_args = {}
                    for v in self.useful_indexes:
                        input_args[titles[v]] = row[v]
                    result.append(input_args)


            else:
                titles = list(row)
            row_counter+=1
        return result