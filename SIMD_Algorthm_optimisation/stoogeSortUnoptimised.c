
#include <stdio.h>
#include <time.h>

void swap(int* a, int* b){
    int aux = *a;
    *a = *b;
    *b = aux;
}

void stoogeSort(int* a, int l, int r){
    if(l >= r){
        return;
    }
    
    int n = r - l + 1;
    if(a[l] > a[r]){
        swap(a + l, a + r);
    }
    
    if(n > 2){
        int d = n/3;
        stoogeSort(a, l, r-d);
        stoogeSort(a, l+d, r);
        stoogeSort(a, l ,r-d);
    }
}

int main() {
    int r = 3000;
    int a[r];
    for (int i = r; i > 0; i--)
        a[r - i] = i;

    int l = 0;

    printf("The array before sorting\n");
    for (int i = 0; i < r; i++)
        printf("%d ", a[i]);

    clock_t exec_time = clock();
    stoogeSort(a, l, r - 1);
    exec_time = clock() - exec_time;
    double time_taken = exec_time / (double) CLOCKS_PER_SEC;

    printf("\nThe array after sorting\n");
    for (int i = 0; i < r; i++) {
        printf("%d ", a[i]);
    }
    printf("\nExecution time: %lf\n", time_taken);
    return 0;
}