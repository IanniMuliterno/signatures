# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3

# NOTE: Remember. The data are in site. Try to use the same addres.

# Fazer uma lista com os nomes de todas as pastas das firmas
dir_list <- dir('../DataSet/Smooth/')[file.info(dir('../DataSet/Smooth/',full.names=T))$isdir]

# Escolher unicamente as pastas das firmas - 
# Aqui aproveitamos que os numeros identificam as subpastas (100 em total)
dir_list = dir_list[1:100]

# Aqui graficos para cada individuo dos firmas verdaderas y una falsa
for (dir in dir_list){
  
  
  verde <-read.table(paste("../DataSet/Smooth/", dir, "/", dir, "v01New.txt", sep =""), header=FALSE)
  
  verde.1 <-read.table(paste("../DataSet/Smooth/", dir, "/", dir, "v02New.txt", sep =""), header=FALSE)
  
  rojo  <-read.table(paste("../DataSet/Smooth/", dir, "/", dir, "f01New.txt", sep =""), header=FALSE)
  
  #Salvar em formato eps
  # postscript(paste(dir, "TRUE", "eps", sep=""))
  
  #Salvar em formato PNG
  png(paste("../DataSet/Smooth/", dir, "TRUE", ".png", sep=""))
  
  par(mfrow=c(1,3), pty="s",mar=c(3.5,4.0,1.5,0.5), oma=c(0,0.5,0,0))
  plot(verde$V1, verde$V2, type="l", pch=16, main="", xlab=expression(italic(x(t))), ylab=expression(italic(y(t))), 
       cex=0.9, cex.axis=0.9, cex.main=0.9, col="blue")
  text(0.9, 0.05, "True", col="blue")
  points(verde$V1, verde$V2, type="p", pch=16, cex=0.2, col="blue")
  
  plot(verde.1$V1, verde.1$V2, type="l", pch=16, main="", xlab=expression(italic(x(t))), ylab=expression(italic(y(t))), 
       cex=0.9, cex.axis=0.9, cex.main=0.9, col="blue")
  text(0.9, 0.05, "True", col="blue")
  points(verde.1$V1, verde.1$V2, type="p", pch=16, cex=0.2, col="blue")
  
  plot(rojo$V1, rojo$V2, type="l", pch=16, main="", xlab=expression(italic(x(t))), 
       ylab=" ", cex=0.9, cex.axis=0.9, cex.main=0.9, col="red")
  points(rojo$V1, rojo$V2, type="p", pch=16, cex=0.2, col="red")
  text(0.9, 0.05, "False", col="red")
    dev.off()
}
