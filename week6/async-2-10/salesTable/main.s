.global main

//constants
.equ ROWS, 4
.equ COLS, 5

.section .data
    sales:
        .word 120, 150, 130, 170, 190
        .word 200, 180, 210, 190, 230
        .word 90, 100, 110, 120, 130
        .word 300, 320, 310, 330, 350
.section .rodata
    outSalesTblMsg: .asciz "Sales Data Table:\n"
    outSalesTblHeader: .asciz "Product \\ Month   Jan  Feb  Mar  Apr  May\n"
    outPSTProduct: .asciz "Product %d        "
    outPSTProds: .asciz "%4d "

    outPTSTotal: .asciz "Total sales per product:\n"
    outPTSSum: .asciz "Product %d: %d\n"

    outPASAverage: .asciz "Average Sales Per Month:\n"
    outPASMonthNumber: .asciz "month %d: %d\n"
    outPASMonth: .asciz "%s: %d\n"

    newline: .asciz "\n"

    //month array
    jan: .asciz "Jan"
    feb: .asciz "Feb"
    mar: .asciz "Mar"
    apr: .asciz "Apr"
    may: .asciz "May"

    //array of char arrays
    months: .word jan
            .word feb
            .word mar
            .word apr
            .word may

.section .bss
    totalSales: .space 16 //4*ROWS
    avgSales: .space 20//4*COLS

.text //the code begins here
main:
    stmdb sp!, {lr} //push

    @ //print my table
    ldr r0, =sales
    bl printSalesTable              @ printSalesTable( sales );

    @ //calculate the stats
    ldr r0, =sales
    ldr r1, =totalSales
    bl calcTotalSales               @ calcTotalSales( sales, totalSales );

    //call avg func
    ldr r0, =sales
    ldr r1, =avgSales
    bl calcAvgSales                 @ calcAvgSales( sales, avgSales );

    //print the stuff
    //display total sales
    ldr r0, =totalSales
    bl printTotalSales              @ printTotalSales( totalSales );

    @ //display avaergae sale
    ldr r0, =avgSales
    bl printAvgSales                @ printAvgSales( avgSales );
    
    mov r0, #0                      @ return 0;
    //different ways to pop
    @ ldmia sp!, {pc} //load multiple w/ increment after
    ldr pc, [sp], #4 //post index


@ void printSalesTable( int *sales) {
//r0, sales
printSalesTable:
    stmdb sp!, {r4-r6,lr}
    mov r4, r0 //move to a safe register

    ldr r0, =outSalesTblMsg
    bl printf                       @ printf( "Sales Data Table:\n");

    ldr r0, =outSalesTblHeader
    bl printf                       @ printf( "Product \\ Month   Jan  Feb  Mar  Apr  May\n");

    mov r5, #0 // int i = 0
    pstOuterLoop:                   @ for( int i = 0; i < ROWS; i++ ){
        cmp r5, #ROWS
        bge pstOuterEnd

        ldr r0, =outPSTProduct
        mov r1, r5
        add r1, #1
        bl printf                       @ printf( "Product %d        ", i + 1 );
        //setup another counter, j
        mov r6, #0  //int j = 0
        pstInnerLoop:                   @ for( int j = 0; j < COLS; j++ ){
            cmp r6, #COLS
            bge pstInnerEnd

            mov r2, #COLS
            mul r2, r2, r5  //i * COLS; we have to split cols into a register becuase mul does not allow immediate value
            add r2, r6  //+j            @ int idx = i * COLS + j;

            ldr r0, =outPSTProds
            //load the value from the sale array
            ldr r1, [r4, r2, lsl #2] 
            bl printf                   @ printf("%4d ", sales[idx] );

            //increment j
            add r6, #1
            bal pstInnerLoop        @ }
        pstInnerEnd:
        ldr r0, =newline
        bl printf                   @ printf( "\n" );
        //increment i
        add r5, #1
        bal pstOuterLoop            @ }
    pstOuterEnd:
    ldr r0, =newline
    bl printf                       @ printf( "\n" );


    ldmia sp!, {r4-r6,pc}
//end of print sales

//calcs the total sales for products
@ void calcTotalSales( int *sales, int *totalSales ){
//r0, sales
//r1, totalsales
calcTotalSales:
    stmdb sp!, {r4-r6,lr}
    mov r2, #0      // i = 0
    ctsOutLoop:                 @ for( int i =0; i < ROWS; i++ ){
        cmp r2, #ROWS
        bge ctsOutEnd

        mov r3, #0
        str r3, [r1, r2, lsl #2] //times by 4 w/ shifting
                                @ totalSales[i] = 0; //set it initally to 0 so we sum it
        
        mov r3, #0 //int j = 0; //redeclaring for clarity
        ctsInLoop:              @ for( int j = 0; j < COLS; j++){
            cmp r3, #COLS
            bge ctsInEnd
            
            mov r4, #COLS
            mul r4, r4, r2
            add r4, r3              @ int idx = i * COLS + j;
            //load sales
            ldr r5, [r0, r4, lsl #2]
            //load totalSales
            ldr r6, [r1, r2, lsl #2]
            add r6, r6, r5 //totalSales[i] + sales[idx];
            //store it
            str r6, [r1, r2, lsl #2] @ totalSales[i] = totalSales[i] + sales[idx];

            //j++
            add r3, #1
            bal ctsInLoop           @ }
        ctsInEnd:
        //i++
        add r2, #1
        bal ctsOutLoop          @ }
    ctsOutEnd:
    ldmia sp!, {r4-r6,pc}
//end calcTotaSles

//print total sales table
@ void printTotalSales( int *totalSales ){
printTotalSales:
    push {r4,r5,lr}
    mov r5, r0 //move totalSales to r5
    ldr r0, =outPTSTotal
    bl printf                   @ printf( "Total sales per product:\n");

    mov r4, #0
    ptsLoop:                    @ for( int i  = 0; i < ROWS; i++ ){
        cmp r4, #ROWS
        bge ptsEnd
    
        ldr r0, =outPTSSum
        mov r1, r4
        add r1, #1
        ldr r2, [r5, r4, lsl #2]
        bl printf                   @ printf( "Product %d: %d\n", i + 1, totalSales[i] );

        //i++
        add r4, #1
        bal ptsLoop             @ }
    ptsEnd:
    ldr r0, =newline
    bl printf                   @ printf( "\n" );

    pop {r4,r5,pc}
//end printTotalSales

@ void calcAvgSales( int *sales, int *avgSales ){
//r0, sales
//r1 avgSales
calcAvgSales:
    push {r4-r6,lr}

    mov r2, #0 //j =0 
    casOutLoop:                 @ for( int j = 0; j <COLS; j++ ){
        cmp r2, #COLS
        bge casOutEnd

        mov r4, #0              @ int sum = 0;
        mov r3, #0      //int i = 0;
        casInLoop:              @ for( int i = 0; i < ROWS; i++ ){
            cmp r3, #ROWS
            bge casInEnd

            mov r5, #COLS
            mul r5, r5, r3 //i*COSL
            add r5, r2 //+j         @ int idx = i * COLS + j;
            //load sales
            ldr r6, [r0, r5, lsl #2 ]
            add r4, r4, r6          @ sum += sales[idx];

            //i++
            add r3, #1
            bal casInLoop       @ }
        casInEnd:
        //making them as floats for the c version
        //r4/ROWS
        //using divMod lets divide
        push {r0-r3}
        mov r0, r4
        mov r1, #ROWS
        bl divMod       //sum / ROWS;
        mov r5, r0 //put my division into r5
        pop {r0-r3} //restore my registers

        str r5, [r1, r2, lsl #2] @ avgSales[j] = sum / ROWS;

        //j++
        add r2, #1
        bal casOutLoop          @ }
    casOutEnd:
    pop {r4-r6,pc}
//end calcAvgSales


@ void printAvgSales( int *avgSales ){
//r0 avgSales
printAvgSales:
    push {r4-r6,lr}
    //mov to safe registers
    mov r5, r0 //move avgsales
    ldr r6, =months

    ldr r0, =outPASAverage
    bl printf                   @ printf( "Average Sales Per Month:\n");
    @ char *months[] = {"Jan", "Feb",  "Mar",  "Apr",  "May" };

    mov r4, #0 //int j =0
    pasLoop:                    @ for( int j = 0; j < COLS; j++ ){
        cmp r4, #COLS
        bge pasEnd

        //month number loading
        @ ldr r0, =outPASMonthNumber
        @ mov r1, r4 //month number
        @ add r1, #1
        @ ldr r2, [r5, r4, lsl #2]
        @ bl printf                   @ printf( "month %d: %d\n", j+1, avgSales[j] );

        //month name loading
        ldr r0, =outPASMonth
        ldr r1, [r6, r4, lsl #2] //load the month[j]
        ldr r2, [r5, r4, lsl #2]
        bl printf                   @ printf( "month %d: %d\n", j+1, avgSales[j] );

        //j++
        add r4, #1
        bal pasLoop             @ }
    pasEnd:
    ldr r0, =newline
    bl printf                   @ printf("\n");
    pop {r4-r6,pc}
//end printAvgSales
