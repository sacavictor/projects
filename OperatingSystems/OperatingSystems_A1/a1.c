#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>

enum{FALSE, TRUE};
enum{SUCCESS, ERROR};
                                                       ///PRIMA COMANDA
int variant(char* argv){
    int argValid = strncmp(argv, "variant", 7);
    if(argValid != 0){
        return ERROR;
    }
    
    printf("82215\n");
    return SUCCESS;
}
                                                      ///A DOUA COMANDA
void listing(char* path, int recursive, int nameS, char* name_starts_with, int execute){
    struct dirent* next = NULL;
    struct stat statBuf;
    int n = strlen(name_starts_with);
    
    DIR* dir = opendir(path);
    if(dir == NULL) //base-case pentru recursivitate : daca nu mai exista fisiere, se reintoarce
        return;
    
    char newPath[270]; // se va memora urmatoare cale pentru care sa se execute recursiv/sau s-o afiseze (in functie de optiune)
    while((next = readdir(dir)) != NULL){
        if(strcmp(next->d_name, ".") != 0 && strcmp(next->d_name, "..") != 0){
            sprintf(newPath, "%s/%s", path, next->d_name);
            stat(newPath, &statBuf);
            if(S_ISREG(statBuf.st_mode)){
                if(nameS == TRUE && execute == TRUE){
                    if(strncmp(name_starts_with, next->d_name, n) == 0 && (statBuf.st_mode & S_IXUSR))
                        printf("%s\n", newPath);
                }
                else if(nameS == TRUE){
                    if(strncmp(name_starts_with, next->d_name, n) == 0)
                        printf("%s\n", newPath);
                }
                else if(execute == TRUE){
                    if(statBuf.st_mode & S_IXUSR)
                        printf("%s\n", newPath);
                }
                else
                    printf("%s\n", newPath);
                   
            }
            
            if(S_ISDIR(statBuf.st_mode)){ 
                if(recursive == TRUE)// "Aplica DFS pe foldere"
                    listing(newPath, recursive, nameS, name_starts_with, execute);

                if(nameS == TRUE && execute == TRUE){
                    if(strncmp(name_starts_with, next->d_name, n) == 0 && (statBuf.st_mode & S_IXUSR))
                        printf("%s\n", newPath);
                }
                else if(nameS == TRUE){
                    if(strncmp(name_starts_with, next->d_name, n) == 0)
                        printf("%s\n", newPath);
                }
                else if(execute == TRUE){
                    if(statBuf.st_mode & S_IXUSR)
                        printf("%s\n", newPath);
                }
                else
                    printf("%s\n", newPath);
            }
        }
    }
    closedir(dir);
    dir = NULL;

}

int list(int argc, char* argv[]){
    int argValid = strncmp(argv[1], "list", 4);
    if(argValid != 0){
        return ERROR;
    }
    
    
    char path[200] = {'\0'};
    int recursive = FALSE;
    int execute = FALSE, nameS = FALSE;
    char name_starts_with[100] = {'\0'};;
    
    for(int i=2; i < argc; i++){ // caut path-ul in lista de argumente
        int n = strlen(argv[i]);
        if(n > 4 && argv[i][0] == 'p' && argv[i][1] == 'a' && argv[i][2] == 't' && argv[i][3] == 'h'){ //il salvez intr-un string
            int stringIdx = 0; // daca s-a ajuns la path, se copiaza
            for(int j = 5; argv[i][j] != '\0'; j++){
                path[stringIdx++] = argv[i][j];
            }
            path[stringIdx] = '\0';
        }
        
        else if(n == 16 && strncmp(argv[i], "has_perm_execute", 16) == 0){ // se cauta optiunea de fisiere cu drept de executie
            execute = TRUE;
            }
            
        else if(strncmp(argv[i], "name_starts_with", 16) == 0){ //se copiaza numele cu care incep elementele
            int stringIdx = 0;
            nameS = TRUE;
            for(int j = 17; argv[i][j] != '\0'; j++){ 
                name_starts_with[stringIdx++] = argv[i][j];
            }
            name_starts_with[stringIdx] = '\0';
        }
        else if(strncmp(argv[i], "recursiv", 8)==0 || strncmp(argv[i], "recursive", 9) == 0)
            recursive = TRUE;
    }

    //verificarea argumentelor
    
    if(path[0] == '\0'){
        printf("Invalid path\n");
        return ERROR;
    }
    
    
    //afisare : Se citeste un subdirector/fisier pentru a vedea daca directorul este gol sau nu
    DIR* d = opendir(path);
    if(d == NULL){
        printf("Cannot open directory. Invalid path\n");
        return ERROR;
    }
    struct dirent* next = readdir(d);
    if(next == NULL){ // director gol
        printf("SUCCESS\n");
        return SUCCESS;
    }
    printf("SUCCESS\n");
    listing(path, recursive,nameS, name_starts_with, execute);
    
    closedir(d);
    d = NULL;
    
    return SUCCESS;
}

int parse(int argc, char* argv[]){
    int valid = strncmp(argv[1], "parse", 5), pathIdx = 0;
    if(valid != 0)
        return ERROR;
    char path[1000] = {'\0'};

    if(strncmp(argv[2], "path=", 5) == 0){
        for(int i = 5; argv[2][i] != '\0'; i++){
            path[pathIdx++] = argv[2][i];
        }
    }else{
        printf("Specify the path\n");
        return ERROR;
    }
    path[pathIdx] = '\0';
    if(path[0] == '\0'){
        printf("Invalid path\n");
        return ERROR;
    }
    int fd = open(path, O_RDONLY);
    if(fd == -1){
        printf("Error opening the file\n");
        return ERROR;
    }
    lseek(fd, -4, SEEK_END);
    unsigned short int headerSize = 0;
    read(fd, &headerSize, 2);
    
    char magic[3] = {'\0'};
    read(fd, magic, 2);
    if(magic[0] == '\0' || strcmp(magic, "su") != 0){
        printf("ERROR\nwrong magic\n");
        return ERROR;
    }
    
    lseek(fd, -headerSize, SEEK_CUR);
    
    
    
    unsigned short int version = 0;
    read(fd, &version, 2);
    if(version < 29 || version > 115){
        printf("ERROR\nwrong version\n");
        return ERROR;
    }
    
    unsigned short int noOfSections = 0;
    read(fd, &noOfSections, 1);
    if(noOfSections != 2 && (noOfSections < 7 || noOfSections > 19)){
        printf("ERROR\nwrong sect_nr\n");
        return ERROR;
    }
    
    
    int contentIdx=0;
    char content[noOfSections][50];
    while(contentIdx < noOfSections){
        char name[12] = {'\0'};
        unsigned short int type = 0;
        int offset = 0, size= 0;
        
        read(fd, name, 11);
        read(fd, &type, 2);
        read(fd, &offset, 4);
        read(fd, &size, 4);
        if(type == 23 || type == 94 || type == 76){
            sprintf(content[contentIdx], "%s %d %d", name, type, size);
            contentIdx++;
        }else{
            printf("ERROR\nwrong sect_types\n");
            return ERROR;
        }
    }
    
    close(fd);

    printf("SUCCESS\nversion=%d\nnr_sections=%d\n", version, noOfSections);
    
    for(int i=0; i<noOfSections; i++){
        if(i < noOfSections - 1)
            printf("section%d: %s\n", i+1, content[i]);
        else printf("section%d: %s", i+1, content[i]);
    }
    
    
    return SUCCESS;
}

char** bufferSectionFile(char* path, unsigned short int* noOfSections){
    int fd = open(path, O_RDONLY);

    if(fd == -1){
        close(fd);
        return NULL;
    }

    lseek(fd, -4, SEEK_END);
    unsigned short int headerSize = 0;
    read(fd, &headerSize, 2);
    
    char magic[3] = {'\0'};
    read(fd, magic, 2);
    if(magic[0] == '\0' || strcmp(magic, "su") != 0){
        close(fd);
        return NULL;
    }
    
    lseek(fd, -headerSize, SEEK_CUR);
    
    
    
    unsigned short int version = 0;
    read(fd, &version, 2);
    if(version < 29 || version > 115){
        close(fd);
        return NULL;
    }
    
    *noOfSections = 0;
    read(fd, noOfSections, 1);
    if(*noOfSections != 2 && (*noOfSections < 7 || *noOfSections > 19)){
        close(fd);
        return NULL;
    }

    char** content = (char**)malloc(*noOfSections * sizeof(char*));

    int sectionSizes[*noOfSections], offset[*noOfSections];
    int contentIdx = 0;

    while(contentIdx < *noOfSections){
        char name[12] = {'\0'};
        unsigned short int type = 0;

        read(fd, name, 11);
        read(fd, &type, 2);
        read(fd, &offset[contentIdx], 4);
        read(fd, &sectionSizes[contentIdx], 4);
        if(type == 23 || type == 94 || type == 76){
            contentIdx++;
        }else{
            for(int i=0; i<*noOfSections; i++){
                free(content[i]);
                content[i] = NULL;
            }
            free(content);
            content = NULL;

            close(fd);
            return NULL;
        }
    }
    //initializez totul ca la inceput, si incep sa pun in array-ul de stringuri sectiunile
    contentIdx = 0;

    for(; contentIdx < *noOfSections; contentIdx++){
        lseek(fd, offset[contentIdx], SEEK_SET);

        content[contentIdx] = (char*) malloc((sectionSizes[contentIdx] + 1) * sizeof(char));
        int stringIdx = 0;
        while(stringIdx < sectionSizes[contentIdx]){
            read(fd, &content[contentIdx][stringIdx], 1);
            stringIdx++;
        }
        content[contentIdx][stringIdx] = '\0';
    }

    close(fd);

    return content;
}

int extract(int argc, char* argv[]){
    if(argc < 4)
        return ERROR;

    if(strcmp(argv[1], "extract") != 0)
        return ERROR;

    char path[100] = {'\0'};
    int pathIdx = 0, sectionNr=-1, lineNr = -1;

    //parcurgerea argumenetelor
    for(int i=2; i<argc; i++){
        if(strncmp(argv[i], "path=", 5) == 0){
            for(int j=5; argv[i][j] != '\0'; j++){
                path[pathIdx++] = argv[i][j];
            }
            path[pathIdx] = '\0';

        }
        else if(strncmp(argv[i], "section=", 8) == 0){
            sscanf(argv[i]+8, "%d", &sectionNr);
        }
        else if(strncmp(argv[i], "line=", 5) == 0){
            sscanf(argv[i]+5, "%d", &lineNr);
        }
    }
    //verificarea argumentelor

    if(path[0] == '\0'){
        printf("ERROR\ninvalid file\n");
        return ERROR;
    }

    if(sectionNr == -1){
        printf("ERROR\ninvalid section\n");
        return ERROR;
    }
    if(lineNr == -1){
        printf("ERROR\ninvalid line\n");
        return ERROR;
    }

    unsigned short int noOfSections = 0;

    char** content = bufferSectionFile(path, &noOfSections);
    if(content == NULL){
        printf("ERROR\ninvalid file\n");
        return ERROR;
    }


    int lineIterator = 1, startLine = 0;
    for(int i = 0; content[sectionNr-1][i] != '\0'; i++){
        if(content[sectionNr-1][i+1] != '\0' && content[sectionNr-1][i] == 0x0D  && content[sectionNr-1][i+1] == 0x0A){
            lineIterator++;
            startLine = i + 2;
            i += 2;
        }
        if(lineNr == lineIterator){
            break;
        }
    }

    if(lineNr != lineIterator){
        printf("ERROR\ninvalid line\n");
        puts("9");
        return ERROR;
    }

    printf("SUCCESS\n");
    for(int j = startLine; content[sectionNr-1][j] != '\0' && content[sectionNr-1][j] != 0x0D  && content[sectionNr-1][j+1] != 0x0A; j++){
        printf("%c", content[sectionNr-1][j]);
    }printf("\n");

    for(int i=0; i<noOfSections; i++){
        free(content[i]);
        content[i] = NULL;
    }
    free(content);
    content = NULL;

    return SUCCESS;
}

int isSectionFile(char* path){
    if(path == NULL)
        return FALSE;

    if(path[0] == '\0'){
        return FALSE;
    }
    int fd = open(path, O_RDONLY);
    if(fd == -1){
        return FALSE;
    }
    lseek(fd, -4, SEEK_END);
    unsigned short int headerSize = 0;
    read(fd, &headerSize, 2);
    
    char magic[3] = {'\0'};
    read(fd, magic, 2);
    if(magic[0] == '\0' || strcmp(magic, "su") != 0){
        return FALSE;
    }
    
    lseek(fd, -headerSize, SEEK_CUR);
    
    
    
    unsigned short int version = 0;
    read(fd, &version, 2);
    if(version < 29 || version > 115){
        return FALSE;
    }
    
    unsigned short int noOfSections = 0;
    read(fd, &noOfSections, 1);
    if(noOfSections != 2 && (noOfSections < 7 || noOfSections > 19)){
        return FALSE;
    }
    int contentIdx = 0, giveType = 0;
    while(contentIdx < noOfSections){
        char name[12] = {'\0'};
        unsigned short int type = 0;
        int offset = 0, size= 0;
        
        read(fd, name, 11);
        read(fd, &type, 2);
        read(fd, &offset, 4);
        read(fd, &size, 4);
        if(type == 76 || type == 23 || type == 94){
            if(type == 76)
                giveType++;
            contentIdx++;
        }else{
            return FALSE;
        }
    }
    
    close(fd);
    if(giveType >= 4)
        return TRUE;
    return FALSE;
}

int sectionFileListing(char* path){
    struct dirent* next = NULL;
    struct stat statBuf;
    
    DIR* dir = opendir(path);
    if(dir == NULL) //base-case pentru recursivitate : daca nu mai exista fisiere, se reintoarce
        return ERROR;
    
    char newPath[270]; // se va memora urmatoare cale pentru care sa se execute recursiv/sau s-o afiseze (in functie de optiune)
    while((next = readdir(dir)) != NULL){
        if(strcmp(next->d_name, ".") != 0 && strcmp(next->d_name, "..") != 0){
            sprintf(newPath, "%s/%s", path, next->d_name);
            stat(newPath, &statBuf);
            if(S_ISREG(statBuf.st_mode)){
                if(isSectionFile(newPath))
                    printf("%s\n", newPath);
                   
            }
            
            if(S_ISDIR(statBuf.st_mode)){ 
                sectionFileListing(newPath);
            }
        }
    }
    closedir(dir);
    dir = NULL;
    return SUCCESS;
}

int findall(int argc, char* argv[]){
    if(strcmp(argv[1], "findall") != 0)
        return ERROR;

    char path[100];
    int stringIdx = 0;
    if(strncmp(argv[2], "path=", 5) == 0){
        for(int i=5; argv[2][i] != '\0'; i++){
            path[stringIdx++] = argv[2][i];
        }
    }
    path[stringIdx] = '\0';
    if(path[0] == '\0'){
        printf("ERROR\ninvalid path\n");
        return ERROR;
    }
    DIR* dir = opendir(path);
    if(dir == NULL){
        printf("ERROR\ninvalid directory\n");
        return ERROR;
    }
    free(dir);
    dir = NULL;
    printf("SUCCESS\n");
    sectionFileListing(path);
    return SUCCESS;
}

int main(int argc, char* argv[]){
    
    if(argc < 2){
        return 0;
    }
    variant(argv[1]);
    list(argc, argv);
    parse(argc, argv);
    extract(argc, argv);
    findall(argc, argv);
    return 0;
}