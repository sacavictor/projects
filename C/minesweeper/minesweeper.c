#include <stdio.h>
#include "minesweeper.h"

void print(int h, int w, char t[h][w])
{
    char lm='A';
    printf("\t");
    for(int i=1; i<=w; i++)
    {
        printf("%c", lm);
        lm++;
        if(lm=='Z'+1)
        {
            lm='a';
        }
        if(lm=='z')
            break;
    }
    printf("\n");
    for(int i=0; i<h; i++)
    {
        printf("%d\t", i+1);
        for(int j=0; j<w; j++)
        {
            printf("%c", t[i][j]);
        }
        printf("\t%d\n", i+1);
    }

    printf("\t");
    lm='A';
    for(int i=1; i<=w; i++)
    {
        printf("%c", lm);
        lm++;
        if(lm=='Z'+1)
        {
            lm='a';
        }
        if(lm=='z')
            break;
    }
    printf("\n");
}

void create(int nr_bombs, char chols[], int rows[], int h, int w, char t[h][w])
{
    int x[] = {1, -1, 0, 0, 1, 1, -1, -1}, y[] = {0, 0, 1, -1, 1, -1, 1, -1}, di, dj;
    int ri, ci;
    for(int i=0; i<h; i++)
        for(int j=0; j<w; j++)
        {
            t[i][j]='.';
        }

    for(int i=0; i<nr_bombs; i++)
    {
        ri=rows[i];
        ci=chols[i];
        t[ri-1][ci-'A']='X';
    }


    for(int i=0; i<h; i++)
        for(int j=0; j<w; j++)
        {
            int c=0;
            if(t[i][j]!='X')

            {
                for(int l=0; l<8; l++)
                {
                    di = i + x[l];
                    dj = j + y[l];
                    if(di>=0 && di<h && dj>=0 && dj<w)
                        if(t[di][dj]=='X')
                            c++;
                }

                if(c>0)
                    t[i][j] = '0' + c;
            }
        }
}

char** init_state(int h, int w)
{
    char** s=malloc(h*sizeof(char*));
    for(int i=0; i<w; i++)
        s[i] = malloc(w*sizeof(char));
    for(int i=0; i<h; i++)
        for(int j=0; j<h; j++)
        {
            s[i][j] = '?';
        }
    return s;
}

int discover(int i, int j, int h, int w, char t[h][w], char** s)
{
    if(i>h || j>w || i<0 || j<0)
        return -2;
    if(t[i][j]=='X')
        return -1;
    if(s[i][j]=='.')
        return 0;
    if(t[i][j]>'0' && t[i][j]<='9')
    {
        s[i][j]='.';
        return 1;
    }
    if(t[i][j]=='.')
    {
        s[i][j]='.';
        for(int k=-1; k<2; k++)
            for(int l=-1; l<2; k++)
                if(k!=0 && l!=0)
                    discover(i+k, j+l, h, w, t, s);
        return 2;
    }
}
