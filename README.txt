_______UCP______
How to run the code-
1. build the champsim by entering the following command:
   $ ./build_champsim.sh bimodal no no no no ucp 2
2. run the code by the command:
   $ ./run_4core.sh bimodal-no-no-no-no-ucp-2core 1 10 0 file1.trace.xz file2.trace.xz

Where file1 and file2 are trace files.

For granting permissions to build enter the below two commands:
1. chmod +x build_champsim.sh
2. sed -i -e 's/\r$/\n/' build_champsim.sh

For granting permissions to run enter the below two commands:
1. chmod +x run_4core.sh
2. sed -i -e 's/\r$/\n/' run_4core.sh

____partition for 2 core without adt_____
How to run the code-
1. build the champsim by entering the following command:
   $ ./build_champsim.sh bimodal no no no no myucp2 2
2. run the code by the command:
   $ ./run_4core.sh bimodal-no-no-no-no-myucp2-2core 1 10 0 file1.trace.xz file2.trace.xz

____partition for 4 core without adt_____
How to run the code-
1. build the champsim by entering the following command:
   $ ./build_champsim.sh bimodal no no no no myucp4 4
2. run the code by the command:
   $ ./run_4core.sh bimodal-no-no-no-no-myucp4-4core 1 10 0 file1.trace.xz file2.trace.xz file3.trace.xz file4.trace.xz


To implement UCP for two cores, we defined ADTs for two cores separately having 32 sample sets each.
We use SRRIP replacement policy in both LLC and 2 ADT's.
Based on number of hits for every possible partition ,we choose the partition having the maximum number of hits.

We have also implemented dynamic partitioning on 2 and 4 core by defining the partition after a particular interval ourselves in an array.

We have made changes in run_4core.sh file to run it for n=2,4,8 cores, and we created our replacement files ucp, myucp2, and myucp4 in replacement folder.
All result files are generated in results_4core_10M folder.
