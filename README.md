# Simple-Compiler-using-Flex-and-Bison

# Feature of the Compiler project: 
1.	Header declaration 
2.	Variable declaration 
3.	Variable values assignment 
4.	Arithmetic Operations(addition, subtraction,multiplication,division) 
5.	If-else condition 
6.	For loop 
7.	While loop 
8.	Single line comment 
9.	Multiple lines comment 


# Sample Input : 

apurba std.h apurba math.h 
  main{ 
 
#@ Variable Declaration Part 
 
INTEGER a,b,c,i=1; 
 
#@ Assignment Part 
 	a=2;  	b=1;  	c=5; 
#@ If ElSE Part 
     IF b>c{       c+1;     }     ELSE{       c-1;     } 
 	 
#@ For loop Part  from 2 to 6 inc 1{     a+3    } 
    
#@ While loop Part      while b ++ < 5{       b+c    }  
 	 
#@ Arithmetic Operation Part      c=b+1;      b=c+a;      c=a*b;      a=c/b;      b=c-b;  
#@ Multiline Part 
 
 @@@ I am Apurba Dey. My Final examination is       knocking at the door.Try hard to do 
     something good.@@@ 



# Sample Output :
Header file found 
 
Header file found 
 
 	 	 Program Begins. 
 
 A Single Line Comment is Found.  
 a is declared   b is declared  c is declared   
i is declared with value :1 
 
A Single Line Comment is Found.  
 
2 is assigned to a 
 
1 is assigned to b 
 
5 is assigned to c 
 
 
 A Single Line Comment is Found.  
 
 
Value of expression in else block is 4.00 
 
 
A Single Line Comment is Found.  
 
Inside For loop.Value of expression: in 2th : 5.00 
 
Inside For loop.Value of expression: in 3th : 5.00 
 
Inside For loop.Value of expression: in 4th : 5.00 
 
Inside For loop.Value of expression: in 5th : 5.00 
 
Inside For loop.Value of expression: in 6th : 5.00 
 
 
 A Single Line Comment is Found.  
 
Inside while loop. 
Value of expression: 6.00 
 
Inside while loop. 
Value of expression: 6.00 
 
Inside while loop. 
Value of expression: 6.00 
 
Inside while loop. 
Value of expression: 6.00 
 
 
 A Single Line Comment is Found.  
 
2 is assigned to c 
 
4 is assigned to b 
 
8 is assigned to c 
2 is assigned to a 
 
4 is assigned to b 
 
 
 A Single Line Comment is Found.  
 
A Multi-line Comment is Found.  
 
 
   Program Ends 

     

