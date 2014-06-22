1. The code downloads the zipped file and unzips it in the working directory

2. The code then downloads all the relevant files from

	a. UCI HAR Dataset folder: Activity and Subject files

	b. test folder: Data and relevant files

	c. train folder: Data and relevant files

3. Merges the test and train dataset

4. Uses the feature file to assign column names to the merged dataset

5. Search for the columns with - mean and standard deviation. 
   Subsetting those columns to a new data frame

6. Combining Activity and Subject dataset. Merging it with the new data frame (with mean and standard deviation)

7. Melting the Subject and Activity columns. Then casting by using "mean" function

8. Writing the dataset into a text file in working directory
