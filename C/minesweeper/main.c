#include <stdio.h>
#include <stdlib.h>
#include "minesweeper.h"
int main()
{
    char chols[52]= {'B', 'D'};
    int h=10;
    int w=10;
    int rows[100] = {3, 5};
    int i = 2;
    int j = 3;
    char t[h][w];
    create(2, chols, rows, h, w, t);
    print(h, w, t);
    char** s = init_state(h, w);
    int d = discover(i, j, h, w, t[h][w], s);
    printf("starea discover este %d", d);
    free(s);
    return 0;
}
