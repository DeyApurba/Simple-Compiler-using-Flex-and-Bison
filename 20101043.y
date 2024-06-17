%{
	#include<stdio.h>
	#include<conio.h>
	#include<string.h>
	#include<math.h>
	
	int yylex();
	int yyparse();
	int yyerror(char *s);
	
	#define YYDEBUG 1
	#define mx 1024
	
	char IDs[mx][mx];
	int type_ID[mx];
	int value_Int[mx];
	double value_Double[mx];
	char* value_String[mx];

	int IDCnt = 0;

	int check(char *s){
		for(int i=0;i<IDCnt;i++){
			if(strcmp(s,IDs[i])==0){
				return i;
			}
		}
		return -1;
	}
%}

%union{
	int integer;
	double floating;
	char* string;
}

%error-verbose
%debug

%token INT DOUBLE STRING MAIN END START ID T_INT  
%token WHILE FROM TO INC PRINT T_DOUBLE T_STRING 
%token INCREMENT DECREMENT FACT


%type <integer> INT MAIN END START program begin code INTID INT_ID DOUBLEID DOUBLE_ID CHAR_ID CHARID 
%type <string> ID T_INT T_DOUBLE T_STRING STRING
%type <floating> expression DOUBLE

%nonassoc IF then
%nonassoc ELSE

%left '<' '>' EQUAL NT_EQUAL LS_EQUAL GT_EQUAL 
%left INCREMENT DECREMENT
%left  '+' '-'
%left  '*' '/' '%'
%right  '^'
%%


program: MAIN START begin END	 {printf("\nProgram Ends \n\n");}
		;

begin:					{printf("\t\t Program Begins.\n\n");}	
		| begin code
		;

code:		';'			{}
		|	expression	';'	{}

		|	declaration_part ';'	{}	
        |   assignment_part {}               
        
                
		|	PRINT '(' ID ')' ';'	{
						  int indx = check($3);
						  if(indx==-1){
								printf("Not Found\n\n");
							    }
						     else{
							   if(type_ID[indx]==0){
								printf("%s Is an Integer Number .Value of %s is: %d\n\n",$3,$3,value_Int[indx]);
								  }
							  else if(type_ID[indx]==1){
							  printf("%s Is a Double type Number.Value of %s is: %.2lf\n\n",$3,$3,value_Double[indx]);
								}
							  else{
							  printf("%s Is a String.Value of %s is: %s\n\n",$3,$3,value_String[indx]);
								}
							}
						}

		|		FROM INT TO INT INC INT START expression END{
													for(int i=$2; i<=$4;i+=$6){
												printf("Inside For loop.Value of expression: in %dth : %.2lf\n\n",i,$8);
												}
											}

	

		|		IF expression START expression ';' END ELSE START expression ';' END	{
														if($2){
															printf("Value of expression in if block is %.2lf\n\n",$4);
														}
														else{
															printf("Value of expression in else block is %.2lf\n\n",$9);
														}
													}
		
		|		WHILE ID INCREMENT '<' INT START expression END {
													int ix = check($2);
													if(ix==-1 || type_ID[ix]>0){
															printf("Error in incrementing: non integer value.\n\n");
														}
													else{
														int val = value_Int[ix];
														while(val++<$5){
															printf("Inside while loop.\nValue of expression: %.2lf\n\n",$7);
														}
													}
												}
		
		|		WHILE ID DECREMENT '>' INT START expression END		{
														int ix = check($2);
														if(ix==-1 || type_ID[ix]>0){
															printf("Can't increment non integer value\n\n");
														}
														else{
															int val = value_Int[ix];
															while(val-->$5){
																printf("Inside while loop.\nValue of expression:%.2lf\n\n",$7);
															}
														}
													}
													
		
declaration_part:             
			 T_INT INTID    
			
			| T_DOUBLE DOUBLEID  
			
			| T_STRING CHARID    
			; 

INTID	:
			  INTID ',' INT_ID
			| INT_ID

INT_ID: 
			 ID '=' expression		   {                       
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_Int[ix] = (int)$3;
												type_ID[ix] = 0;
                                                                                                
                                                //printf("variable declaration_part.\n\n");
												if(value_Int[ix]>0){
												   printf("%s is declared with value :%d\n\n",$1,value_Int[ix]);
												}
												else{
												     printf("%s is declared \n\n",$1);
												 }
												
											}
											else{
												printf("%s is already Declared\n\n",$1);
											}
											
										}
										
			| ID 						{
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_Int[ix] = 0;
												type_ID[ix] = 0;
                                                
												if(value_Int[ix]>0){
												   printf("%s is declared with value :%d\n\n",$1,value_Int[ix]);
												}
												else{
												     printf("%s is declared \n\n",$1);
												 }
											}
											else{
												printf("%s is already Declared\n\n",$1);
											}
											
										}			
			;

DOUBLEID:
			  DOUBLEID ',' DOUBLE_ID
			| DOUBLE_ID

DOUBLE_ID: 
			  ID '=' expression			{
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_Double[ix] = $3;
												type_ID[ix] = 1;
												
                                                 
												if(value_Int[ix]>0){
												   printf("%s is declared with value :%f\n\n",$1,value_Double[ix]);
												}
												else{
												     printf("%s is declared \n\n",$1);
												 }
										    }
											else{
												printf("%s is already Declared\n\n",$1);
											}
											
										}
										

			| ID 						{
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_Double[ix] = 0;
												type_ID[ix] = 1;
                                               printf("variable declaration_part.\n\n");
												if(value_Int[ix]>0){
												   printf("%s is declared with value :%f\n\n",$1,value_Double[ix]);
												}
												else{
												     printf("%s is declared \n\n",$1);
												 }
											}
											else{
												printf("%s Is already Declared\n\n",$1);
											}
											
										}			
			;

CHARID:
		  	  CHARID ',' CHAR_ID
			
			| CHAR_ID
			;
CHAR_ID: 
			  ID '=' STRING			{
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_String[ix] = $3;
												type_ID[ix] = 2;
                                                printf("variable declaration_part.\n\n");
												//printf("%s Is stored at index :%d: with value :%s\n\n",$1,ix,value_String[ix]);
											    printf("%s is declared \n\n",$1);
											}
											else{
												printf("%s Is already Declared\n\n",$1);
											}
											
										}

			| ID 						{
											int ix = check($1);
											if(ix==-1){
												ix = IDCnt;
												strcpy(IDs[ix],$1);
												IDCnt++;
												value_String[ix] = "";
												type_ID[ix] = 2;
                                                                                                printf("variable declaration_part.\n\n");
												//printf("%s Is stored at index :%d: with value :%s\n\n",$1,ix,value_String[ix]);
											    printf("String %s is declared \n\n",$1);
											}
											else{
												printf("%s Is already Declared\n\n",$1);
											}
											
										}			
			;


;
 
 
 assignment_part: ID '=' expression ';' { 
                                  
					
					int ix = check($1);
					if (ix == -1) {
                       printf("variable %s is not declared.\n", $1);
                    }
					else{
                          
					
					  if (type_ID[ix] == 0) 
					      {
                          value_Int[ix] = $3;
					      printf("%d is assigned to %s\n\n",value_Int[ix],$1);
					      }
					  else {
					      value_Double[ix] = (double)$3;
				         printf("%.2lf is assigned to %s \n",value_Double[ix],$1);

					  } 	  
			}
			//printf("End of assignment_part\n");
}	
  		
;

expression:		 INT 	{$$ = $1;}
			
			| DOUBLE {$$ = $1;}

			| ID 						{
											int ix = check($1);
											if(ix==-1){
												printf("No such variable\n\n");
											}
											else{
												if(type_ID[ix]==0)
													$$ = value_Int[ix];
												else if(type_ID[ix]==1){
													$$ = value_Double[ix];
												}
												else{
													printf("Can't assign string to numeric values\n\n");
												}
											}
										}
            										   

			| expression '+' expression {$$ = $1 + $3;}

			| expression '-' expression {$$ = $1 - $3;}
			
			| expression '*' expression {$$ = $1 * $3;}
			
			| expression '/' expression { float y=(float)$1/(float)$3;
			                      $$=y;  }
			                      //float x= $1;
			                      //float y= $3;
								  //float z= $1/$3;
								 // $$=z;
			                      //printf("%f\n\n",$$);     }
			
			| expression '^' expression {$$ = powl($1,$3);}
			
			| expression '%' expression {
								int x1 = ceil($1);
								int x2 = floor($1);
								int y1 = ceil($3);
								int y2 = floor($3);
								if(x1==x2 && y1==y2){
									$$ = (int) $1 % (int) $3;
								}
							}
			
			| expression '>' expression {$$ = ($1 > $3);}
			
			| expression '<' expression {$$ = ($1 < $3);}
			
			| expression EQUAL expression {$$ = ($1 ==$3);}
			
			| expression NT_EQUAL expression {$$ = ($1!=$3);}
			
			| expression LS_EQUAL expression {$$ = ($1<=$3);}
			
			| expression GT_EQUAL expression {$$ = ($1<=$3);}

			

			
			;

%%


