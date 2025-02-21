/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/
/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdint.h>
#include <stdio.h>
#include <arm_neon.h>
#include <time.h>
#include <xil_printf.h>

void stoogeSort(int32_t* a, int l, int r) {
    if (l >= r)
        return;

    int n = r - l + 1;

    if (n >= 4) {
        int32_t* a_l = (int32_t*) (a + l);       
        int32_t* a_r = (int32_t*) (a + r - 3);

        int32x4_t left_block = vld1q_s32(a_l); 
        int32x4_t right_block = vld1q_s32(a_r);

        int32x4_t min_vals = vminq_s32(left_block, right_block);
        int32x4_t max_vals = vmaxq_s32(left_block, right_block);

        vst1q_s32(a_l, min_vals);       
        vst1q_s32(a_r, max_vals);        
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
    int r = 800;
    int32_t a[r];
    for (int i = r; i > 0; i--)
        a[r - i] = i;

    int l = 0;

    printf("The array before sorting\n");
    for (int i = 0; i < r; i++)
        xil_printf("%d ", a[i]);

    clock_t exec_time = clock();
    stoogeSort(a, l, r - 1);
    exec_time = clock() - exec_time;
    double time_taken = exec_time / (double) CLOCKS_PER_SEC;

    printf("\nThe array after sorting\n");
    for (int i = 0; i < r; i++) {
        xil_printf("%d ", a[i]);
    }
    xil_printf("\nExecution time: %lf\n", time_taken);
    return 0;
}