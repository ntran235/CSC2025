
#include <iostream>
using namespace std;

int ComputeFibonacci(int N) {
   int result;
   
   if (N == 0) {
      result = 0;
   }
   else if (N == 1 || N == 2) {
      result = 1;
   }
   else {
      result = ComputeFibonacci(N - 1) + ComputeFibonacci(N - 2);
   }
   return result;
}

int main() {
   int N;       // F_N, starts at 0
 
   N = 7;
   
   cout << "F_" << N << " is "
        << ComputeFibonacci(N) << endl;
   
   return 0;
}
