#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

#define REQ "REQ_PIPE_82215"
#define RESP "RESP_PIPE_82215"
#define shm_name "/dBeGsYf"
#define BUFFER_SIZE 250

enum {SUCCESS, ERROR};

void send_response(int resp_fd, char* response) {
    write(resp_fd, response, strlen(response));
}

void ping(int resp_fd) {
    char response[BUFFER_SIZE];
    snprintf(response, BUFFER_SIZE, "PING!PONG!");
    send_response(resp_fd, response);
}

int exitt(int fd1, int fd2){
    close(fd1);
    close(fd2);
    unlink(RESP);
    shm_unlink(shm_name);
    return SUCCESS;
}

void write_to_shm(int resp_fd, char* shm_ptr, unsigned int offset, unsigned int value, int octals) {
    if (offset >= octals || offset + sizeof(unsigned int) > octals || offset < 0) {
        send_response(resp_fd, "WRITE_TO_SHM!ERROR!");
    }

    memcpy(shm_ptr + offset, (void*)&value, sizeof(unsigned int));
    send_response(resp_fd, "WRITE_TO_SHM!SUCCESS!");
}


int main(){
    if(mkfifo(RESP, 0600) == -1){
        printf("ERROR\ncannot create the response pipe\n");
        return ERROR;
    }
    
    int reqFd = -1, respFd = -1;
    if((reqFd = open(REQ, O_RDONLY)) == -1){
        printf("ERROR\ncannot open the request pipe\n");
        unlink(RESP);
        return ERROR;
    }
    
    if((respFd = open(RESP, O_WRONLY)) == -1){
        printf("ERROR\ncannot open the response pipe\n");
        close(reqFd);
        unlink(RESP);
        return ERROR;
    }
    
    char start[] = "START!";
    if(write(respFd, start, strlen(start)) == -1){
        printf("ERROR\ncannot write to the response pipe\n");
        close(respFd);
        close(reqFd);
        unlink(RESP);
        return ERROR;
    }
    
    printf("SUCCESS\n");
        
    
    int stringIdx = 0;
    int n = 0;
    int fd1 = -1, fd2 = -1;
     char* map = NULL, *pf = NULL;
    unsigned int octals = 0;
    while (1) {
        
        char c = 0;
        char buffer[256];
        stringIdx = 0;
        for(int i=0; i<n; i++){
            buffer[i] = 0;
        }
        while(1){
            if(read(reqFd, &c, 1) == 0)
                break;
            
            if(c == '!')
                break;
            buffer[stringIdx++] = c;
        }buffer[stringIdx] = 0;
            
            if(strncmp(buffer, "PING", 4) == 0){
                ping(respFd);
                
                unsigned int t = 82215;
                write(respFd, &t, sizeof(t));
            }
            else if(strncmp(buffer, "EXIT", 4) == 0){
                exitt(respFd, reqFd);
            }else if(strncmp(buffer, "CREATE_SHM", 10) == 0){
            
                octals = 0;
                read(reqFd, &octals, sizeof(unsigned int));
                fd1 = shm_open(shm_name, O_CREAT | O_RDWR, 0664);
                if(fd1 == -1){
                    write(respFd, "CREATE_SHM!ERROR!", 17);                    
                }
                ftruncate(fd1, octals);
                map = (char*) mmap(NULL, octals, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
                if(map == (void*)(-1)){
                    shm_unlink(shm_name);
                    write(respFd, "CREAT_SHM!", 11);
                    write(respFd, "ERROR!", 6);
                }
                send_response(respFd, "CREATE_SHM!SUCCESS!");
            
            }else if(strncmp(buffer, "WRITE_TO_SHM", 12) == 0){
            
                unsigned int offset = 0, value = 0;
                read(reqFd, &offset, sizeof(offset));
                read(reqFd, &value, sizeof(value));
                
                write_to_shm(respFd, map, offset, value, octals);
                
            }else if(strncmp(buffer, "MAP_FILE", 8) == 0){
            
            char path[50]; int i=0;
                while(read(reqFd, path+i, 1) == 1){
                    if(path[i] == '!')
                        break;
                    i++;
                }
                path[i] = 0;
                
                fd2 = open(path, O_RDONLY);
                if(fd2 == -1){
                    send_response(respFd, "MAP_FILE!ERROR!");
                }
                else{
                    int fileSize = -1;
                    
                    struct stat status;
                    stat(path, &status);
                    fileSize = status.st_size;
                    
                    pf = (char*) mmap(NULL, fileSize, PROT_READ, MAP_SHARED, fd2, 0);
                    if(pf == (void*)(-1)){
                        send_response(respFd, "MAP_FILE!ERROR!");
                     
                    }else{
                        write(respFd, "MAP_FILE!SUCCESS!", 17);
                    }
                }
            }
            else break;
            n = stringIdx;
            
    }

    
    close(reqFd);
    close(respFd);
    unlink(RESP);
    return SUCCESS;
}
