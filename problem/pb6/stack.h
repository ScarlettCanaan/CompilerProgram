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
  
//创建一个的空栈  
PLinkStack createEmptyStack(void)  
{  
    PLinkStack stack=(PLinkStack)malloc(sizeof(struct LinkStack));  
    if(stack == NULL)  
        printf("存储分配失败，请重建栈！\n");  
    else  
        stack->top=NULL;  
    return stack;     
}  
  
//判断栈是否为空栈  
int isEmptyStack(PLinkStack stack)  
{  
    return (stack->top == NULL);  
}  
  
  
//进栈,成功返回1，失败返回0  
int push(PLinkStack stack,DataType x)  
{  
    PNode p =(PNode)malloc(sizeof(struct Node));  
    if(p == NULL )    
    {  
        printf("新结点分配内存失败，进栈失败，请重试！\n");  
        return 0;  
    }  
    else  
    {  
        p->info = x;  
        p->link=stack->top;     //替换栈顶元素  
        stack->top=p;  
        return 1;  
    }  
}  
  
//出栈，成功返回1，失败返回0  
int pop(PLinkStack stack)  
{  
    if(isEmptyStack(stack))  
    {  
        printf("栈为空！\n");  
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
    if(isEmptyStack(stack))  
        printf("当前栈为空！无内容可显示。\n");  
    else  
    {  
        PNode p;  
        p=stack->top;
        while(p->link != NULL)  
        {  
            printf("%s %d\n",p->info.element, p->info.value);  
            p=p->link;
        }  
        printf("%s %d\n",p->info.element, p->info.value);    //显示最后一个元素  
    }  
}  
  
//把栈置空  
void setEmpty(PLinkStack stack)  
{  
    stack->top=NULL;  
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