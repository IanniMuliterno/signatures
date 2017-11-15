###################################################################################
# ParallelepipedAnnotate.R 
#
# Classification by the rule of the parallelepiped of genuine signatures with s
# annotated signatures
#
#
# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3
##############################################################################################################################################


 
 # classification with signatures true
 
 # labels of data set signature
 labname = c("CLASS", "FIRMA","Hx","SDHx", "Cx","SDCx","Fx","SDFx","Hy","SDHy", "Cy","SDCy","Fy","SDFy", "JSx", "JSy", "JFx", "JFy")
 colclas = c("character", "integer", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")
 
 
 data <- read.table("../DataSet/Quantifiers/firmas-averages-classified.txt",  header =FALSE, col.names = labname, colClasses = colclas)
 #View(firmas.averages.classified)
 #str(data)
 
 library(ggplot2)
 library(gridExtra)
 library(MASS)
 source("SummarySE.R")
 
 
 library(png)
 library(grid)
 
 # Boxes com entropia
 # Summary
 
 # Boxes com entropia
 # Summary
 tg1 <- summarySE2(data, measurevar="Hx", groupvars=c("CLASS"))
 tg2 <- summarySE2(data, measurevar="Hy", groupvars=c("CLASS"))
 
 p <- ggplot(data , aes(x = Hx, y= Hy, group = factor(CLASS))) 
 # Cool summary for the paper
 
 
 p=p+annotate("rect", 
              xmin = signif(tg1$min[1], digits = 3),
              xmax = signif(tg1$max[1], digits = 3),  
              ymin = signif(tg2$min[1], digits = 3),
              ymax = signif(tg2$max[1], digits = 3),
              fill = NA, 
              #alpha = I(3/4),
              colour='red' 
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 
 
 p=p+annotate("rect", xmin = tg1$min[2], 
              xmax = tg1$max[2],   
              ymin = tg2$min[2], 
              ymax = tg2$max[2], 
              fill = NA, 
              #alpha = I(3/4),
              colour='red'
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 
 p=p+annotate("rect", xmin = tg1$min[3], 
              xmax = tg1$max[3],   
              ymin = tg2$min[3], 
              ymax = tg2$max[3], 
              fill = NA, 
              #alpha = I(3/4),
              colour='blue' 
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 p=p+annotate("rect", xmin = tg1$min[4], 
              xmax = tg1$max[4],   
              ymin = tg2$min[4], 
              ymax = tg2$max[4], 
              fill = NA, 
              #alpha = I(3/4),
              colour='blue' 
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 p=p+annotate("rect", xmin = tg1$min[5], 
              xmax = tg1$max[5],   
              ymin = tg2$min[5], 
              ymax = tg2$max[5], 
              fill = NA, 
              #alpha = I(3/4),
              colour='green'
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 p=p+annotate("rect", xmin = tg1$min[6], 
              xmax = tg1$max[6],   
              ymin = tg2$min[6], 
              ymax = tg2$max[6], 
              fill = NA, 
              #alpha = I(3/4),
              colour='green' 
              #arrow = arrow(length=unit(0.1,"cm"))
 )
 
 
 p <- p+geom_point(aes(color=factor(CLASS), 
                       shape=factor(CLASS)), alpha=0.3, size=17)   
 
 p <- p+geom_text(aes(label=FIRMA), size=6, face="plain") #, vjust=0)
 
 p=p+scale_shape_manual(values=rep(c(19,21),3), guide="none")
 p=p+scale_color_manual(values=(c('red3', 'red3', 
                                  'dodgerblue', 'dodgerblue', 
                                  'green', 'green')), name="Type") 
 
 p=p+theme (legend.key = element_rect(colour = "white", fill = "white"),
            legend.text = element_text(face = "plain", size=22),
            legend.key.size = unit(1.5, "cm"),
            legend.title = element_text(size=22),
            # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
            panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
            panel.background = element_rect(fill = "white", colour="black"),
            #axis.ticks.length = unit(0.001, "mm"),
            axis.title=element_text(size=22,face="bold"), 
            axis.title.y=element_text(hjust=0.5), 
            axis.title.x=element_text(vjust=0.5), 
            axis.text=element_text(size=22, face="bold", colour="gray24"),
            axis.ticks.margin = unit(0.45, "cm"),
            plot.margin = unit(c(1,1,1,1),units="lines"),
            legend.position = c(0.93, 0.17)
 ) 
 
 p <- p+guides(colour = guide_legend(override.aes = list(linetype=c(1,1)
                                                         , shape=c(19, 21))))
 
 
 
 p <- p+labs( x = "\n Entropy of X(t) ", y = "Entropy of Y(t) \n") 
 
 
 
 
 img1 <- readPNG("../DataSet/Fig6/0027TRUE.png")
 g1 <- rasterGrob(img1, interpolate=TRUE)
 
 img2 <- readPNG("../DataSet/Fig6/0095TRUE.png")
 g2 <- rasterGrob(img2, interpolate=TRUE)
 
 img3 <- readPNG("../DataSet/Fig6/0043TRUE.png")
 g3 <- rasterGrob(img3, interpolate=TRUE)
 
 
 p <- p+annotation_custom(g1, xmin=0.22, xmax=0.27, ymin=0.14, ymax=0.19) 
 
 p <- p+geom_segment(aes(x = 0.22, y = 0.161, xend = 0.17, yend = 0.161), 
                     arrow = arrow(length = unit(0.8, "cm"), angle=15), col="darkred")
 p <- p+annotate("text",x=0.25,y=0.145,label="S - 26",size=5, col='blue')
 #
 
 p <- p+annotation_custom(g2, xmin=0.14, xmax=0.19, ymin=0.22, ymax=0.27) 
 p <- p+geom_segment(aes(x = 0.17, y = 0.235, xend = 0.23, yend = 0.235), 
                     arrow = arrow(length = unit(0.8, "cm"), angle=15), col="darkblue")
 p <- p+annotate("text",x=0.15,y=0.228,label="S - 94",size=5, col='blue')
 
 
 p <- p+annotation_custom(g3, xmin=0.20, xmax=0.25, ymin=0.285, ymax=0.335) 
 p <- p+geom_segment(aes(x = 0.25, y = 0.325, xend = 0.3, yend = 0.325), 
                     arrow = arrow(length = unit(0.8, "cm"), angle=15), col="darkgreen")
 p <- p+annotate("text",x=0.225,y=0.33,label="S - 44",size=5, col='blue')
 
 # save in pdf
 #  pdf('ClassificationWithSignatureTrue.pdf', width=15, height = 15) 
 
 # Save in eps 
 cairo_ps(file='ClassificationWithSignatureTrue.eps', width=15, height = 15)
 p
 dev.off()
 