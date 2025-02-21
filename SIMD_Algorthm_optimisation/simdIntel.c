#include <stdint.h>
#include <stdio.h>
#include <immintrin.h>
#include <time.h>

void stoogeSort(int32_t* a, int l, int r) {
    if (l >= r)
        return;

    int n = r - l + 1;

    if (n >= 4) {
        
        int aligned_l = (l / 4) * 4;
        int aligned_r = ((r - 3) / 4) * 4;

        __m128i left_block = _mm_loadu_si128((__m128i*) (a + aligned_l));       
        __m128i right_block = _mm_loadu_si128((__m128i*) (a + aligned_r));      

        __m128i min_vals = _mm_min_epi32(left_block, right_block);
        __m128i max_vals = _mm_max_epi32(left_block, right_block);

        _mm_storeu_si128((__m128i*) (a + aligned_l), min_vals);      
        _mm_storeu_si128((__m128i*) (a + aligned_r), max_vals);   
    }

    // Fallback to scalar for n < 4
    if (n < 4) {
        for (int i = l; i <= r; i++) {
            for (int j = l; j <= r - (i - l); j++) {
                if (a[j] > a[j + 1]) {
                    int temp = a[j];
                    a[j] = a[j + 1];
                    a[j + 1] = temp;
                }
            }
        }
        return;
    }

    // Recursive calls for larger arrays
    if (n > 2) {
        int d = n / 3;

        stoogeSort(a, l, r - d);
        stoogeSort(a, l + d, r);
        stoogeSort(a, l, r - d);
    }
}
int main() {
    int r = 3000;
    int32_t a[r];
    for (int i = r; i > 0; i--)
        a[r - i] = i;

    int l = 0;

    printf("The array before sorting\n");
    for (int i = 0; i < r; i++)
        printf("%ld ", a[i]);

    clock_t exec_time = clock();
    stoogeSort(a, l, r - 1);
    exec_time = clock() - exec_time;
    double time_taken = exec_time / (double) CLOCKS_PER_SEC;

    printf("\nThe array after sorting\n");
    for (int i = 0; i < r; i++) {
        printf("%ld ", a[i]);
    }
    printf("\nExecution time: %lf\n", time_taken);
    return 0;
}