#include <iostream>
#include <string.h>
#include <math.h>

using namespace std;

struct IEEE
{
	int signBit;
	int Exp[5];
	int Mant[10];
};

int main()
{
	IEEE ie;
	char s[1000];
	cout<<"Enter the Decimal Format\n";
	cin>>s;

	if(s[0]=='-')
		ie.signBit = 1;
	else
		ie.signBit = 0;

	char *token = strtok(s,".");
	char *Decimal[2];
	int k=0;
	//printf("Debug\n");
	while(token!=NULL)
	{	
		Decimal[k]=token;	// Decimal[0] is before '.' and Decimal[1] is after
		k++;
		token = strtok(NULL, ".");
	}
	//printf("%s %s\n",Decimal[0],Decimal[1]);
	int Dec0 = atoi(Decimal[0]);
	int Dec0Bin[1000];
	int za,zb;
	for(za=0; Dec0>0; za++)    
	{    
		Dec0Bin[za]=Dec0%2; 		// Dec0Bin is in Reverse Order   
		Dec0 = Dec0/2;  
		//printf("Dec0Bin %d\n", Dec0Bin[za]);
	}

	int nearest_10 = pow(10,strlen(Decimal[1]));
	int Dec1 = atoi(Decimal[1]);
	int Dec1Bin[1000];

	cout<<za<<endl;
	for(zb=0; zb<11-za; zb++)    
	{    
		Dec1=Dec1*2;
		if(Dec1>=nearest_10)
		{
			Dec1Bin[zb]=1;
			Dec1 -= nearest_10;
		}  
		else
			Dec1Bin[zb]=0; 
		//printf("Dec1Bin %d\n", Dec1Bin[zb]);
	}

	int zc;
	int temp = 15+za-1;
	int Dec3Bin[10];
	printf("TEMP = %d\n",temp );
	for(zc=0; temp>0; zc++)    
	{    
		Dec3Bin[zc]=temp%2; 		// Converting Exponent to Binary  format   

		temp = temp/2;  
	}
	for(int i=0;i<5;i++)
	{
		ie.Exp[i] = Dec3Bin[4-i];
		//printf("%d\n",ie.Exp[i] );
		cout<<"Exp "<<ie.Exp[i];
	}
	cout<<endl;

	int m=0;
	temp = za-1;
	for(int i=temp-1;i>=0;i--)
	{
		ie.Mant[m] = Dec0Bin[i];
		//cout<<"Mant "<<ie.Mant[m]<<" ";
		m++;
	}
	//cout<<"M: "<<m<<" "<<endl;

	for(int i=m;i<10;i++)
	{
		//cout<<Dec1Bin[1];
		ie.Mant[i] = Dec1Bin[i-m];
		// cout<<"Mant "<<ie.Mant[i]<<" ";
		//m++;
	}
	cout<<endl;
	cout<<ie.signBit<<" || ";
	for(int i=0;i<10;i++)
		cout<<ie.Mant[i];
	cout<<" || ";
	for(int i=0;i<5;i++)
		cout<<ie.Exp[i];
	cout<<endl;
	return 0;
}