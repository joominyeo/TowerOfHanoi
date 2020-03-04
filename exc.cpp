// Example program
#include <iostream>
#include <cstdio>
#include <sstream>
#include <string>
using namespace std;

int fec; // function enter count: keeps track of how many times any function has been called (excluding the main fnc)
int cwcounter = 0;
int ccwcounter = 0;
int cwval;
int ccwval;

int cw(int n);
int ccw(int n);
void initialise();

int main() {
	fec = 0;
	string s;
	cout << "Enter n: ";
	getline(cin, s);
	int n;
	stringstream(s) >> n;
	for (int x = 1; x <= n; x++)
	{
		initialise();
		cwval = cw(x);
		ccwval = ccw(x);
		cout << "For n = " << x << "\n";
		//cout << "\tcw steps: " << cwcounter << "\tccw steps: " << ccwcounter << "\n";
		cout << "\tcw: " << cwval << "\tccw: " << ccwval << "\n";
	}
	return 0;
}

void initialise() {
	cwcounter = 0;
	ccwcounter = 0;
	cwval = 0;
	ccwval = 0;
}

int cw(int n) {
	//fec++; cout << fec << "\n";
	cwcounter++;
	if (n == 1)
		return 1;
	return 2 * ccw(n-1) + 1;
}

int ccw(int n) {
	//fec++; cout << fec << "\n";
	ccwcounter++;
	if (n == 1)
		return 2;
	return 2 * ccw(n-1) + cw(n-1) + 2;
}
