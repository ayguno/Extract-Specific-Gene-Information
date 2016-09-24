
# This function is aimed to extract useful information (e.g: log2 expression values) for a selected group of proteins
# Multiple TMT10 experiments can be compared, experiments from different cell lines can be integrated
# "ModT test table results" printed by the Shiny server will be provided into the same working directory, along with the class vector files specific for each experiment (both in csv format)
# The function will take a customly prepared csv file as input, which matches the data tables with class vector files
# ModT_ClassV_match (chr) = csv table that matches ModT table file names (first column), with the respective Class vector files (second column), and cell line the experiment was carried out (third column) 
# idlist (chr) = list of Uniprot IDs that will be scanned from the data sets

extractPr<-function(ModT_ClassV_match, idlist) {
  
  require(gplots)
  require(RColorBrewer)
  
  
  mt<-read.csv(ModT_ClassV_match,header=TRUE) # Read the ModT_ClassV match table
  
  colnames(mt)<-c("ModT","ClassV","Experiment", "Cell")
  
  ID<-idlist
  
  IDtable<-data.frame(accession_number=ID)
  GS<-IDtable
                          n<-nrow(mt)
                          
                          for (i in 1:n) { #Loop over the experiments specified in the match table
                            
                            MT<-read.csv(file=as.character(mt$ModT[i]),header=TRUE) #Read the ModT results table for the experiment
                            ClV<-read.csv(file=as.character(mt$ClassV[i]),header=TRUE) #Read the Class Vector table for the experiment
                            Cell<-as.character(mt$Cell[i])
                            
                                                      
                            
                            
                            w<-which(MT$accession_number %in%  ID) # Find the rows in the MT that matches to ID list
                            
                            
                if (length(w)>0)            
                            
                          {  
                            MT<-MT[w,] # Get only those rows of the MT for further processing
                            
                            #Exract individual treatments from this experiment
                            
                            a<-1
                            n1<-nrow(ClV) 
                            
                            for(i in 1:n1){ #Loop over the individual treatments within each experiment
                              
                              
                                            Rep1<-which(colnames(MT)==paste(ClV[a,1])) #Extract relevant column indexes for log2 expression value of Rep1 of the specific treatment 
                                            Rep2<-which(colnames(MT)==paste(ClV[a+1,1]))
                                            
                                            REPtemp<-data.frame(MT[,"accession_number"],MT[,Rep1],MT[,Rep2]) 
                                            
                                            if(ncol(REPtemp)==3)
                                                     {colnames(REPtemp)<-c("accession_number",paste(Cell,ClV[a,2],"Rep1",sep="_"),paste(Cell,ClV[a,2],"Rep2",sep="_"))
                                            
                                                      GStemp<-data.frame(MT[,"accession_number"],MT[,"geneSymbol"])
                                                      colnames(GStemp)<-c("accession_number",paste((ncol(GS)+1)))
                                            
                                            
                                                      IDtable<-merge(IDtable,REPtemp,all.x=T, by.x="accession_number",by.y="accession_number")
                                                      GS<-merge(GS,GStemp,all.x=T, by.x="accession_number",by.y="accession_number")}
                                                      
                                            
                                            a<-a+2 #Move to the next treatment within the experiment, until no treatment left
                                            }   
                            
                          }               
                            
                            
                            #Move to the next experiment in the match table, until all of them completed               
                            
                }            
           

                          
  IDtable<-data.frame(geneSymbol=GS[,2],IDtable,check.names = F )                                        
  
  write.csv(file="Selected_list.csv", IDtable,row.names = F)                        
    
    ###Not complete yet!! Have to find a way to extract and merge gene symbols properly from GS otherwise log2 data compiles well.
    
           
}
                          
                          
                          
                          
                          