##############################################################################################################################################
# Histogram2DSignatures.R 
#
# Histogram 2d Using GGPLOT
# complexity measures as descriptors
#
# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3
##############################################################################################################################################

##############################################################################################################################################
# Read the All data  set of descriptors using MCYT data set

# rename labels of data set (structure of data)
 labname = c("FILE","SIGNATURE","NDATOS", "D_e","X.MISS","HHH.X","CCC.X","FFF.X","Y.MISS","HHH.Y","CCC.Y","FFF.Y")
 
# colnames
 colclas = c("character", "integer", "integer", "integer","integer", "numeric", "numeric", "numeric", "integer", "numeric","numeric", "numeric")

# load the data - The data in site
dados = read.table("../DataSet/Quantifiers/QuantifiersAllSignatures.txt", header =FALSE, col.names = labname, colClasses = colclas)

# Load the 
library(ggplot2)
library(grid)
library(gridExtra)

# Cool summary for the paper
source("../R/SummarySE.R")


##############################################################################################################################################
# Entropy

# Scientific notation in labels
scientific_10 <- function(x) {
  parse(text=gsub("e", "%*%10^", scientific_format()(x)))
}


# Summary
tg1 <- summarySE2(dados, measurevar="HHH.X", groupvars=c("SIGNATURE"))
tg2 <- summarySE2(dados, measurevar="HHH.Y", groupvars=c("SIGNATURE"))


# Beautiful ggplot
p <- ggplot(dados , aes(x = HHH.X, y= HHH.Y, group = factor(SIGNATURE))) 
p <- p+geom_point(
  aes(color=factor(SIGNATURE), shape=factor(SIGNATURE)), alpha=0.4, size=3.0)   #+stat_density2d(linetype=1)

p=p+scale_shape_manual(values=c(0, 1), guide="none")

p=p+scale_color_manual(values=c( "blue", "red"), name="Signatures", labels=c("Genuine", " Forgery")) 

p=p+geom_errorbar(aes(x=tg1$mean[1], ymin=(tg1$mean[1]-tg1$sd[1]), ymax= (tg1$mean[1]+tg1$sd[1])), width=0.01, size=0.5, color="cyan")

p=p+geom_errorbar(aes(x=tg1$mean[2], ymin=(tg1$mean[2]-tg1$sd[2]), ymax= (tg1$mean[2]+tg1$sd[2])), width=0.01, size=0.5, color="orange")

p=p+geom_errorbarh(aes(y=tg2$mean[1], xmin=(tg2$mean[1]-tg2$sd[1]), xmax= (tg2$mean[1]+tg2$sd[1])), height=0.01, size=0.5, color="cyan") #+ coord_flip()

p=p+geom_errorbarh(aes(y=tg2$mean[2], xmin=(tg2$mean[2]-tg2$sd[2]), xmax= (tg2$mean[2]+tg2$sd[2])), height=0.01, size=0.5, color="orange")#+ coord_flip()

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
           plot.margin = unit(c(1,1,1,1.79),units="lines")
           ) 
#            ,
#            panel.border = element_rect(colour = "black")


# p1 <- p + theme(legend.position = "none") + labs( x = expression("Entropy of"~italic(X(t))), y = expression("Entropy of"~italic(Y(t)))) + guides(color=FALSE) #+  theme_bw()
p1 <- p + theme(legend.position = "none") + labs( x = "\n Entropy of X(t) ", y = "Entropy of Y(t) \n") + guides(color=FALSE) #+  theme_bw()

p1 <- p1+ylim(0.1,0.70) + xlim(0.1,0.70)#+scale_x_continuous(labels = scientific_10)+scale_y_continuous(labels = scientific_10)
#+scale_x_continuous(breaks=seq(0, 0.7, 0.05)) #+coord_cartesian(xlim(0,0.7))
#  p1 <- p1+scale_x_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  p1 <- p1+scale_y_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  

p2 <- ggplot(dados, aes(x=HHH.X, group=factor(SIGNATURE), colour=factor(SIGNATURE)))
p2 <- p2 +geom_line(stat="density", fill=NA, position="identity")
p2 <- p2 + theme(legend.position = "none", 
                # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white",  colour="black"),
                 axis.title=element_text(size=22,face="bold"),
                 axis.title.y=element_text(hjust=0.5), 
                 axis.title.x=element_text(vjust=0.5), 
                 axis.text=element_text(size=22, face="bold", colour="gray24"),
                 axis.ticks.margin = unit(0.45, "cm"), 
                 plot.margin = unit(c(1,1,1,1),units="lines"))+ 
  labs( x = "", y = "Density \n")+scale_y_continuous(breaks =c(0, 2.5, 5.0, 7.5, 10))
# , axis.title.x=element_blank(), 
#                  axis.text.x=element_blank(), panel.background = element_blank())

p2=p2+scale_color_manual(values=c( "blue", "red3"), guide="none")# + theme_bw()
p2=p2+xlim(0.1,0.70)#+ylim(0.0, 12.8)
#+scale_y_continuous(labels = scientific_10)

p3 <- ggplot(dados, aes(x=HHH.Y, group=factor(SIGNATURE), colour=factor(SIGNATURE)))

p3 <- p3+geom_line(stat="density", fill=NA, position="identity")+ coord_flip()

# p3 <- p3 + stat_density(fill = NA, position="dodge") + coord_flip()
p3 <- p3 + theme(legend.position = "none", 
                 axis.title.y=element_blank(), 
                 axis.text.y=element_blank(), 
                 #panel.background = element_blank(),
                # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white", colour="black"),
                axis.title=element_text(size=22,face="bold"),
                axis.title.y=element_text(hjust=0.5), 
                axis.title.x=element_text(vjust=0.5), 
                axis.text=element_text(size=22, face="bold", colour="gray24"),
                axis.ticks.margin = unit(0.45, "cm"), plot.margin = unit(c(1,1,1,1),units="lines")
#                  ,
#                  panel.border = element_rect(colour = "black")
)+ labs( x = "", y = "\n Density")

p3=p3+scale_color_manual(values=c( "blue", "red3"), guide="none")#+ theme_bw()
p3=p3+xlim(0.1,0.70)+scale_y_continuous(breaks =c(0, 2.5, 5.0, 7.5, 10))#+ylim(0.0,12.8)#+scale_x_continuous(labels = scientific_10)+scale_y_continuous(labels = scientific_10)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

legend <- g_legend(p)


# To save in pdf
# pdf('HistEntropy.pdf', width=14, height = 14)
# 
# grid.arrange(arrangeGrob(p2, legend, p1, p3, 
#                          widths=unit.c(unit(0.7,"npc"), unit(0.3, "npc")), 
#                          heights=unit.c(unit(0.31, "npc"), unit(0.69, "npc")), 
#                          nrow=2))
# dev.off()

# To save in eps using the powerful CAIRO package
cairo_ps(file='HistEntropy.eps', width=14, height = 14)

grid.arrange(arrangeGrob(p2, legend, p1, p3, 
                         widths=unit.c(unit(0.7,"npc"), unit(0.3, "npc")), 
                         heights=unit.c(unit(0.31, "npc"), unit(0.69, "npc")), 
                         nrow=2))
dev.off()

##############################################################################################################################################

##############################################################################################################################################
#Complexity

tg1 <- summarySE2(dados, measurevar="CCC.X", groupvars=c("SIGNATURE"))
tg2 <- summarySE2(dados, measurevar="CCC.Y", groupvars=c("SIGNATURE"))

p <- ggplot(dados , aes(x = CCC.X, y= CCC.Y, group = factor(SIGNATURE))) 
p <- p+geom_point(
  aes(color=factor(SIGNATURE), shape=factor(SIGNATURE)), alpha=0.4, size=3)   #+stat_density2d(linetype=1)

p=p+scale_shape_manual(values=c(0,1), guide="none")
p=p+scale_color_manual(values=c( "blue", "red"), name="Signatures", labels=c("Genuine", " Forgery") ) 

#p=p+geom_errorbar(aes(x=tg1$mean[1], ymin=(tg1$mean[1]-tg1$sd[1]), ymax= (tg1$mean[1]+tg1$sd[1])), width=0.05, size=0.5, color="blue")

p=p+geom_errorbar(aes(x=tg1$mean[1], ymin=(tg1$mean[1]-tg1$sd[1]), ymax= (tg1$mean[1]+tg1$sd[1])), width=0.01, size=0.5, color="cyan")

p=p+geom_errorbar(aes(x=tg1$mean[2], ymin=(tg1$mean[2]-tg1$sd[2]), ymax= (tg1$mean[2]+tg1$sd[2])), width=0.01, size=0.5, color="orange")

p=p+geom_errorbarh(aes(y=tg2$mean[1], xmin=(tg2$mean[1]-tg2$sd[1]), xmax= (tg2$mean[1]+tg2$sd[1])), height=0.01, size=0.5, color="cyan") #+ coord_flip()

p=p+geom_errorbarh(aes(y=tg2$mean[2], xmin=(tg2$mean[2]-tg2$sd[2]), xmax= (tg2$mean[2]+tg2$sd[2])), height=0.01, size=0.5, color="orange")#+ coord_flip()

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
           plot.margin = unit(c(1,1,1,1),units="lines")
) 

p1 <- p + theme(legend.position = "none") + labs( x = "\n Complexity of X(t) ", y = "Complexity of Y(t) \n") + guides(color=FALSE) #+  theme_bw()

p1 <- p1+ylim(0.1,0.35) + xlim(0.1,0.35)#+scale_x_continuous(breaks=seq(0, 0.7, 0.05)) #+coord_cartesian(xlim(0,0.7))
#  p1 <- p1+scale_x_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  p1 <- p1+scale_y_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  

p2 <- ggplot(dados, aes(x=CCC.X, group=factor(SIGNATURE), colour=factor(SIGNATURE)))

p2 <- p2 +geom_line(stat="density", fill=NA, position="identity")

p2 <- p2 + theme(legend.position = "none", 
                 # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white",  colour="black"),
                 axis.title=element_text(size=22,face="bold"),
                 axis.title.y=element_text(hjust=0.5), 
                 axis.title.x=element_text(vjust=0.5), 
                 axis.text=element_text(size=22, face="bold", colour="gray24"),
                 axis.ticks.margin = unit(0.45, "cm"), 
                 plot.margin = unit(c(1,1,1,1),units="lines")
)+ labs( x = "", y = "Density \n")+scale_y_continuous(breaks =c(0, 3.5, 7.0, 10.5, 14, 17.5))
#

p2=p2+scale_color_manual(values=c( "blue", "red3"), guide="none")# + theme_bw()
p2=p2+xlim(0.1,0.35)#+ylim(0, 18)

p3 <- ggplot(dados, aes(x=CCC.Y, group=factor(SIGNATURE), colour=factor(SIGNATURE)))

p3 <- p3+geom_line(stat="density", fill=NA, position="identity")+ coord_flip()

p3 <- p3 + theme(legend.position = "none", 
                 axis.title.y=element_blank(), 
                 axis.text.y=element_blank(), 
                 #panel.background = element_blank(),
                 # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white", colour="black"),
                 axis.title=element_text(size=22,face="bold"),
                 axis.title.y=element_text(hjust=0.5), 
                 axis.title.x=element_text(vjust=0.5), 
                 axis.text=element_text(size=22, face="bold", colour="gray24"),
                 axis.ticks.margin = unit(0.45, "cm"), plot.margin = unit(c(1,1,1,1),units="lines")
                 #                  ,
                 #                  panel.border = element_rect(colour = "black")
)+ labs( x = "", y = "\n Density")

p3=p3+scale_color_manual(values=c( "blue", "red3"), guide="none")#+ theme_bw()
p3=p3+xlim(0.1,0.35)+scale_y_continuous(breaks =c(0, 3.5, 7.0, 10.5, 14, 17.5))#+ylim(0.0,12.8)#+scale_x_continuous(labels = scientific_10)+scale_y_continuous(labels = scientific_10)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

legend <- g_legend(p)

# To save in pdf
# pdf('HistComplexity.pdf', width=14, height = 14)

# To save in eps using CAIRO package
cairo_ps(file='HistComplexity.eps', width=14, height = 14)
grid.arrange(arrangeGrob(p2, legend, p1, p3, 
                         widths=unit.c(unit(0.7,"npc"), unit(0.3, "npc")), 
                         heights=unit.c(unit(0.32, "npc"), unit(0.68, "npc")), 
                         nrow=2))
dev.off()

##############################################################################################################################################


#############################################################################################################################################
#Fisher

# Summary
tg1 <- summarySE2(dados, measurevar="FFF.X", groupvars=c("SIGNATURE"))
tg2 <- summarySE2(dados, measurevar="FFF.Y", groupvars=c("SIGNATURE"))

p <- ggplot(dados , aes(x = FFF.X, y= FFF.Y, group = factor(SIGNATURE))) 

p <- p+geom_point(
  aes(color=factor(SIGNATURE), shape=factor(SIGNATURE)), alpha=0.4, size=3)   #+stat_density2d(linetype=1)

p=p+scale_shape_manual(values=c(0, 1), guide="none")

p=p+scale_color_manual(values=c( "blue", "red"), name="Signatures", labels=c("Genuine", " Forgery") ) 

#p=p+geom_errorbar(aes(x=tg1$mean[1], ymin=(tg1$mean[1]-tg1$sd[1]), ymax= (tg1$mean[1]+tg1$sd[1])), width=0.05, size=0.5, color="blue")

p=p+geom_errorbar(aes(x=tg1$mean[1], ymin=(tg1$mean[1]-tg1$sd[1]), ymax= (tg1$mean[1]+tg1$sd[1])), width=0.01, size=0.5, color="cyan")

p=p+geom_errorbar(aes(x=tg1$mean[2], ymin=(tg1$mean[2]-tg1$sd[2]), ymax= (tg1$mean[2]+tg1$sd[2])), width=0.01, size=0.5, color="orange")

p=p+geom_errorbarh(aes(y=tg2$mean[1], xmin=(tg2$mean[1]-tg2$sd[1]), xmax= (tg2$mean[1]+tg2$sd[1])), height=0.01, size=0.5, color="cyan") #+ coord_flip()

p=p+geom_errorbarh(aes(y=tg2$mean[2], xmin=(tg2$mean[2]-tg2$sd[2]), xmax= (tg2$mean[2]+tg2$sd[2])), height=0.01, size=0.5, color="orange")#+ coord_flip()

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
           plot.margin = unit(c(1,1,1,1),units="lines")
) 

p1 <- p + theme(legend.position = "none") + labs( x = "\n Fisher Information of X(t) ", 
                                                  y = "Fisher Information of  Y(t) \n") + guides(color=FALSE) #+  theme_bw()

p1 <- p1+ylim(0.3,0.5) + xlim(0.3,0.5)#+scale_x_continuous(breaks=seq(0, 0.7, 0.05)) #+coord_cartesian(xlim(0,0.7))
#  p1 <- p1+scale_x_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  p1 <- p1+scale_y_continuous(minor_breaks = seq(0, 0.7, 0.1), breaks = seq(0, 0.7, 0.1))
#  

p2 <- ggplot(dados, aes(x=FFF.X, group=factor(SIGNATURE), colour=factor(SIGNATURE)))

p2 <- p2 +geom_line(stat="density", fill=NA, position="identity")

p2 <- p2 + theme(legend.position = "none", 
                 # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white",  colour="black"),
                 axis.title=element_text(size=22,face="bold"),
                 axis.title.y=element_text(hjust=0.5), 
                 axis.title.x=element_text(vjust=0.5), 
                 axis.text=element_text(size=22, face="bold", colour="gray24"),
                 axis.ticks.margin = unit(0.45, "cm"), 
                 plot.margin = unit(c(1,1,1,1),units="lines")
)+ labs( x = "", y = "Density \n")+scale_y_continuous(breaks =4.5*0:5)
#

p2=p2+scale_color_manual(values=c( "blue", "red3"), guide="none")# + theme_bw()
p2=p2+xlim(0.3,0.5)

p3 <- ggplot(dados, aes(x=FFF.Y, group=factor(SIGNATURE), colour=factor(SIGNATURE)))

p3 <- p3+geom_line(stat="density", fill=NA, position="identity")+ coord_flip()

# p3 <- p3 + stat_density(fill = NA, position="dodge") + coord_flip()
p3 <- p3 + theme(legend.position = "none", 
                 axis.title.y=element_blank(), 
                 axis.text.y=element_blank(), 
                 #panel.background = element_blank(),
                 # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
                 panel.grid.major = element_line(colour = "gray", linetype = "dotted"),
                 panel.background = element_rect(fill = "white", colour="black"),
                 axis.title=element_text(size=22,face="bold"),
                 axis.title.y=element_text(hjust=0.5), 
                 axis.title.x=element_text(vjust=0.5), 
                 axis.text=element_text(size=22, face="bold", colour="gray24"),
                 axis.ticks.margin = unit(0.45, "cm"), plot.margin = unit(c(1,1,1,1),units="lines")
                 #                  ,
                 #                  panel.border = element_rect(colour = "black")
)+ labs( x = "", y = "\n Density")

p3=p3+scale_color_manual(values=c( "blue", "red3"), guide="none")#+ theme_bw()
p3=p3+xlim(0.3,0.5)+scale_y_continuous(breaks =4.5*0:5)#+ylim(0.0,12.8)#+scale_x_continuous(labels = scientific_10)+scale_y_continuous(labels = scientific_10)

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

legend <- g_legend(p)

# To save in pdf
# pdf('HistFisher.pdf', width=14, height = 14)

# To save in eps using CAIRO
cairo_ps(file='HistFisher.eps', width=14, height = 14)

grid.arrange(arrangeGrob(p2, legend, p1, p3, 
                         widths=unit.c(unit(0.7,"npc"), unit(0.3, "npc")), 
                         heights=unit.c(unit(0.325, "npc"), unit(0.685, "npc")), 
                         nrow=2))
dev.off()

##############################################################################################################################################

