# per_plots
R scripts for plotting PER data.

# How to Use
```
Rscript per_plots.r
```

```
R
source("per_plots.r")
```

Put the .csv files in this directory. Run the script source("per_plots.r") and it will create the heat and line plots for each .csv file.
Make sure the format matches the example files. There should be a header row with columns for PER, Channel, and Power. 

# Install
You will have to have ggplot2 and reshape2 installed to execute the script. 
