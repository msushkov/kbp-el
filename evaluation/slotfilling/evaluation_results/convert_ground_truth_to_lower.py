input_filename = "2010.tab"
output_filename = "2010.tab.lower"

output_file = open(output_filename, 'w')
input_file = open(input_filename)

for line in input_file:
        vals = line.split('\t')

        # vals[7], vals[8] need to be lowercased
        vals[7] = vals[7].lower()
        vals[8] = vals[8].lower()

        result = '\t'.join(vals)

        output_file.write(result)

input_file.close()
output_file.close()