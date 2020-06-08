# This is GLANG (Game Language)

### Our platform provides you simple and concise game management features combined into single application and having multiple features ### ranging from playing any game, to adding or removing them from the application.
### One can install, uninstall, play and close games as well as swap from one running game to another running game. 
### Also in the backend to handle the game management, we have provision of 3 separate lists which are mainly, running list, available list and installed list. 
### One can see the list of games that are available, detailed list of games that are installed in which size and cache information is also provided. List of games that are running in the system can also be seen.
### For the memory management related to the games, we have also provided certain features like displaying total storage and cache of games, clearing RAM and clearing cache of particular game.
### At any instance of time, if you need help regarding the application, you may enter command get help for all the information of any command.


To run this files, you need to install flex and Bison in your windows
Then follow these steps:<br>
#### flex glex.l<br>
#### bison gyacc.y -dy<br>
#### gcc lex.yy.c y.tab.c<br>
#### a.exe<br>
