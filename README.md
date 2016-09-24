# Extract-Specific-Gene-Information
Helps to extract useful information (e.g: log2 expression values) for a selected group of proteins

Multiple TMT10 experiments can be compared, experiments from different cell lines can be integrated

"ModT test table results" printed by the Shiny server will be provided into the same working directory, along with the class vector files specific for each experiment (both in csv format)

The function will take a customly prepared csv file as input, which matches the data tables with class vector files
 
 ModT_ClassV_match (chr) = csv table that matches ModT table file names (first column), with the respective Class vector files (second column), and cell line the experiment was carried out (third column) 
 
 idlist (chr) = list of Uniprot IDs that will be scanned from the data sets
