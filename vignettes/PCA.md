
### Principal component analysis (PCA)

Visualize deviation of all bacteria from their population mean (smaller: blue; higher: red):


```r
# Let us focus on the most abundant and prevalent bacteria
# that are seen in >1% (>0.01) relative abundance in 
# >20% (>0.2) of the subjects
prevalent.taxa <- names(which(prevalence(t(rel), 0.01, sort = TRUE) > 0.2))

# Project data on 2D display with PCA (visualize subjects based on 20 random features)
set.seed(423542)
proj <- microbiome::project.data(log10(data[, prevalent.taxa]), type = "PCA")
```

```
## Error in data[, prevalent.taxa]: subscript out of bounds
```

```r
# Visualize
p <- densityplot(proj, col = meta$DNA_extraction_method, legend = T)
```

```
## Error in df[, 1]: object of type 'closure' is not subsettable
```

```r
print(p)
```

```
## Error in round(df$Correlation, 1): non-numeric argument to mathematical function
```

```r
# Now do the same with RBB extracted samples only
# Project data on 2D display with PCA (visualize subjects based on 20 random features)
set.seed(4235423)
proj <- microbiome::project.data(log10(data[rbb.samples, prevalent.taxa]), type = "PCA")
```

```
## Error in data[rbb.samples, prevalent.taxa]: subscript out of bounds
```

```r
# Visualize with DNA extraction method (now all samples have the same DNA extraction)
p <- densityplot(proj, col = meta[rbb.samples, "DNA_extraction_method"], legend = T)
```

```
## Error in df[, 1]: object of type 'closure' is not subsettable
```

```r
print(p)
```

```
## Error in round(df$Correlation, 1): non-numeric argument to mathematical function
```

```r
# Visualize with low/high Prevotella
# This shows that Prevotella (color) has ecosystem-level impact on microbiota composition
#high.prevotella <- log10(data[rbb.samples, "Prevotella.melaninogenica.et.rel."]) > 4
prevotella.abundance  <- log10(data[rbb.samples, "Prevotella.melaninogenica.et.rel."]) 
p <- densityplot(proj, col = prevotella.abundance, legend = T)
```

```
## Error in df[, 1]: object of type 'closure' is not subsettable
```

```r
print(p)
```

```
## Error in round(df$Correlation, 1): non-numeric argument to mathematical function
```


PCA with ggplot2 - the above example gives a shortcut for the following:


```r
# Arrange projected data onto a data frame
coms <- intersect(rownames(proj), rownames(meta))
df <- as.data.frame(cbind(proj[coms,], meta[coms,]))
```

```
## Error in as.data.frame(cbind(proj[coms, ], meta[coms, ])): error in evaluating the argument 'x' in selecting a method for function 'as.data.frame': Error in proj[coms, ] : object of type 'closure' is not subsettable
```

```r
names(df) <- c("x", "y", colnames(meta))

# Construct the figure with ggplot2
library(ggplot2)
theme_set(theme_bw(15))
p <- ggplot(df) 

# Add densities
p <- p + stat_density2d(aes(x = x, y = y, fill=..density..), geom="raster", stat_params = list(contour = F), geom_params = list()) 
p <- p + scale_fill_gradient(low="white", high="black") 

# Add points
p <- p + geom_point(aes(x = x, y = y, color = Sex), size = 1.5) 

# Add labels
p <- p + xlab("PCA 1") + ylab("PCA 2") + ggtitle("Density plot")
p <- p + scale_colour_discrete(name = "Sex")

# Plot the figure
print(p)
```

```
## Error: Continuous value supplied to discrete scale
```