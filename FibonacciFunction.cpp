#include <iostream>
using namespace std;


unsigned int Fibonacci(unsigned int n) {
	unsigned int previous = 1;
	unsigned current = 1;
	unsigned next = 1;
	for (unsigned int i = 3; i <= n; ++i) {
        next = previous + current;
        previous = current; 
        current = next; 
    }   
    return next; 
}



int main() {
    unsigned int result = Fibonacci(7);
    cout << result << endl;
    return 0;

}