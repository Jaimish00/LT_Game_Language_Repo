%token  GAMENAME TOKGET TOKDELETE TOKCLOSE TOKINSTALL TOKPLAY TOKCLEAR TOKSWAP TOKTOTAL TOKCACHE TOKRAM TOKHELP 
%token TOKCURR TOKGLIST TOKRGLIST TOKDGLIST TOKAGLIST TOKSTORAGE

%{
    int yylex();
    #define YYSTYPE char*
    #include<stdio.h>
    #include<stdlib.h>
    #include<string.h>
    #define SIZE 15
    
    void yyerror(const char *);
    void executeCommand(char*);
    void deleteGame (char*);
    void closeGame (char*);
    void installGame (char*);
    void playGame (char*);
    void swapGame (char*);
    void calcMem (char*);
    void clearGameCache (char*);
    void clearRam();        
    void printMessage();
    void printCurrentGame();
    void printGList();
    void printRGList();
    void printDGList();
    void printAGList();
    int generateRandomCache(int lower, int upper);
%}

%{
    struct game_node{
        char name[30];
        int size;
        int cache;
    }availableList[SIZE], installedList[SIZE];
    
    char runningList[SIZE][30];
    void setupAvailableGames();
    int rCount;
    char currentGame[30];
%}

%%

program:
    statement
    |program statement
    ;

statement:
    get_comm
    |delete_comm
    |close_comm
    |install_comm
    |play_comm
    |clear_comm
    |swap_comm
    |total_comm
    ;

get_comm:
    TOKGET TOKHELP  {executeCommand("help");}
    |TOKGET TOKCURR  {executeCommand("current");}
    |TOKGET TOKGLIST  {executeCommand("glist");}
    |TOKGET TOKDGLIST  {executeCommand("dglist");}
    |TOKGET TOKRGLIST  {executeCommand("rglist");}
    |TOKGET TOKAGLIST   {executeCommand("aglist");}
    ;
    
delete_comm:
    TOKDELETE GAMENAME  {deleteGame($2);}
    ;
    
close_comm:
    TOKCLOSE GAMENAME   {closeGame($2);}
    ;

install_comm:
    TOKINSTALL GAMENAME {installGame($2);}
    ;

play_comm:
    TOKPLAY GAMENAME    {playGame($2);}
    ;
    
clear_comm:
    TOKCLEAR clear_mem 
    ;

swap_comm:
    TOKSWAP GAMENAME  {swapGame($2);}
    ;
    
total_comm:
    TOKTOTAL TOKCACHE   {calcMem("cache");}
    |TOKTOTAL TOKSTORAGE    {calcMem("storage");}    
    ;
    
clear_mem:
    TOKCACHE GAMENAME   {clearGameCache($2);}
    |TOKRAM {clearRam();}
    ;
    
%%

int main(void){
    printMessage();
    setupAvailableGames();
    yyparse();
    return 0;
}


struct game_node setupGameNode(char* name, int size, int cache){
    struct game_node gn;
    strcpy(gn.name, name);
    gn.size = size;
    gn.cache = cache;
    return gn;
}

void setupAvailableGames(){
    availableList[0] = setupGameNode("tic_tac_toe", 6, 0);
    installedList[0] = setupGameNode("tic_tac_toe", 0, 0);
    
    availableList[1] = setupGameNode("ludo", 15, 0);
    installedList[1] = setupGameNode("ludo", 0, 0);
    
    availableList[2] = setupGameNode("sudoku", 20, 0);
    installedList[2] = setupGameNode("sudoku", 0, 0);
    
    availableList[3] = setupGameNode("trivia", 47, 0);
    installedList[3] = setupGameNode("trivia", 0, 0);
    
    availableList[4] = setupGameNode("flow_free", 10, 0);
    installedList[4] = setupGameNode("flow_free", 0, 0);
    
    availableList[5] = setupGameNode("chess", 26, 0);
    installedList[5] = setupGameNode("chess", 0, 0);
    
    availableList[6] = setupGameNode("zigzag", 38, 0);
    installedList[6] = setupGameNode("zigzag", 0, 0);
    
    availableList[7] = setupGameNode("gyro", 5, 0);
    installedList[7] = setupGameNode("gyro", 0, 0);
    
    availableList[8] = setupGameNode("candy_crush", 69, 0);
    installedList[8] = setupGameNode("candy_crush", 0, 0);
    
    availableList[9] = setupGameNode("temple_run", 83, 0);
    installedList[9] = setupGameNode("temple_run", 0, 0);
    
    availableList[10] = setupGameNode("pixel_kingdom", 14, 0);
    installedList[10] = setupGameNode("pixel_kingdom", 0, 0);
    
    availableList[11] = setupGameNode("color_switch", 37, 0);
    installedList[11] = setupGameNode("color_switch", 0, 0);
    
    availableList[12] = setupGameNode("roll_the_ball", 42, 0);
    installedList[12] = setupGameNode("roll_the_ball", 0, 0);
    
    availableList[13] = setupGameNode("asphalt_nitro", 43, 0);
    installedList[13] = setupGameNode("asphalt_nitro", 0, 0);
    
    availableList[14] = setupGameNode("infinity_loop", 12, 0);
    installedList[14] = setupGameNode("infinity_loop", 0, 0);
}

void executeCommand(char* command){
    if(strcmp(command, "help") == 0) printMessage();
    else if(strcmp(command, "current") == 0) printCurrentGame();
    else if(strcmp(command, "glist") == 0) printGList();
    else if(strcmp(command, "rglist") == 0) printRGList();
    else if(strcmp(command, "dglist") == 0) printDGList();
    else if(strcmp(command, "aglist") == 0) printAGList();
}


void deleteGame (char* game){
    /* Remove Game from Installed Game List*/
    int i;
	for(i = 0; i < SIZE; i++){
        if(installedList[i].size == 0 && strcmp(installedList[i].name,game) == 0){
            printf("\t%s is not installed!\n", game);
            break;
        }
		if(installedList[i].size != 0 && strcmp(installedList[i].name,game) == 0){
            installedList[i].size=0;
            installedList[i].cache=0;
            printf("\t%s is uninstalled successfully!\n", game);
            break;
		}
	}
}

void closeGame (char* game){
    /*Close Game from Current Playing List*/
    int pos, i, match = 0;
    for(i = 0; i < rCount; i++){
        if(strcmp(runningList[i], game) == 0){
            pos = i;
			rCount--;
            match = 1;
            printf("\t%s closed successfully\n", game);
        }
    }
    if(match == 0){
        printf("\t%s is not running\n", game);
    }
	strcpy(currentGame,"NO GAME");
	printf("\tNo game is running use play or swap \n");
	for(i = pos; i < rCount; i++){
        strcpy(runningList[i], runningList[i+1]);
    }
	strcpy(runningList[rCount],"");
    
}

void installGame (char* game){
    /*Installing Game from Current Available List*/
	int i, match = 0;
	for(i = 0; i < SIZE; i++){
        if(installedList[i].size != 0 && strcmp(installedList[i].name,game) == 0){
            printf("\t%s is already installed!\n\tYou can play with it using \"play %s\"\n", game);
            match = 1; 
            break;
        }
		if(installedList[i].size == 0 && strcmp(installedList[i].name,game) == 0){
            installedList[i].size=availableList[i].size;
            printf("\t%s is Installed Successfully\n\tNow you can play with it using \"play %s\"\n", game, game);
            match = 1;
        }
	}
    if(match == 0)
	{
        printf("\tNo such game exists\n");
	printf("Check available games by 'get aglist'\n");
	}
}

void playGame (char* game){
    int i;
    for(i = 0; i < SIZE; i++){
        if(strcmp(installedList[i].name,game) == 0 && installedList[i].size == 0){
            printf("\tPlease install this game using \"install %s\"\n", game);
            return;
        }
        if(strcmp(installedList[i].name,game) == 0 && installedList[i].size != 0){
            strcpy(runningList[rCount++], game);   
            printf("\tNow Playing %s\n", game);
            installedList[i].cache = generateRandomCache(600,800);
            strcpy(currentGame, game);
        }
    }   
}

void swapGame (char* game){
    /*Swap current running game with the valid swap "game"*/
    int i, match = 0;
    for(i = 0; i < SIZE; i++){
        if(strcmp(installedList[i].name, game) == 0 && installedList[i].size == 0){
            printf("\tPlease install this game using \"install %s\"\n", game);
            return;
        }
    }
    for(i = 0; i < rCount; i++){
        if(strcmp(runningList[i], game) == 0){
            printf("\tNow Playing %s\n", game);
            strcpy(currentGame, game);
            match = 1;
        }
    }
    if(match == 0)
        printf("\tTo swap it out, first you need to run this game using \"play %s\"\n", game);
}

void calcMem (char* memory){
    /*Calculate total "memory" acquired by installed games*/
    int i, total = 0;
    if(strcmp(memory, "cache") == 0){
        for(i = 0; i < SIZE; i++){
            total = total + installedList[i].cache;
        }
        printf("\tTotal cache size is = %d KB\n",total);
    }else if(strcmp(memory, "storage") == 0){
        for(i = 0; i < SIZE; i++){
            total = total + installedList[i].size;
        }
        printf("\tTotal storage used is = %d MB\n",total);
    }
}

void clearGameCache (char* game){
    /*Zero out cache of the "game"*/
    int i;
    for(i = 0; i < SIZE; i++){
        if(strcmp(installedList[i].name, game) == 0 && installedList[i].size == 0){
            printf("\tPlease install this game using \"install %s\"\n", game);
            return;
        }
        if(strcmp(installedList[i].name, game) == 0 && installedList[i].size != 0){
            installedList[i].cache = 0;
            printf("\tcache of %s is cleared\n", game);
        }
    }
}

void clearRam(){
    /*Clear RAM with removing all the games from playing list*/
    int i;
    for(i = 0; i < rCount; i++){
        strcpy(runningList[i], "");
    }
    printf("\tRAM cleared\n");
    rCount = 0;
}

void yyerror(const char *s){
    fprintf(stderr, "%s\n", s);
    return;
}

void printCurrentGame(){
    /*Print Current Running game from playing list*/
    printf("\tCurrently Playing %s\n", currentGame);
}

void printGList(){
    /*Print currently installed Game list*/
    int i = 0, match = 0;
    for(i = 0; i < SIZE; i++){
		if(installedList[i].size!=0){
            printf("\tname = %s\n",installedList[i].name);
            match = 1;
        }
    }
    if(match == 0){
        printf("\tNo game installed, please install them first\n");
    }
}

void printDGList(){
    /*Print Detailed Installed game list*/
	int i = 0, match = 0;
    for(i = 0; i < SIZE; i++){
		if(installedList[i].size!=0){
            printf("\tname = %s\t size = %d MB\t cache = %d KB\n",installedList[i].name,installedList[i].size,installedList[i].cache);
            match = 1;
        }
    }
    if(match == 0){
        printf("\tNo game installed, please install them first\n");
    }
}

void printRGList(){
    /*Print Currently Running in RAM Game List*/
    int i;
    if(rCount == 0){
        printf("\tNo Game is running\n");
        return;
    }
    printf("\tTotal Games = %d\n", rCount);
    for(i = 0; i < rCount; i++){
        printf("\tname = %s\n", runningList[i]);
    }
}


void printAGList(){
    /*Print Available Games list*/
    int i = 0;
    for(i = 0; i < SIZE; i++){
		if(availableList[i].size!=0){
            printf("\tname = %s\t\t size = %d MB\n",availableList[i].name, availableList[i].size);
		}
    }
}

int generateRandomCache(int lower, int upper) {  
    int num = (rand() % (upper - lower + 1)) + lower;
    return num;
} 

void printMessage(){
    /*Print Helper Message*/
   printf("-----------------------------------------HELP-------------------------------------------------\n\n\n");
   printf(" get help : For getting information of all the commands along with their uses \n");
   printf(" get aglist : To see the available games (name and size)\n");
   printf(" install game_name : To add/install the game from the available games \n");
   printf(" get glist : To see all installed games(name)\n"); 
   printf(" get dglist : To see the detailed list of installed games(name,size,cache)\n"); 
   printf(" play game_name : To play the game from installed games\n");
   printf(" get rglist : To see the current running games\n");
   printf(" swap game_name : To Swap between current running game with some other game\n");
   printf(" get current : To get current game\n");
   printf(" close game_name : To close the running game\n");
   printf(" delete game_name : To remove/delete/uninstall the game\n");
   printf(" total cache : Calculate total cache acquired by all the installed games\n");
   printf(" total storage : To calculate total storage acquired by all the installed games\n");
   printf(" clear ram : To clear RAM ,use command\n");
   printf(" clear cache game_name : To clear the cache of the particular game\n");
   printf("-----------------------------------------------------------------------------------------------\n\n\n");
 }
