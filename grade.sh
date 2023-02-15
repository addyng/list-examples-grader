CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cp student-submission/ListExamples.java ./

if [[ -f ListExamples.java ]]
then
    echo "ListExamples found"
else
    echo "need file ListExamples.java"
    exit 1
fi

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java

if [[ $? -eq 0 ]]
then
    echo "Files Compiles"
else
    echo "Files don't compile"
    exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > testResults.txt

if [[ $? -eq 1 ]]
then
    echo "At least one fail found - Grade: FAIL"
else
    echo "All tests passed - Grade: PASS!"
fi
grep "Tests run: *" testResults.txt

rm ListExamples.java testResults.txt ListExamples.class 