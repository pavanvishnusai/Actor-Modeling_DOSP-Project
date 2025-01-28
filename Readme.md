\## Size of Work Unit
The size of the work unit refers to the number of sub-problems (or
sequences of numbers) a worker processes in a single request. In this
implementation, a worker computes the sum of squares for each starting
point up to (n_limit - k + 2). Each worker processes one sequence at a
time and reports the result back to the boss.
The total number of sequences processed is from 1 to n (1,000,000), but each 
core processes a portion of this, so each core is handling 125,000 sequences. 
The selected work unit size optimally balances
workload distribution and overhead management. Larger units increased
processing time due to communication delays, whereas smaller units
raised overhead without improving performance significantly.

We determined this optimal size through the following process:

Methodology: We experimented with varying the number of sequences each worker 
processed in a single request. By adjusting this work unit size, we aimed to 
balance the overhead of communication with parallel execution efficiency.
Performance Measurement: We used system time metrics to compare the performance 
across different work unit sizes, specifically focusing on real time and CPU time 
ratios.
Trade-offs Considered: Larger work units increased communication delays between 
the boss and workers, whereas smaller units increased overhead without significantly 
improving the overall runtime.

\## Result for lukas 1000000 4
There is no sequence printed for the values of lukas 1000000 4 and kept number of cores = 4.

(base) abhinavreddypannala@Abhinavs-MacBook-Air project1 % time ./project1 1000000 4

As a result No Sequence found

./project1 1000000 4  225.06s user 0.24s system 783% cpu 28.751 total

\## Running Time
We ran the program using the command:
For macOS - /usr/bin/time ./project1 1000000 4

For the command "time ./project1 1000000 4", the performance metrics
were recorded as follows:

CPU time: 225.30s

Real time: 28.751s

CPU time / Real time ratio: 7.84

The ratio of CPU time (User + Sys) to Real time is 7.84. This ratio indicates
that our implementation effectively utilized 8 cores for parallel computation.

\##Largest Problem Solved
The largest problem we managed to solve with our implementation was:

•⁠  ⁠Problem type: Vaild sequence: Start = 3
•⁠  ⁠Input size: [Lukas 100000000 2]
•⁠  ⁠Number of workers: 4

This demonstrates the scalability and efficiency of our pony-based parallel implementation.
When we use Number of workers = 8, the execution time of this code is more.

\## Additional Notes

How to run this program - 
Download the code.pony file in any directory

Commands on Mac - 
cd /path/of/your/downloaded/project1
ponyc
time ./project1 1000000 4

Challenges Faced - 
1. More execution time if we increase any one of these parameters n,k, and number of cores.
2. Error Handling and Debugging: Pony’s error handling relies heavily on the use of capabilities 
and type systems. Understanding how to use these capabilities correctly and debugging issues 
related to actor safety and reference capabilities can be a steep learning curve, especially if 
you're unfamiliar with these concepts.
3. Syntax and Structure Rigor: Pony has strict syntax requirements, and even small errors, like 
missing end keywords or incorrect indentation, can lead to compilation errors. Handling 
these issues without detailed error messages can be frustrating, especially for newcomers to the language.

\## Bonus 

We tried to implement sequence for n = 100000000 and k = 20 and number of cores = 4. 
There is no sequence printed for the values of lukas 100000000 20 and kept number of cores = 4.
./project1 100000000 20  266.25s user 0.21s system 398% cpu 1:06.89 total

Also tried for lukas 10000 20 no sequence found, also tried for lukas 1000000 20, no sequence found. 
