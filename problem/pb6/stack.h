#include <stdio.h>  
#include <malloc.h>  
#include <string.h>

typedef struct datatype
{
	char* element;
	int value;
}DataType;

struct Node;                        
typedef struct Node *PNode;
  
typedef struct Node        
{     
    DataType info;         
    PNode link;            
}Node;  
  
typedef struct LinkStack   
{  
    PNode top;
}LinkStack;  
  
typedef struct LinkStack * PLinkStack;
 
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
        p->link = NULL; 
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
        p=stack->top;
        stack->top = stack->top->link;  
        free(p);  
        return 1;  
    }  
}  

DataType getTop(PLinkStack stack)  
{  
    return (stack->top->info);  
}  
  
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
  
void destroyStack(PLinkStack stack)  
{  
    if(stack)  
    {  
        stack->top=NULL;  
        free(stack);  
    }  
}  

PLinkStack sort(PLinkStack stack)
{
    int addFlag = 0;
    PLinkStack dest = createEmptyStack();
    PNode topValue;
    if(isEmptyStack(stack)) return stack;
    topValue = stack->top;
    push(dest, topValue->info);
    pop(stack);
    while(!isEmptyStack(stack))
    {
        PNode p = dest->top;
        PNode prev = dest->top;
        topValue = stack->top;
        while(p != NULL)
        {
            if (strcmp(p->info.element, topValue->info.element) > 0)
            {
                if (p == dest->top)
                {
                    push(dest, topValue->info);
                    addFlag = 1;
                    break;
                }
                else
                {
                    PNode temp =(PNode)malloc(sizeof(struct Node)); 
                    temp->link = p; 
                    temp->info = topValue->info;  
                    prev->link=temp;
                    addFlag = 1;
                    break;
                }
            }
            prev = p;
            p = p->link;
        }
        if (!addFlag)
        {
            PNode temp =(PNode)malloc(sizeof(struct Node)); 
            temp->link = NULL; 
            temp->info = topValue->info;  
            prev->link=temp;
        }
        pop(stack);
        addFlag = 0;
    }
    return dest;
<<<<<<< HEAD
}
=======
}
>>>>>>> 70d8e05257dc7a22a4285f80cc1305ad4eab0aeb
