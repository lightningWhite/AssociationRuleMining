
# Install this for the first time running
#install.packages('arules');

# Get the apriori rules package
library(arules);

# Use the Groceries dataset
data(Groceries);

#summary(Groceries)

bestSupport = 0;
bestConfidence = 0;
bestLift = 0;

count = 0;

# Apply a grid-search to find the best support and confidence values for the best lift
for(Support in c(0.001, 0.003, 0.005, 0.007, 0.009, 0.02, 0.03)) {
  for (Confidence in c(0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 0.8)){
    myRules <- apriori(data=Groceries, parameter = list(support=0.006, confidence=0.4, minlen=3))

    summary(myRules)
    
    print("----------------------------------------")
    
    lift <- inspect(sort(myRules, by = "lift")[1])
    
    if (lift["lift"] > bestLift)
    {
      bestLift <- lift["lift"];
      bestSupport = Support;
      bestConfidence = Confidence;
    }
    print("Count: ")
    print(count)
    count = count+1;
  }
}

print("BEST LIFT:")
print(bestLift)

print("BEST CONFIDENCE:")
print(bestConfidence)

print("BEST SUPPORT:")
print(bestSupport)

