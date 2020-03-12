#include <math.h>
#include <bits/stdc++.h>
using namespace std;

int stepsCounter;
  
void towerOfHanoi(int n, char from, char to, char temp)  
{  
    if (n == 1)  
    {  
	stepsCounter++;
	cout << "Step #" << stepsCounter << ":\t" << "Move disk 1 from rod " << from << " to rod " << to << endl;  
        return;  
    }  
    towerOfHanoi(n - 1, from, temp, to); //else
    stepsCounter++;
    cout << "Step #" << stepsCounter << ":\t" << "Move disk " << n << " from rod " << from << " to rod " << to << endl;  
    towerOfHanoi(n - 1, temp, to, from);
}  
  
int main()  
{  
    string s;
    cout << "Enter n: ";
    getline(cin, s);
    int n;
    stepsCounter = 0;
    stringstream(s) >> n;  
    towerOfHanoi(n, 'A', 'C', 'B'); //towers are labeled A,B and C
    cout << "\nTotal steps by counting:\t" << stepsCounter << "\n" << endl;
    cout << "By formula (2^n-1):\t" << pow(2.0,n) -1 << "\n" << endl;

    return 0;  
}
