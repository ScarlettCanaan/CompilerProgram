#include<iostream>
#include<cstdlib>
#include <sstream>

using namespace std;

string teamnumber;
string block[99];
string cid[99];
string name[99];
string prev_stage="none";
bool success_flag=false;
int ID_time=0;
int b=0;
int c_index=0;
int n_index=0;


bool isNum(string str)
{
    string  token=str;
    int success=0;
    for(int i=0; i<str.length(); i++)
    {
        for(int num=48; num<58; num++)
        {
            if(str.at(i)==num)
            {
                success++;
            }
        }
    }
    if(success==str.length())
        return true;
    else
        return false;
}
bool isTeamNumber(string c)
{
    if(c.at(0)=='t'&&c.length()!=1)
    {
        c.erase(0,1);
        if(isNum(c)&&prev_stage=="none")
        {
            teamnumber=c;
            prev_stage="teamnumber";
          //  cout<<"test case";
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        return false;
    }

}
bool isName(string str)
{
    string  token=str;
    int success=0;
    for(int i=0; i<str.length(); i++)
    {
        for(int num=65; num<91; num++)
        {
            if(str.at(i)==num)
            {
                success++;
            }
        }
        for(int num=97; num<123; num++)
        {
            if(str.at(i)==num)
            {
                success++;
            }
        }
    }
    if(success==str.length()&&(prev_stage=="cid"||prev_stage=="teamnumber"||prev_stage=="coop"))
    {
        name[n_index]=str;
        n_index++;
        prev_stage="name";
        ID_time++;
        return true;
    }

    else
        return false;
}

bool isCid(string c)
{
    if(isNum(c)&&(prev_stage=="teamnumber"||prev_stage=="name"||prev_stage=="coop"))
    {
        cid[c_index]=c;
        c_index++;
        prev_stage="cid";
        ID_time++;
        return true;
    }
    else
        return false;
}
bool isCooperate(string str,int blo)
{
    if(str.at(0)=='c'&&str.length()==1&&(prev_stage=="cid"||prev_stage=="name")){
        ID_time=0;
        prev_stage="coop";
        return true;
    }

    else
        return false;
}


void block_cut(string str)
{
    string token;
    int length;

    for(int i=0; i<str.length()-1; i++)
    {
        if(str.at(i)==' '&&str.at(i+1)!=' ')
        {
            block[b]=token;
            token="";
            b++;
        }
        else
        {
            token=token+str.at(i);
        }
    }
    block[b]=token+str.at(str.length()-1);
}
bool isGammar()
{
    for(int blo=0; blo<=b; blo++)
    {
        if(isTeamNumber(block[blo]))
        {
            continue;
        }
        else if(isCid(block[blo]))
        {
            continue;
        }
        else if(isName(block[blo])&&block[blo].at(0)!='c'&&block[blo].at(0)!='t')
        {
            continue;
        }
        else if(isCooperate(block[blo],blo))
        {
            continue;
        }
        else
        {
            cout<<"invalid input";
            return false;
        }
    }

    if(prev_stage=="teamnumber"||prev_stage=="none"||(ID_time!=2)){
        cout<<"invalid input";
            return false;
    }
    return true;


}

void parser()
{
    for(int blo=0; blo<=b; blo++)
    {
        if(isTeamNumber(block[blo]))
        {
            cout<<"teamnumber t"<<teamnumber<<endl;
        }
        else if(isCid(block[blo]))
        {
            cout<<"cid "<<block[blo]<<endl;
        }
        else if(isName(block[blo])&&block[blo]!="c")
        {
            cout<<"name "<<block[blo]<<endl;
        }
        else if(isCooperate(block[blo],blo))
        {
            cout<<"cooperate c"<<endl;
        }
        else
        {
            break;
        }
    }

}

int main()
{
    string input;
    getline(cin,input);
    if(input==""||input.at(0)==' '){
        cout<<"invalid input";
    }
    else{
        block_cut(input);
        if(isGammar())
        {
            prev_stage="none";
            parser();
        }

    }



}
