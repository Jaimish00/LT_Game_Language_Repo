/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   glang_rdp.cpp
 * Author: jaimish00
 *
 * Created on May 26, 2020, 5:52 PM
 */

#include <cstdlib>
#include <bits/stdc++.h>
using namespace std;
string s;
int pos = 0;

vector<string> games;

void G();
void D();
void O();
void I();
void P();
void E();
void S();
void T();
void M();
void L();
void Ed();

bool matchKeyWord(int a){
    cout<<"matchKeyWord()\n";
    if(s.substr(a,3)=="get" || s.substr(a,3)=="ram"){
        pos+=3;
        cout<<"----"<<s.substr(a,3)<<"----found\n";
        return true;
    }
    if(s.substr(a,4)=="play" || s.substr(a,4)=="swap"){
        pos+=4;
        cout<<"----"<<s.substr(a,4)<<"----found\n";
        return true;
    }
    if(s.substr(a,5)=="close" || s.substr(a,5)=="clear" || s.substr(a,5)=="total" || s.substr(a,5)=="cache"){
        pos+=5;
        cout<<"----"<<s.substr(a,5)<<"----found\n";
        return true;
    }
    if(s.substr(a,6)=="delete"){
        pos+=6;
        cout<<"----"<<s.substr(a,6)<<"----found\n";
        return true;
    }
    if(s.substr(a,7)=="install" || s.substr(a,7)=="storage" ){
        pos+=7;
        cout<<"----"<<s.substr(a,7)<<"----found\n";
        return true;
    }
}
bool matchCommand(int a){
    cout<<"matchCommand()\n";
    if(s.substr(a,4)=="help"){
        pos+=4;
        cout<<"----"<<s.substr(a,4)<<"----found\n";
        return true;
    }
    if(s.substr(a,5)=="glist"){
        pos+=5;
        cout<<"----"<<s.substr(a,5)<<"----found\n";
        return true;
    }
    if(s.substr(a,6)=="rglist" || s.substr(a,6)=="dglist"){
        pos+=6;
        cout<<"----"<<s.substr(a,6)<<"----found\n";
        return true;
    }
    if(s.substr(a,7)=="current"){
        pos+=7;
        cout<<"----"<<s.substr(a,7)<<"----found\n";
        return true;
    }
}

bool match(char a){
    cout<<"match\n";
    if(a == s[pos]){
        pos++;
        return true;
    }
}

bool matchGame(int a){
    string game = s.substr(pos);
    if(find(games.begin(), games.end(), game) != games.end()){
        pos = s.length();
        cout<<"Game found\n";
        return true;
    }else{
        return false;
    }
}

void G(){
    if(match(' ')){
        M();
    }
}

void M(){
    if(s.substr(pos,2)=="he" && matchCommand(pos))
        return;
    if(s.substr(pos,2)=="cu" && matchCommand(pos))
        return;
    if(s.substr(pos,2)=="gl" && matchCommand(pos))
        return;
    if(s.substr(pos,2)=="rg" && matchCommand(pos))
        return;
    if(s.substr(pos,2)=="dg" && matchCommand(pos))
        return;
}

void D(){
    if(match(' '))
        matchGame(pos);
}

void O(){
    if(match(' '))
        matchGame(pos);
}

void I(){
    if(match(' '))
        matchGame(pos);
}

void P(){
    if(match(' '))
        matchGame(pos);
}

void E(){
    if(match(' '))
        Ed();
}

void Ed(){
    if(s.substr(pos,3)=="cac" && matchKeyWord(pos)){
        if(match(' '))
            matchGame(pos);
    }
    else if(s.substr(pos,1)=="r" && matchKeyWord(pos))
        return;
} 

void S(){
    if(match(' '))
        matchGame(pos);
}

void T(){
    if(match(' '))
        L();
}
void L(){
    if(s.substr(pos,3)=="sto" && matchKeyWord(pos))
        return;
    if(s.substr(pos,3)=="cac" && matchKeyWord(pos))
        return;
}

void statement(){
    cout<<"statement()"<<endl;
    if(s[pos]=='g' && matchKeyWord(pos))
        G();
    if(s[pos]=='d' && matchKeyWord(pos))
        D();
    if(s.substr(pos,3)=="clo" && matchKeyWord(pos))
        O();
    if(s[pos]=='p' && matchKeyWord(pos))
        P();
    if(s[pos]=='i' && matchKeyWord(pos))
        I();
    if(s.substr(pos,3)=="cle" && matchKeyWord(pos))
        E();
    if(s[pos]=='s' && matchKeyWord(pos))
        S();
    if(s[pos]=='t' && matchKeyWord(pos))
        T();
}

void setupGames(){
    games.push_back("tic_tac_toe");
    games.push_back("ludo");
    games.push_back("sudoku");
    games.push_back("trivia");
    games.push_back("flow_free");
    games.push_back("chess");
    games.push_back("zigzag");
    games.push_back("gyro");
    games.push_back("candy_crush");
    games.push_back("temple_run");
    games.push_back("pixel_kingdom");
    games.push_back("color_switch");
    games.push_back("roll_the_ball");
    games.push_back("asphalt_nitro");
    games.push_back("infinity_loop");
}

int main(int argc, char** argv) {
    setupGames();
    getline(cin, s);
    int len = s.length();
    statement();
    
    if(len == pos){
        cout<<"Valid"<<endl;
    }else{
        cout<<"Invalid"<<endl;
    }
    return 0;
}

