# Author: Raydonal Ospina
# Date : January 2016
# Contact: raydonal@de.ufpe.br
# Version 1.0
# Licence GPL v3

# NOTE: Remember. The data are in site. Try to use the same addres.

# Fazer uma lista com os nomes de todas as pastas das firmas
dir_list <- dir('../DataSet/Original//')[file.info(dir('../DataSet/Original//',full.names=T))$isdir]

# Escolher unicamente as pastas das firmas - Aqui aproveitamos que os numeros identificam as subpastas (100 em total)
dir_list = dir_list[1:100]

# Percorrer as subpastas
for (dir in dir_list){
  
  # Fazer uma lista com os nomes de todas as firmas da subpasta. Exemplo \0000
  arquivos <-  list.files(dir) 

# lista de firmas originais formato .dat   
file_list <- arquivos[grep(".dat", arquivos, fixed=T)] #list.files()

for (file in file_list){
  # Exemplo para ver se roda
  
  # Leitura da base 
  temp_dataset <-read.table(paste("./", dir, "/", file, sep =""), header=FALSE, sep=",") #read.table(file, header=FALSE, sep=",")

    # Numero de pontos para amostragem igualmente espaçados
  n = 5000 
  
  
  # re-escaled the coordinate
  X = ( temp_dataset$V1-min(temp_dataset$V1) ) /(max(temp_dataset$V1)- min(temp_dataset$V1))
  
  Y = ( temp_dataset$V2-min(temp_dataset$V2) ) /(max(temp_dataset$V2)- min(temp_dataset$V2))
  
  
    a.x = min(X)
    b.x = max(X)

    a.y = min(Y)
    b.y = max(Y)

  # comprimento da serie original X
  len.x= length(X)
  
  # indice da serie original X
  index.x.or = seq(from = a.x, to = b.x, length.out = len.x)
  

  # Suavizamineto por polinomios de Hermite
  #ssx =  round(as.vector(fssx(index.x.new)), digits=4)
  ssx=spline(index.x.or, as.numeric(X), n=n)$y
  
  # comprimento da serie original X
  len.y= length(Y)
  
  # indice da serie original X
  index.y.or = seq(from = a.y, to = b.y, length.out = len.y)
  
  
  #serie suavizada com n pontos x
  #ssy =  round(as.vector(fssy(index.y.new)), digits=4)
  ssy=spline(index.y.or, as.numeric(Y), n=n)$y
  
  
  firma = cbind(ssx, ssy)
   
  m = substring(file, 1,7)
  
 # Salvando las firmas en nuevo formato para analisis
  write.table(format(firma, digits=13), file=paste("./", dir, "/", m,"New.txt", sep = ""),  quote=FALSE, row.names=FALSE, col.names=FALSE)
  
  }

}
