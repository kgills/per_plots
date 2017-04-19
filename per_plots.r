library(reshape2)
library(ggplot2)

# Search through all of the CSV files in the current directory 
file.names <- dir(getwd(), pattern =".csv")

for(i in 1:length(file.names)) {
    # Import the data
    per_data = read.csv(file.names[i], header=TRUE)

    # Create the heat map
    heat_map<-ggplot(data=per_data, aes(x=Power, y=Channel), xlab=seq(-10, -100), ylab=seq(0, 40))+
        geom_tile(aes(fill=PER)) +
        theme(panel.background=element_blank()) +
        scale_x_continuous(trans = "reverse") +
        labs(x="Power dBm", y="Channel") +
        scale_fill_gradient(low="blue", high="red", limits=c(0, 100))

    # Save the heat map
    png(filename=paste(tools::file_path_sans_ext(file.names[i]),"_heat",".png", sep=""), width=640, height=500)
    print(heat_map)
    dev.off()

    # Create the line plot
    line_plot<-ggplot(data=per_data, aes(x=Power, y=PER, linetype=factor(Channel), color=Channel))+
        geom_line() +
        scale_x_continuous(trans = "reverse") +
        labs(x="Power dBm", y="PER") +
        theme(panel.background=element_blank(), legend.position='none')

    # Save the line plot
    png(filename=paste(tools::file_path_sans_ext(file.names[i]),"_line",".png", sep=""), width=640, height=500)
    print(line_plot)
    dev.off()
}


