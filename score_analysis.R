#!/usr/bin/env Rscript
#import arguments 
args = commandArgs(trailingOnly=TRUE)

#planed usage
#scores_analysis.R -Print graphs(TRUE or FALSE) -Print recommended Parameters(TRUE or FALSE) -Location of scores file to import/wd -Project Name 
printgraphsT_F<-args[1]
printRecomPara<-args[2]
location<- args[3]
projectname<-args[4]

#set libraries
library(ggplot2)
#Import data
dataset <- read.csv("~/Documents/OneDrive/Antarctica Files/LS Project/runAssembly_opti/bunassemnly_opti/Mid_3_newbler_scores.txt")

#data<-read.csv(paste(location,projectname,"_newbler_scores.txt")

#set wd
setwd("~/Documents/OneDrive/Antarctica Files/LS Project/runAssembly_opti/bunassemnly_opti")

#setwd(location)

#MAKE GRAPHS for each parameter and each score
make_graphs<-function(dataset,size,projectname){
  ggplot(data=dataset, aes(x=dataset$Readlength,y=dataset[,5],group=dataset$Readlength))+
    geom_boxplot()+
    geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
    labs(title =paste("Readlength vs", names(dataset)[5]), 
         y= paste(names(dataset)[5],"(# of contigs)"), 
         x= "Readlength (# of bases)")+
    theme_bw()
  filename_x<-paste(projectname,"_Readlength","_",names(dataset)[5],".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)
  
  ggplot(data=dataset, aes(x=dataset$Overlap,y=dataset[,5],group=dataset$Overlap))+
    geom_boxplot()+
    geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
    labs(title =paste("Overlap vs", names(dataset)[5]), 
         y= paste(names(dataset)[5],"(# of contigs)"), 
         x= "Overlap (#  of bases)")+
    theme_bw()
  filename_x<-paste(projectname,"_Overlap","_",names(dataset)[5],".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)
  
  ggplot(data=dataset, aes(x=dataset$Id,y=dataset[,5],group=dataset$Id))+
    geom_boxplot()+
    geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
    labs(title =paste("Id% vs", names(dataset)[5]), 
         y= paste(names(dataset)[5],"(# of contigs)"), 
         x= "Id %")+
    theme_bw()
  filename_x<-paste(projectname,"_Id","_",names(dataset)[5],".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)
  
for(i in 6:9){
ggplot(data=dataset, aes(x=dataset$Readlength,y=dataset[,i],group=dataset$Readlength))+
  geom_boxplot()+
    geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
    labs(title =paste("Readlength vs", names(dataset[i])), 
         y= paste(names(dataset[i]),"(# of bases)"), 
         x= "Readlength (# of bases)")+
  theme_bw()
  filename_x<-paste(projectname,"_Readlength","_",names(dataset[i]),".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)

ggplot(data=dataset, aes(x=dataset$Overlap,y=dataset[,i],group=dataset$Overlap))+
  geom_boxplot()+
  geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
  labs(title =paste("Overlap vs", names(dataset[i])), 
       y= paste(names(dataset[i]),"(# of bases)"), 
       x= "Overlap (#  of bases)")+
  theme_bw()
  filename_x<-paste(projectname,"_Overlap","_",names(dataset[i]),".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)

ggplot(data=dataset, aes(x=dataset$Id,y=dataset[,i],group=dataset$Id))+
  geom_boxplot()+
  geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
  labs(title =paste("Id % vs", names(dataset[i])), 
       y= paste(names(dataset[i]),"(# of bases)"), 
       x= "Id %")+
  theme_bw()
  filename_x<-paste(projectname,"_Id","_",names(dataset[i]),".png")
  filename_x<-gsub("\\s", "",filename_x)
  ggsave(filename=filename_x, width = size, height = size)
}
}

#Test variables 
printgraphsT_F=TRUE
projectname<-"Mid3"
#End of test variables

if (printgraphsT_F==TRUE){
make_graphs(dataset,5,projectname)
}

if(printRecomPara==TRUE){
  #FIGURE THIS OUT 
}

#Summary Stats
stats_summary<-summary(dataset[,5:9])

min_numberOfContigs_parameters<-which(dataset$numberOfContigs==min(dataset$numberOfContigs))
max_numberOfBases_parameters<-which(dataset$numberOfBases==max(dataset$numberOfBases))
max_avgContigSize_parameters<-which(dataset$avgContigSize==max(dataset$avgContigSize))
max_N50ContigSize_parameters<-which(dataset$N50ContigSize==max(dataset$N50ContigSize))
max_largestContigSize_parameters<-which(dataset$largestContigSize==max(dataset$largestContigSize))

line1<-paste("Based on lowest number of contigs use:","\n",
      dataset[min_numberOfContigs_parameters,1:4],"\n")
line2<-paste("Based on largest number of total bases use:","\n",
      dataset[max_numberOfBases_parameters,1:4],"\n")
line3<-paste("Based on largest N50ContigSize use:","\n",
      dataset[max_N50ContigSize_parameters,1:4],"\n")
line4<-paste("Based on the size of the largestContigSize:","\n",
      dataset[max_largestContigSize_parameters,1:4],"\n")
line5<-paste("Based on",projectname,"_newbler_scores.txt","...","\n", "Here are the recommended paramater groups for each score")

lines_to_write<-c(line5,line1,line2,line3,line4)
fileConn<-file(paste(projectname,"_newbler_scores_Analysis_report.txt"))
writeLines(lines_to_write, fileConn)
close(fileConn)

ggplot(data=dataset, aes(x=dataset$Overlap,y=dataset[,5],group=dataset$Overlap))+
  geom_boxplot()+
  geom_smooth(method = "lm", se=FALSE, color="red", aes(group=1))+
  
  #geom_smooth(method = "glm", se=FALSE, color="red", aes(group=1))+
  labs(title =paste("Overlap vs", names(dataset)[5]), 
       y= paste(names(dataset)[5],"(# of contigs)"), 
       x= "Overlap (#  of bases)")+
  theme_bw()


