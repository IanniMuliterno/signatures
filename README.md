## Classification and Verification of Online Handwritten Signatures with Time Causal Information Theory Quantifiers

</br>

#### Osvaldo A. Rosso, Raydonal Ospina and Alejandro C. Frery

</br>



---
### Abstract
We present a new approach for online handwritten signature classification and verification based on  descriptors stemming from Information Theory.

The proposal uses the Shannon Entropy, the Statistical Complexity, and the Fisher Information evaluated over the Bandt and Pompe symbolization of the horizontal and vertical coordinates of signatures.

These six features are easy and fast to compute, and they are the input to an One-Class Support Vector Machine classifier.
The results produced surpass state-of-the-art techniques that employ higher-dimensional feature spaces which often require specialized software and hardware.

We assess the consistency of our proposal with respect to the size of the training sample, and we also use it to classify the signatures into meaningful groups.


### Information

- Subbmitted to PLOS ONE <http://pone.edmgr.com/>. 
- PONE-D-16-02388
- Title: Classification and Verification of Online Handwritten Signatures with Time Causal Information Theory Quantifiers. 
- Download: <a href= "Docs/classification-verification-online.pdf"> pdf  </a>



## Reproducible information on paper

### Data sets

#### - *Original Data Set*
The Biometrics Research Lab (ATVS), Universidad Aut́onoma de Madrid, provided the MCYT-100 signature corpus employed in this work. we used a subset of the database, denominated MCYT-100, which includes 100 subjects and for each one, 25 genuine and 25 skilled forged signatures, and only the corresponding time series corresponding to the x- and
y-coordinates of each signature. All original coordinates of signatures are here. <a href= "DataSet/Original.tar.bz2"> Original Signatures.</a>

#### - *Smoothed Data Set*
The coordinates were re-scaled into the unit square [0, 1] × [0, 1] and taken as base these scaled values, the original total number of data for each time
series is expanded to M = 2000 points using a cubic Hermite polynomial. You can reproduce them by use the code <a href= "R/SmoothSignatures.R"> Smooth Signatures </a>

<!-- ### Section: Handwritten signatures database  --> 
### Figures
All image of signature can be obtained by the code <a href= "R/PlotSignature.R"> PlotSignature </a> and you can download them at <a href= "DataSet/PlotSignature.tar.bz2"> Data set of signature image. </a>

#### Figure 1.  
The Figuras are availavle at the links. Six different subjects signatures from the MCYT database. Two genuine signatures (left, blue) and a skilled forgery (right, red). The two first signatures were classified as <a href= "DataSet/PlotSignature/0021TRUE.png"> H1A </a>  and
<a href= "DataSet/PlotSignature/0038TRUE.png"> H1B </a>, 
the following two to types <a href= "DataSet/PlotSignature/0059TRUE.png"> H2B </a> and
<a href= "DataSet/PlotSignature/0005TRUE.png"> H1B, </a> and the last two to types 
<a href= "DataSet/PlotSignature/0097TRUE.png"> H3A </a> and
<a href= "DataSet/PlotSignature/0045TRUE.png"> H3B; </a> cf. Sec. Signatures classification.

#### Figure 2.
The Figure 2 was built manually by using <a href="http://www.originlab.com/2016">Origin</a>.

#### Figure 3.
The Theory information quantifiers data set to produce this image is available at <a href= "DataSet/Quantifiers/QuantifiersAllSignatures.txt"> Information Quantifiers. </a> 

The script to produce the Scatter plot with marginal kernel density estimates of each theory information quantifiers in both trajectory coordinates time series
X and Y is available at   <a href= "R/Histogram2DSignatures.R">Beautiful Scatter plot.</a> The Genuine (blue) and skilled forgery signatures (red points), 100 subjects. In the Figure the marginal kernel densities depict the distribution of each quantifiers along both axes. 

#### Figure 4.
The R script to produce the Contour plots superimposed on the scatterplot of each theory information quantifiers for genuine (right panel) and skilled forgery
signatures (left panel) is available at <a href= "R/ContourSugnatures.R">Contour plot.</a>

#### Figure 5.
The R script to produce the Neighbor-joining, rooted, circular dendrogram clustering of genuine signatures by each theory information quantifiers is available at <a href= "R/DendogramPlots.R">Circular dendrogram.</a> In plots H1, H2, and H3, in red,
blue, and green, respectively.


#### Figure 6.
The R script to produce the Classification by the rule of the parallelepiped of genuine signatures using each theory information quantifiers is available at <a href= "R/Parallelepiped.R">Parallelepiped clasifier.</a> 
</br>
The plot of classification by the rule of the parallelepiped of genuine signatures using Entropy (one signature example from each of the three groups is shown) can be downloaded in <a href= "R/ParallelepipedAnnotate.R">Parallelepiped Annotate.</a> Each subject is identified by its ID.


### Tables

Table 1. Sample mean and standard deviation (S.D.) of the time series quantifiers for the 25 genuine (G) and 25 skilled forged
(F) signatures, for each of the typical subjects: H1A, H1B, H2A, H2B, H3A, and H3B (same order as in Fig. 1).



<h3>Quasi-Offline signature verification</h3>
<p>Support Vector Machine (SVM) is a kernel-based classification method that is suitable to solving machine learning features problems even in very high dimensions, and its frequently used in pattern recognition applications <font color="purple">[R1]-[R3] </font> In a standard two-class classification problem, the SVM method is based on the training data that are first mapped into a higher dimensional feature space through a nonlinear feature mapping function $\Phi(\mathbf{x})$, and then a standard optimization method is used to find the optimal boundary function decision by maximizing the separating margin of two classes in this feature space while minimizing the training errors. As the training of a SVM involves a quadratic programming problem, the computational complexity of SVM training algorithms is usually intensive: at least quadratic with respect to the number of training examples <font color="purple">[R3] </font>. Once the decision function is determined from the training data, it can be used to predict the class label of a new test data.</p>
<p>In contrast with normal two-class classification problems, the one-class SVM (OC-SVM) classifier estimates the support of a distribution by identifying regions in the input space where most of the cases lie. It does this by nonlinearly projecting the data into a feature space, and there separating the data by the largest possible margin.</p>
<p>The signature verification problem can be tackled by SVMs, reminding that the target class, i.e. genuine signatures, is well-sampled, whereas the other class, referred to as outlier class (forgery signatures), is severely undersampled. The small number of examples from the outlier class is due to the fact that it is too difficult or expensive to obtain a significant number of training patterns of this class. More details on OC-SVM are given in Supplementary Information.</p>
<p>The performance of proposed verification system for different number of training per user derived from MCYT-100 dataset is evaluated. For each user, a random sample of size $n$ $(n=5, 10, 14, 18, 22)$ of genuine signatures was selected from the test database. For each sample signatures, the values of the features based on Information Theory quantifiers (Entropy, Complexity and Fisher Information) for each coordinates time series <strong>X</strong> and <strong>Y</strong> were calculated. These feature vectors $\mathbf{x}$ are then evaluated with the corresponding trained OC-SVM model and thus, the boundary function decision $\Phi(\mathbf{x})$ is obtained. Now, for each user, the sample signatures were now discarded and the remaining of signatures in the database were tested as follow. For each test signature, a vector of values of features was computed and evaluated in the boundary function decision. The absolute value of $\Phi(\mathbf{x})$ is proportional to the distance of  $\Phi(\mathbf{x})$ from the discriminatory line that distinguishes outliers from regular data. Large negative values correspond to outliers (forgery signatures) far away from the rest of the data; large positive values correspond to points that are, in some sense,``very regular’’ (genuine signature). The OC-SVM is trained using the radial basis function (RBF) kernel. The parameter $\nu$ is set to the default value of <span class="math inline">\(\nu =0.1\)</span>, which indicates that 10% of the positive class (genuine signatures) feature vectors (Information theory quantifiers) are treated as outliers. Parameter $\sigma=0.0$ was selected in the 5-fold-cross validation process.</p>
The <b>K-fold cross validation</b> (5 in our case) is one way to improve over the holdout method. The data set is divided into <i>k</i> subsets, and the holdout method is repeated <i>k</i> times. Each time, one of the <i>k</i> subsets is used as the test set and the other <i>k-1</i> subsets are put together to form a training set. Then the average error across all <i>k</i> trials is computed. The advantage of this method is that it matters less how the data gets divided. Every data point gets to be in a test set exactly once, and gets to be in a training set <i>k-1</i> times. The variance of the resulting estimate is reduced as <i>k</i> is increased.
</p>
<p>In this work we use the <code>R</code> interface to <code>libsvm</code> in package <code>e1071</code>. For further implementation details on <code>libsvm</code> see <font color="purple">[R3] </font>. The algorithm was executed on a machine <em>Intel Core I7-5500</em> under <em>Linux</em>. The Accurary (ACC), Area under the ROC curve (AUC) and Equal Error Rate (EER) are the indicators<font color="purple">[R5] </font>used to evaluate the performance in each scenary.</p>
<p>The next sample session is a classification a $\nu =0.1$ classification of signatures for a generic individual, using the radial basis function kernel with fixed hyper-parameters $\nu$ and $\sigma.$</p>


<div id="short-example.-how-manipulate-a-svm-in-r-with-the-package-e1071" class="section level4">
<h4>Short example. How manipulate a SVM in R with the package <code>e1071</code></h4>
<pre class="r"><code> # labels of data set signature
  labname = c(&quot;FILE&quot;,&quot;IFIRMVAL&quot;,&quot;NDATOS&quot;, &quot;D_e&quot;,&quot;X.MISS&quot;,&quot;HHH.X&quot;,&quot;CCC.X&quot;,
              &quot;FFF.X&quot;,&quot;Y.MISS&quot;,&quot;HHH.Y&quot;,&quot;CCC.Y&quot;,&quot;FFF.Y&quot;)
  colclas = c(&quot;character&quot;, &quot;integer&quot;, &quot;integer&quot;, &quot;integer&quot;, &quot;integer&quot;, 
              &quot;numeric&quot;, &quot;numeric&quot;, &quot;numeric&quot;,&quot;integer&quot;, &quot;numeric&quot;, &quot;numeric&quot;, &quot;numeric&quot;)
  
  
  # Load Data set for example set-0000-D5.txt (case 0 - Indivdual No.1 ), header =FALSE, col.names = labname, colClasses = colclas)
  DataFirma = read.table(paste(&quot;set-0000-D5.txt&quot;, file, sep =&quot;&quot;), 
                         header =FALSE, col.names = labname, colClasses = colclas)
  
  #Relabel data set
  DataFirma$IFIRMVAL[DataFirma$IFIRMVAL==0] &lt;- &quot;TRUE&quot;
  DataFirma$IFIRMVAL[DataFirma$IFIRMVAL==1] &lt;- &quot;FALSE&quot;
  
  # Training data set
  trainPositive &lt;- subset(DataFirma,IFIRMVAL==&quot;TRUE&quot;)
  testnegative  &lt;- subset(DataFirma,IFIRMVAL==&quot;FALSE&quot;)

  # Training data set sample size n=10 fo example
  inTrain.1 &lt;- sample(1:nrow(trainPositive), 10)

  ## Prepare a training and a test set ##
  trainpredictors.1 &lt;- trainPositive[inTrain.1, c(6,7,8,10,11,12)]
  
  # labels of trais predictor
  trainLabels.1 &lt;- trainPositive[inTrain.1, 2]
  testPositive.1 &lt;- trainPositive[-inTrain.1, ]
  
  testPosNeg.1 &lt;-rbind( testPositive.1, testnegative)
  testpredictors.1 &lt;- testPosNeg.1[, c(6,7,8,10,11,12)]
  testLabels.1 &lt;- testPosNeg.1[, 2]
  
  library(e1071)
   # Classifcacao svm one-class C with radial  
  # Train the SVM
  svm.model.1 &lt;- svm(trainpredictors.1, y=NULL, type='one-classification', 
                     nu=0.10, scale=TRUE, kernel=&quot;radial&quot;, gamma=0.05)
  
    # Prediction with SVM
     svm.predtrain.1 &lt;- predict(svm.model.1, trainpredictors.1)
     
    # Prediction test
    svm.predtest.1 &lt;- predict(svm.model.1, testpredictors.1, decision.values = TRUE)
  
    # Confusion Matrix 
    confTest.1 &lt;-table( Predicted = svm.predtest.1, Reference = testLabels.1)
   
    # Curva ROC
    svm.roc.1 &lt;- prediction(attributes(svm.predtest.1)$decision.values, testLabels.1)
    svm.auc.1 &lt;- performance(svm.roc.1, 'tpr', 'fpr')
  
   # AUC
   svm.auc.1 &lt;- performance(svm.roc.1, 'auc')@y.values
  
   # EER
   svm.err.1 &lt;- performance(svm.roc.1, 'err')@y.values</code></pre>
   </div>

<!--



When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
-->

<h2>References</h2>
<ol>
<li>
<font color="purple">[R1] </font>Campbell, C. &amp; Ying, Y, (2011). <em> Learning with Support Vector Machines.</em> Morgan and Claypool
</li>
<li>
<font color="purple">[R2] </font>Shawe-Taylor, J. &amp; Cristianini, N. (2004). <em>Kernel Methods for Pattern Analysis.</em> Cambridge University Press.
</li>
<li>
<font color="purple">[R3] </font>Vapnik, V.N. (1995). <em>The Nature of Statistical Learning Theory.</em> Springer, New York.
</li>
<li>
<font color="purple">[R4] </font>Chang, C.-C. &amp; Lin, C.-J.(2001). <em>LIBSVM: a library for support vector machines.</em> Software available at <a href="http://www.csie.ntu.edu.tw/~cjlin/libsvm" class="uri">http://www.csie.ntu.edu.tw/~cjlin/libsvm</a>, detailed documentation (algorithms, formulae, …) can be found in <a href="http://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.ps.gz" class="uri">http://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.ps.gz</a>,
</li>
<li>
<font color="purple">[R5] </font>Kohavi, R. &amp; Provost, F (1998). <em>On Applied Research in Machine Learning.</em> n Editorial for the Special Issue on Applications of Machine Learning and the Knowledge Discovery Process, Columbia University, New York.
</li>
</ol>

***
This is an R Markdown document produced by <a href="mailto:raydional@de.ufpe.br">Raydonal Ospina</a>. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.
