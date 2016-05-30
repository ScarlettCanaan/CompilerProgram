#include <stdio.h>  
#include <malloc.h>  

typedef struct datatype
{
	char* element;
	int value;
}DataType;

struct Node;                        //单链表结点类型  
typedef struct Node *PNode;         //结点指针类型  
  
typedef struct Node                 //单链表结点结构  
{     
    DataType info;                  //结点数据域  
    PNode link;                     //结点指针域
}Node;  
  
typedef struct LinkStack           //链表栈定义  
{  
    PNode top;        //栈顶指针  
}LinkStack;  
  
typedef struct LinkStack * PLinkStack;    //链表栈的指针类型  
  
PLinkStack createEmptyStack(void)  
{  
    PLinkStack stack=(PLinkStack)malloc(sizeof(struct LinkStack));  
    if(stack == NULL)  
        return NULL;
    else  
        stack->top=NULL;  
    return stack;     
}  
  
int isEmptyStack(PLinkStack stack)  
{  
    return (stack->top == NULL);  
}  
  
  
int push(PLinkStack stack,DataType x)  
{  
    PNode p =(PNode)malloc(sizeof(struct Node));  
    if(p == NULL)    
    {
        return 0;  
    }  
    else  
    {  
        p->info = x;  
        p->link=stack->top;
        stack->top=p;  
        return 1;  
    }
}



int pop(PLinkStack stack)  
{  
    if(isEmptyStack(stack))  
    {  
        return 0;  
    }  
    else  
    {  
        PNode p;  
        p=stack->top;   //删除最后一个结点  
        stack->top = stack->top->link;  
        free(p);  
        return 1;  
    }  
}  
  
//取栈顶元素  
DataType getTop(PLinkStack stack)  
{  
    return (stack->top->info);  
}  
  
  
//显示栈内所有元素   
void showStack(PLinkStack stack)  
{  
    if(isEmptyStack(stack));
    else  
    {  
        PNode p;  
        p=stack->top;
        while(p->link != NULL)  
        {  
            if (p->info.value != 0)
            {
                printf("%s %d\n",p->info.element, p->info.value);  
            }
            p=p->link;
        }  
        if (p->info.value != 0)
        {
            printf("%s %d\n",p->info.element, p->info.value);  
        }
    }  
}
  
//把栈销毁  
void destroyStack(PLinkStack stack)  
{  
    if(stack)  
    {  
        stack->top=NULL;  
        free(stack);  
    }  
}  