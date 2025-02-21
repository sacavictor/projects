#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <semaphore.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include "a2_helper.h"

#define P3NoOfTh 5
#define P7NoOfTh 48
#define P5NoOfTh 4
#define UNINIT 10000


enum{SUCCESS, ERROR};
enum{STOP, RUNNING, THREAD1, THREAD0};

pid_t pid1 = 0, pid2 = 0, pid3 = 0, pid4 = 0, pid5 = 0, pid6 = 0, pid7 = 0, pid8 = 0;

char* msg = "Couldn't create process";

pthread_mutex_t m3, m5, m7;
pthread_t tid3[P3NoOfTh], tid7[P7NoOfTh], tid5[P5NoOfTh];
pthread_cond_t cond3Start, cond3Stop;
pthread_cond_t cond7Start, cond7Stop;
pthread_cond_t cond5Start, cond5Stop;

int startThread = STOP, endThread = RUNNING, threadPerTime = 0;

typedef struct thread{
    int pr;
    int th;
}ThreadT;

void* process3(void* p) {
    ThreadT* t = (ThreadT*)p;

    if (t->pr != 3)
        return NULL;


    pthread_mutex_lock(&m3);

    if(t->th == 1){
        if(startThread == STOP){
            startThread = THREAD1;
        }
        pthread_cond_signal(&cond3Start);
    }else if(t->th == 5){
        while(startThread != THREAD1)
            pthread_cond_wait(&cond3Start, &m3);
    }

    info(BEGIN, t->pr, t->th);

    if(t->th == 1){
        while(endThread == RUNNING)
            pthread_cond_wait(&cond3Stop, &m3);
    } else if(t->th == 5){
        endThread = STOP;
        pthread_cond_signal(&cond3Stop);
    }

    info(END, t->pr, t->th);
    pthread_mutex_unlock(&m3);

    return NULL;
}

int runningThreads = 0, thread14 = STOP, total = 0;
sem_t mutex;

//maxim 6 threaduri in paralel, threadul 14 se incheie doar daca exista in paralel 6 threaduri, cu tot cu el
void* process7(void* p) {
    ThreadT* t = (ThreadT*)p;
    if(t->pr != 7)
        return NULL;
        
    sem_wait(&mutex);			//lasa maxim 6 threaduri sa intre
	info(BEGIN, t->pr, t->th);

	
    info(END, t->pr, t->th);
    sem_post(&mutex);
    return NULL;
}

int thread3 = RUNNING;

void* process5(void* p){
    ThreadT* t = (ThreadT*)p;
    
    if(t->pr != 5)
        return NULL;
    
    pthread_mutex_lock(&m5);
    
    pthread_cond_signal(&cond5Stop);
    
    if(t->th == 4){
        while(thread3 == RUNNING){
            pthread_cond_wait(&cond5Start, &m5);
        }
        info(BEGIN, 5, t->th);
    }
    else{
        info(BEGIN, 5, t->th);
    }
    
    if(t->th == 3){
        thread3 = STOP;
        info(END, 5, t->th);
        pthread_cond_signal(&cond5Start);
    }
    else info(END, 5, t->th);
    
    pthread_mutex_unlock(&m5);
    return NULL;
}

int processBranch(){
    pid2 = fork();

    if(pid2 == 0){
        info(BEGIN, 2, 0);
        
        pid3 = fork();
        
        if(pid3 == 0){
            info(BEGIN, 3, 0);
            //proc 3
            pthread_mutex_init(&m3, NULL);
            pthread_cond_init(&cond3Start, NULL);
            pthread_cond_init(&cond3Stop, NULL);
            ThreadT arg[P3NoOfTh];

            for(int i=0; i<P3NoOfTh; i++){
                arg[i].pr = 3;
                arg[i].th = i+1;
            }

            for(int i=0; i<P3NoOfTh; i++){
                pthread_create(&tid3[i], NULL, process3, (void*)&arg[i]);
            }
            for(int i=0; i<P3NoOfTh; i++){
                pthread_join(tid3[i], NULL);
            }
            pthread_cond_destroy(&cond3Start);
            pthread_cond_destroy(&cond3Stop);
            pthread_mutex_destroy(&m3);

            pid4 = fork();

            if(pid4 == 0){
                info(BEGIN, 4, 0);

                pid6 = fork();

                if(pid6 == 0){
                    info(BEGIN, 6, 0);
                    info(END, 6, 0);
                } else {
                    waitpid(pid6, NULL, 0);
                    info(END, 4, 0);
                }
            } else {
                waitpid(pid4, NULL, 0);
                info(END, 3, 0);
            }
        } else {
            waitpid(pid3, NULL, 0);
            pid7 = fork();
            if(pid7 == 0){
                info(BEGIN, 7, 0); 

                sem_init(&mutex, 0, 6);
                pthread_mutex_init(&m7, NULL);
                pthread_cond_init(&cond7Start, NULL);
                pthread_cond_init(&cond7Stop, NULL);
                
                ThreadT t[P7NoOfTh];
                for(int i=0; i<P7NoOfTh; i++){
                    t[i].th = i+1;
                    t[i].pr = 7;
                    pthread_create(&tid7[i], NULL, process7, (void*)(t+i));
                }
                for(int i=0; i<P7NoOfTh; i++)
                    pthread_join(tid7[i], NULL);
                
                pthread_mutex_destroy(&m7);
                pthread_cond_destroy(&cond7Start);
                pthread_cond_destroy(&cond7Stop);
                sem_destroy(&mutex);
                
                

                info(END, 7, 0);
            } else{
                waitpid(pid7, NULL, 0);
                info(END, 2, 0);
            }
        }
    } else if(pid2 > 0){
        pid5 = fork();
        if(pid5 == 0){
            info(BEGIN, 5, 0);
            
            pthread_t tidsP[4];
            ThreadT ts[4];
            
            pthread_mutex_init(&m5, NULL);
            pthread_cond_init(&cond5Start, NULL);
            pthread_cond_init(&cond5Stop, NULL);
            
            for(int i=0; i<P5NoOfTh; i++){
                ts[i].pr = 5;
                ts[i].th = i+1;
                pthread_create(&tidsP[i], NULL, process5, &ts[i]);
            }
            
            for(int i=0; i<P5NoOfTh; i++){
                pthread_join(tidsP[i], NULL);
            }
            
            pthread_cond_destroy(&cond5Start);
            pthread_cond_destroy(&cond5Stop);
            pthread_mutex_destroy(&m5);
            
            pid8 = fork();

            if(pid8 == 0){
                info(BEGIN, 8, 0);
                info(END, 8, 0);
            } else {
                waitpid(pid8, NULL, 0);
                info(END, 5, 0);
            }
        } else {
            waitpid(pid2, NULL, 0);
        }
    }
    else{
        puts(msg);
        return ERROR;
    }
    return SUCCESS;
}

int main(){
    init();

    info(BEGIN, 1, 0);
    
    processBranch();
    
    info(END, 1, 0);
    return 0;
}
