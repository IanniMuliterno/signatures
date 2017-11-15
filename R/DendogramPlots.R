###################################################################################
# DendogramPlots.R 
# Extensive Polar Dendogram plots using Information 
# and complexity measures as descriptors
#
# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3
##############################################################################################################################################



###################################################################################
# Adapting the plot to polar Dendogram using (ape) package
# data=data
# k=classes
# dlabel = distance labels to circul
# ... Adittional parameteres

MyPolarDendrograma=function(data=data, k=3, dlabel=0.007, ...){
  require(ape)
  require(colorspace) 
  require(dendextend)
  require(plotrix)
  
  set.seed(47)
  
  n = dim(data)[1]
  
  mypal = sample(rainbow(n), k)
  
  D.E = dist(data, ...)
  H.E = hclust(D.E)
  dend.E <- as.dendrogram(H.E, hang=1)
  heightsd = get_branches_heights(dend.E, decreasing = TRUE)
  
  clusk = cutree(H.E, k)
  
  plot(as.phylo(H.E), type = "fan", node.pos = c(0,0),
       tip.color = mypal[clusk], show.node.label = TRUE, 
       srt=50, root.edge=FALSE, rotate.tree = 15, #node.pos=TRUE,
       label.offset = dlabel, cex = 0.9, edge.color="blue", edge.lty=1, #1:3,
       edge.width = 1, adj=0.5, font=1, no.margin =TRUE, open.angle=20, underscore=TRUE)
  
  #  temp=as.matrix(heightsd[1:k+2])
  # apply(temp, 1, draw.circle, x=0,y=0, nv=1000,border="red" ,col=NA,lty=3,lwd=1)
  
  r0 = sum(range(heightsd))/2
  
 # segments(x0 = -r0, y0 = 0, x1 = r0, y1 = 0, col = "black", lwd=1, lty=2) 
  # segments(y0 = -r0, x0 = 0, y1 = r0, x1 = 0, col = "black", lwd=1, lty=2) 
  
  draw.circle(x=0,y=0, r0, nv=1000,border="red" ,col=NA,lty=3,lwd=1)
  draw.circle(x=0,y=0, r0*0.75, nv=1000,border="red" ,col=NA,lty=3,lwd=1)
  draw.circle(x=0,y=0, r0*0.5, nv=1000,border="red" ,col=NA,lty=3,lwd=1) 
  draw.circle(x=0,y=0, r0*0.25, nv=1000,border="red" ,col=NA,lty=3,lwd=1)
  
  text((r0)     , 0, " 0%", cex = 0.8)
  text((r0*0.75), 0, " 25%", cex = 0.8)
  text((r0*0.5) , 0, " 50%", cex = 0.8)
  text((r0*0.25), 0, " 75%",cex = 0.8)
}
###################################################################################

###################################################################################
# Read the data  set of descriptors using MCYT data set

# labels of data set signature
labname = c("FILE","Hx","SDHx", "Cx","SDCx","Fx","SDFx","Hy","SDHy", "Cy","SDCy","Fy","SDFy", "JSx", "JSy", "JFx", "JFy")
colclas = c("integer", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")

# load the data
dados = read.table("../DataSet/Quantifiers/QuantifiersAllSignatures.txt", header =FALSE, col.names = labname, colClasses = colclas)
###################################################################################

# NOTE: Here all dendrograms as construted by usin the euclidean distance

#--------------------------------------
# Entropy measures
dadoE = dados[,c(2,3,8,9)]

postscript("DendogramEntropy.eps")
  MyPolarDendrograma(data=dadoE)
dev.off()
#--------------------------------------

#--------------------------------------
#  Complexity measures
dadoC = dados[,c(4,5,10,11)]

postscript("DendogramComplexity.eps")
MyPolarDendrograma(data=dadoC, dlabel = 0.005)
dev.off()
#--------------------------------------

#--------------------------------------
# Fisher measures
dadoF = dados[,c(6,7,12,13)]

postscript("DendogramFisher.eps")
MyPolarDendrograma(data=dadoF, dlabel = 0.003)
dev.off()
#--------------------------------------

#--------------------------------------
# Entropy + Fisher
dadoEF = dados[,c(2,3,8,9,6,7,12,13)]

postscript("DendogramEntropyFisher.eps")
MyPolarDendrograma(data=dadoEF, dlabel = 0.003)
dev.off()
#--------------------------------------


#--------------------------------------
# Jensen Shanon
dadoJS = dados[,c(14,15)]

postscript("DendogramJensenShanon.eps")
MyPolarDendrograma(data=dadoJS, dlabel = 0.0002)
dev.off()
#--------------------------------------

#--------------------------------------
# Jensen + Fisher
dadoJF = dados[,c(16,17)]

postscript("DendogramJensenFisher.eps")
MyPolarDendrograma(data=dadoJF, dlabel = 0.001)
dev.off()
#--------------------------------------

#--------------------------------------
# Jensen Fisher  + Jensen Shannon
 dadoJF1 = dados[,c(14,15,16,17)]

postscript("DendogramJensenFisherJensenShannon.eps")
MyPolarDendrograma(data=dadoJF, dlabel = 0.001)
dev.off()
#--------------------------------------

