###################################################################################
# Parallelepiped.R 
#
# Classification by the rule of the parallelepiped of genuine signatures
#
#
# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3
##############################################################################################################################################


###### Dispersion with classification group entropy

# ### Original labels
# CLASS      firma        < H_x >     
#   SD-H_x  < C_x >  
#   SD-C_x                       < F_x >                        
#   SD-F_x                       < H_y >                        
#   SD-H_y                       < C_y >                        
#   SD-C_y                       < F_y >                        
#   SD-F_y                        
# Jensen-Shannon_x              Jensen-Shannon_y              
# Jensen-Fisher_x               Jensen-Fisher_y



# labels of data set signature
labname = c("CLASS", "FIRMA","Hx","SDHx", "Cx","SDCx","Fx","SDFx","Hy","SDHy", "Cy","SDCy","Fy","SDFy", "JSx", "JSy", "JFx", "JFy")
colclas = c("character", "integer", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")


data <- read.table("../DataSet/Quantifiers/firmas-averages-classified.txt",  header =FALSE, col.names = labname, colClasses = colclas)
#View(firmas.averages.classified)
str(data)
##############################################################################################################################################

##############################################################################################################################################
# Load packages

library(ggplot2)
library(gridExtra)
library(MASS)
source("SummarySE.R")

##############################################################################################################################################
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
                      shape=factor(CLASS)), alpha=0.5, size=10)   

p <- p+geom_text(aes(label=FIRMA), size=4) #, vjust=0)

p=p+scale_shape_manual(values=rep(c(19,21),3), guide="none")
p=p+scale_color_manual(values=(c('red', 'red3', 
                                 'blue', 'darkblue', 
                                 'green', 'darkgreen')), name="Type") 

p=p+theme (
          legend.key = element_rect(colour = "white", fill = "white"),
           legend.text = element_text( face = "italic", size=15),
           #legend.key.size = unit(1.1, "cm"),
           legend.title = element_text(size=15),
           # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
           panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
           panel.background = element_rect(fill = "white", colour="black")
#           axis.ticks.length = unit(0.001, "mm")
           ) 


p <- p+labs( x = expression("Entropy of"~italic(X(t))), 
        y = expression("Entropy of"~italic(Y(t)))) 

pdf('EntropyClasificationBoxesEntropy.pdf', width=20, height = 10)
p
dev.off()
##############################################################################################################################################


##############################################################################################################################################
# Boxes com complexity
# Summary
tg1 <- summarySE2(data, measurevar="Cx", groupvars=c("CLASS"))
tg2 <- summarySE2(data, measurevar="Cy", groupvars=c("CLASS"))

p <- ggplot(data , aes(x = Cx, y= Cy, group = factor(CLASS))) 
# Cool summary for the paper

p=p+annotate("rect", 
             xmin = tg1$min[1],
             xmax = tg1$max[1],  
             ymin = tg2$min[1],
             ymax = tg2$max[1],
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
                      shape=factor(CLASS)), alpha=0.5, size=10)   

p <- p+geom_text(aes(label=FIRMA), size=4) #, vjust=0)

p=p+scale_shape_manual(values=rep(c(19,21),3), guide="none")
p=p+scale_color_manual(values=(c('red', 'red3', 
                                 'blue', 'darkblue', 
                                 'green', 'darkgreen')), name="Type") 

p=p+theme (
  legend.key = element_rect(colour = "white", fill = "white"),
  legend.text = element_text( face = "italic", size=15),
  #legend.key.size = unit(1.1, "cm"),
  legend.title = element_text(size=15),
  # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
  panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
  panel.background = element_rect(fill = "white", colour="black")
  #           axis.ticks.length = unit(0.001, "mm")
) 


p <- p+labs( x = expression("Complexity of"~italic(X(t))), 
             y = expression("Complexity of"~italic(Y(t)))) 

pdf('EntropyClasificationBoxesComplexity.pdf', width=20, height = 10)
p
dev.off()

##############################################################################################################################################

##############################################################################################################################################

# Boxes com Fisher
# Summary
tg1 <- summarySE2(data, measurevar="Fx", groupvars=c("CLASS"))
tg2 <- summarySE2(data, measurevar="Fy", groupvars=c("CLASS"))

p <- ggplot(data , aes(x = Fx, y= Fy, group = factor(CLASS))) 
# Cool summary for the paper


p=p+annotate("rect", 
             xmin = tg1$min[1],
             xmax = tg1$max[1],  
             ymin = tg2$min[1],
             ymax = tg2$max[1],
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
                      shape=factor(CLASS)), alpha=0.5, size=10)   

p <- p+geom_text(aes(label=FIRMA), size=4) #, vjust=0)

p=p+scale_shape_manual(values=rep(c(19,21),3), guide="none")
p=p+scale_color_manual(values=(c('red', 'red3', 
                                 'blue', 'darkblue', 
                                 'green', 'darkgreen')), name="Type") 

p=p+theme (
  legend.key = element_rect(colour = "white", fill = "white"),
  legend.text = element_text( face = "italic", size=15),
  #legend.key.size = unit(1.1, "cm"),
  legend.title = element_text(size=15),
  # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
  panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
  panel.background = element_rect(fill = "white", colour="black")
  #           axis.ticks.length = unit(0.001, "mm")
) 


p <- p+labs( x = expression("Fisher Information of"~italic(X(t))), 
             y = expression("Fisher Information of"~italic(Y(t)))) 

pdf('EntropyClasificationBoxesFisher.pdf', width=20, height = 10)
p
dev.off()

##############################################################################################################################################


 
 # classification with signatures true
 
 # labels of data set signature
 labname = c("CLASS", "FIRMA","Hx","SDHx", "Cx","SDCx","Fx","SDFx","Hy","SDHy", "Cy","SDCy","Fy","SDFy", "JSx", "JSy", "JFx", "JFy")
 colclas = c("character", "integer", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")
 
 
 data <- read.table("../DataSet/firmas-averages-classified.txt",  header =FALSE, col.names = labname, colClasses = colclas)
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
 
 

  
#  tg1 <- summarySE2(data, measurevar="Hx", groupvars=c("CLASS"))
#  tg2 <- summarySE2(data, measurevar="Hy", groupvars=c("CLASS"))
 
 p <- ggplot(data , aes(x = Hx, y= Hy, group = factor(CLASS))) 
 
 p <- p+geom_point(aes(color=factor(CLASS), 
                       shape=factor(CLASS)), alpha=0.5, size=15)   
 
 p <- p+geom_text(aes(label=FIRMA), size=4) #, vjust=0)
 
 p=p+scale_shape_manual(values=rep(c(19,21),3), guide="none")
 p=p+scale_color_manual(values=(c('red', 'red', 
                                  'blue', 'blue', 
                                  'green', 'green')), name="Type") 
 
 
 
 
 
 img1 <- readPNG("Signature28.png")
 g1 <- rasterGrob(img1, interpolate=TRUE)
 
 img2 <- readPNG("Signature96.png")
 g2 <- rasterGrob(img2, interpolate=TRUE)
 
  img3 <- readPNG("Signature44.png")
 g3 <- rasterGrob(img3, interpolate=TRUE)
 
 
 p <- p+annotation_custom(g1, xmin=0.125, xmax=0.175, ymin=0.20, ymax=0.26) 

#  p <- p+geom_segment(aes(x = 0.124, y = 0.20, xend = 0.16, yend = 0.1527), 
#                   arrow = arrow(length = unit(0.01, "cm")))
#  
 p <- p+annotation_custom(g2, xmin=0.18, xmax=0.24, ymin=0.26, ymax=0.32) 
 
 p <- p+annotation_custom(g3, xmin=0.30, xmax=0.36, ymin=0.22, ymax=0.28) 
 
 
 p=p+theme (
   legend.key = element_rect(colour = "white", fill = "white"),
   legend.text = element_text( face = "italic", size=15),
   #legend.key.size = unit(1.1, "cm"),
   legend.title = element_text(size=15),
   # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
   panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
   panel.background = element_rect(fill = "white", colour="black")
   #           axis.ticks.length = unit(0.001, "mm")
 ) 
 
 
 p <- p+labs( x = expression("Entropy of"~italic(X(t))), 
              y = expression("Entropy of"~italic(Y(t)))) 

#  p
#  dev.off()
#  
 pdf('Clas.pdf', width=20, height = 10) 
p 
dev.off()

