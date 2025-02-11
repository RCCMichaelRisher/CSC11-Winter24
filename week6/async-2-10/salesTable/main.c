
#include "stdio.h"
//2d array constants
#define ROWS 4
#define COLS 5

void printSalesTable( int *sales );
void calcTotalSales( int *sales, int *totalSales );
void calcAvgSales( int *sales, float *avgSales );
void printTotalSales( int *totalSales );
void printAvgSales( float *avgSales );

int main(){

    int sales[ROWS * COLS] ={
        120, 150, 130, 170, 190,
        200, 180, 210, 190, 230,
        90,	 100, 110, 120, 130,
        300, 320, 310, 330, 350,
    };
    //if i wanted to print 180
    //the default 2d way would sales[1][1]
    //[1 * COLS + 1] = [ 1 * 5 + 1 ] = 6 sales[6] = 180 
    int totalSales[ROWS];
    float avgSales[COLS];

    //print my table
    printSalesTable( sales );

    // //calculate the stats
    calcTotalSales( sales, totalSales );
    calcAvgSales( sales, avgSales );

    // //display total sales
    printTotalSales( totalSales );

    // //display avaergae sale
    printAvgSales( avgSales );
    

    return 0;
}

void printSalesTable( int *sales) {
    printf( "Sales Data Table:\n");
    printf( "Product \\ Month   Jan  Feb  Mar  Apr  May\n");

    for( int i = 0; i < ROWS; i++ ){
        printf( "Product %d        ", i + 1 );
        for( int j = 0; j < COLS; j++ ){
            int idx = i * COLS + j;
            printf("%4d ", sales[idx] );
        }
        printf( "\n" );
    }
    printf( "\n" );
}

//calcs the total sales for products
void calcTotalSales( int *sales, int *totalSales ){
    for( int i =0; i < ROWS; i++ ){
        totalSales[i] = 0; //set it initally to 0 so we sum it
        for( int j = 0; j < COLS; j++){
            int idx = i * COLS + j;
            totalSales[i] = totalSales[i] + sales[idx];
        }
    }
}

//print total sales table
void printTotalSales( int *totalSales ){
    printf( "Total sales per product:\n");
    for( int i  = 0; i < ROWS; i++ ){
        printf( "Product %d: %d\n", i + 1, totalSales[i] );
    }
    printf( "\n" );
}

//calc the avg sales per month
void calcAvgSales( int *sales, float *avgSales ){
    for( int j = 0; j <COLS; j++ ){
        int sum = 0;
        for( int i = 0; i < ROWS; i++ ){
            int idx = i * COLS + j;
            sum += sales[idx];
        }
        //making them as floats for the c version
        avgSales[j] = (float)sum / ROWS;
    }
}

void printAvgSales( float *avgSales ){
    printf( "Average Sales Per Month:\n");
    char *months[] = {"Jan", "Feb",  "Mar",  "Apr",  "May" };
    for( int j = 0; j < COLS; j++ ){
        printf( "%s: %.2f\n", months[j], avgSales[j] );
    }
    printf("\n");
}