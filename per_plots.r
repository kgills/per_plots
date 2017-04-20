library(reshape2)
library(ggplot2)

# Search through all of the CSV files in the current directory 
file.names <- dir(getwd(), pattern =".csv")

for(i in 1:length(file.names)) {
    # Import the data
    per_data = read.csv(file.names[i], header=TRUE, comment.char="#")

    file_sub = tools::file_path_sans_ext(file.names[i])

    # Read the comments
    per_file = file(file.names[i], "r")
    comments = ""
    while(TRUE) {
        line = readLines(per_file, n=1)
        if(grepl(x = line, pattern = "#")) {
            line = sub(pattern="#", replacement="", x=line)
            comments = paste(comments, line, sep="\n")
        } else {
            break
        }
    }
    close(per_file)

    # Create the heat map
    heat_map<-ggplot(data=per_data, aes(x=Power, y=Channel, z=PER), xlab=seq(-10, -100), ylab=seq(0, 40))+
        geom_tile(aes(fill=PER)) +
        theme(panel.background=element_blank()) +
        scale_x_continuous(trans = "reverse", breaks=seq(0, -100, -10)) +
        scale_y_continuous(breaks=seq(0, 40, 5)) +
        geom_contour(colour="white", size=0.6, breaks=c(10)) +
        labs(x="Power dBm", y="Channel", subtitle=comments, title=paste(file_sub, "PER heat map", sep=" ")) +
        scale_fill_gradient2(low="dark green", mid="yellow", high="red", midpoint=17, limits=c(0,30), na.value="red")

    # Save the heat map
    png(filename=paste(file_sub ,"_heat",".png", sep=""), width=800, height=700)
    print(heat_map)
    dev.off()

    # Create the line plot
    line_plot<-ggplot(data=per_data, aes(x=Power, y=PER, linetype=factor(Channel), color=Channel))+
        geom_line() +
        scale_x_continuous(trans="reverse", breaks=seq(0, -100, -10)) +
        scale_y_continuous(breaks=seq(0, 50, 10), limits=c(0,50)) +
        geom_hline(yintercept=c(10,20,30), colour="red", linetype=2)+
        labs(x="Power dBm", y="PER", subtitle=comments, title=paste(file_sub, "PER scatter plot", sep=" ")) +
        theme(panel.background=element_blank(), legend.position='none')

    # Save the line plot
    png(filename=paste(file_sub,"_line",".png", sep=""), width=800, height=700)
    print(line_plot)
    dev.off()
}


