#include <stddef.h>

enum { N = 1024 };

int add_sub(int arr[N]) {
  int result = 0;
  for (size_t i = 0; i < N; i += 2) {
    if (i % 2 == 0) {
      result += arr[i];
    } else {
      result -= arr[i];
    }
  }
  return result;
}