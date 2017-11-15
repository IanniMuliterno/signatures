##############################################################################################################################################
# ContourSignatures.R
#
# Contour Plots builted in GGPLOT
# Informatio theory quantifiers
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

 colclas = c("character", "integer", "integer", "integer","integer", "numeric", "numeric", "numeric", "integer", "numeric","numeric", "numeric")

# load the data
dados = read.table(".../DataSet/Quantifiers/QuantifiersAllSignatures/QuantifiersAllSignatures.txt", header =FALSE, col.names = labname, colClasses = colclas)

# Rename the labels Signature
dados$SIGNATURE[dados$SIGNATURE==0] <- "\n Genuine signature \n"
dados$SIGNATURE[dados$SIGNATURE==1] <- "\n Forgery signature \n"

dados$SIGNATURE = ordered(dados$SIGNATURE , levels= c("\n Genuine signature \n","\n Forgery signature \n" ))



library(ggplot2)
library(gridExtra)

# Cool summary for the paper
source("SummarySE.R")




##############################################################################################################################################
# Entropy

p <- ggplot(dados , aes(x = HHH.X, y= HHH.Y, group = factor(SIGNATURE))) 
p <- p+geom_point(
  aes(color=factor(SIGNATURE)), 
  alpha=0.6, size=6.5, shape=1) + facet_wrap(~SIGNATURE)
p <- p+stat_density2d(geom="density2d", alpha=0.8, size=0.8, contour=TRUE, color="grey24") 


p=p+scale_shape_manual(values=c(0, 1), guide="none")
p=p+scale_color_manual(values=c( "dodgerblue", "red"), name="Signatures", labels=c("Forgery", "Genuine") ) 


p=p+theme(
  legend.key = element_rect(colour = "white", 
                            fill = "white"),
  legend.key.size = unit(1.1, "cm"),
  legend.text = element_text(face = "italic", 
                             size=22),
  legend.title = element_text(size=15, face="bold"),
  panel.grid.major = element_line(colour = "gray", 
                                  linetype = "dotted"),
  # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
  panel.background = element_rect(fill = "white", 
                                  colour="black"),
  strip.text.x = element_text(size=22, 
                              hjust=0.5, 
                              vjust=0.5,
                              face="bold", lineheight = 0.5),
  strip.background = element_rect(colour="black", fill="gray87"),
  axis.text=element_text(size=22, face="bold", colour="gray24"),
  axis.title=element_text(size=22,face="bold"),
  panel.margin=unit(1 , "lines")
  
) 


p1 <- p + theme(legend.position = "none") + labs( x = "\n Entropy of X(t)", y = "Entropy of Y(t) \n") + guides(color=TRUE) #+  theme_bw()

p1 <- p1+ylim(0.1,0.7) + xlim(0.1,0.7)

# To save in eps using the powerful CAIRO package
cairo_ps(file='ContourEntropy.eps', width=15, height = 8)
# To save in pdf format
#pdf('ContourEntropy.pdf', width=15, height = 8)
p1
dev.off()

##############################################################################################################################################

##############################################################################################################################################

#Complexity


p <- ggplot(dados , aes(x = CCC.X, y= CCC.Y, group = factor(SIGNATURE))) 
p <- p+geom_point(
  aes(color=factor(SIGNATURE)), 
  alpha=0.6, size=6.5, shape=1) + facet_wrap(~SIGNATURE)
p <- p+stat_density2d(geom="density2d", alpha=0.8, size=0.8, contour=TRUE, color="grey24") 


p=p+scale_shape_manual(values=c(0, 1), guide="none")
p=p+scale_color_manual(values=c( "dodgerblue", "red"), name="Signatures", labels=c("Forgery", "Genuine") ) 


p=p+theme(
  legend.key = element_rect(colour = "white", 
                            fill = "white"),
  legend.key.size = unit(1.1, "cm"),
  legend.text = element_text(face = "italic", 
                             size=22),
  legend.title = element_text(size=15, face="bold"),
  panel.grid.major = element_line(colour = "gray", 
                                  linetype = "dotted"),
  # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
  panel.background = element_rect(fill = "white", 
                                  colour="black"),
  strip.text.x = element_text(size=22, 
                              hjust=0.5, 
                              vjust=0.5,
                              face="bold", lineheight = 0.5),
  strip.background = element_rect(colour="black", fill="gray87"),
  axis.text=element_text(size=22, face="bold", colour="gray24"),
  axis.title=element_text(size=22,face="bold"),
  panel.margin=unit(1 , "lines")
  
) 


p1 <- p + theme(legend.position = "none") + labs( x = "\n Complexity of X(t)", y = "Complexity of Y(t) \n") + guides(color=TRUE) #+  theme_bw()

p1 <- p1+ylim(0.1,0.35) + xlim(0.1,0.35)

# To save in pdf format
#pdf('ContourComplexity.pdf', width=15, height = 8)

# To save in eps using the powerful CAIRO package
cairo_ps(file='ContourComplexity.eps', width=15, height = 8)
p1
dev.off()
##############################################################################################################################################


#############################################################################################################################################
#Fisher

p <- ggplot(dados , aes(x = FFF.X, y= FFF.Y, group = factor(SIGNATURE))) 
p <- p+geom_point(
  aes(color=factor(SIGNATURE)), 
  alpha=0.6, size=6.5, shape=1) + facet_wrap(~SIGNATURE)
p <- p+stat_density2d(geom="density2d", alpha=0.8, size=0.8, contour=TRUE, color="grey24") 


p=p+scale_shape_manual(values=c(0, 1), guide="none")
p=p+scale_color_manual(values=c( "dodgerblue", "red"), name="Signatures", labels=c("Forgery", "Genuine") ) 


p=p+theme(
  legend.key = element_rect(colour = "white", 
                            fill = "white"),
  legend.key.size = unit(1.1, "cm"),
  legend.text = element_text(face = "italic", 
                             size=22),
  legend.title = element_text(size=15, face="bold"),
  panel.grid.major = element_line(colour = "gray", 
                                  linetype = "dotted"),
  # panel.grid.minor = element_line(colour = "red", linetype = "dotted"),
  panel.background = element_rect(fill = "white", 
                                  colour="black"),
  strip.text.x = element_text(size=22, 
                              hjust=0.5, 
                              vjust=0.5,
                              face="bold", lineheight = 0.5),
  strip.background = element_rect(colour="black", fill="gray87"),
  axis.text=element_text(size=22, face="bold", colour="gray24"),
  axis.title=element_text(size=22,face="bold"),
  panel.margin=unit(1 , "lines")
  
) 


p1 <- p + theme(legend.position = "none") + labs( x = "\n Fisher Information of X(t)", y = "Fisher Information of Y(t) \n") + guides(color=TRUE) #+  theme_bw()

p1 <- p1+ylim(0.3,0.5) + xlim(0.3,0.5)

# To save in pdf format
#pdf('ContourFisher.pdf', width=15, height = 8)

# To save in pdf format
cairo_ps(file='ContourFisher.eps', width=15, height = 8)
p1
dev.off()
##############################################################################################################################################
