// Example program
#include <iostream>
#include <cstdio>
#include <sstream>
#include <string>
using namespace std;

int cw(int n);
int ccw(int n);

int main() {
	std::string s;
	std::cout << "Enter n: ";
	getline(std::cin, s);
	int n;
	stringstream(s) >> n;
	std::cout << "\n cw: " << cw(n) << "\n ccw: " << ccw(n);
	return 0;
}

int hanoi(int n) {
	if (n == 1)
		return 1;
	else
		return 2;
}

int cw(int n) {
	hanoi(n);
	return 2 * ccw(n-1) + 1;
}

int ccw(int n) {
	return 2 * ccw(n-1) + cw(n-1) + 2;
}
