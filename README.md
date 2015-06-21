# Tidydata1
You can use run_analysis.R to automatically download biometric trackng data and perform an analysis on it, taking the average of all the variables that originally included mean or standard deviation.

The steps this script takes are as follows:

1. Get the data. It'll automatically download it if you don't already have it in your working directory.

2. Read in the training data and test data, and the column labels

3. Label the training and test data

4. Read in the subjects’ ids, and introduce a “subject_id” variable to keep track of them.

5. Read in and label the activity IDs

6. Merge the training and test data, then take only the mean and SD from them, thus reducing the columns from 561 to 81.

7. Takes the column means for all but subject and activity columns, and uses them to create the final tidy data set in a file called tidydata.txt in your working directory.
