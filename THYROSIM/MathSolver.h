
//
//  DifferentialEquationSetUp.h
//  THYROSIM
//
//  Created by Dylan Hoang on 12/20/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#ifndef __THYROSIM__DifferentialEquationSetUp__
#define __THYROSIM__DifferentialEquationSetUp__

#include <stdio.h>
#include "rk45.h"


using namespace std;
//Global Variables to use in equation set up

/***    Initial Conditions  ***/
 
static float IC1 = 0.322114215761171;
static float IC2 = 0.201296960359917;
static float IC3 = 0.638967411907560;
static float IC4 = 0.00663104034826483;
static float IC5 = 0.0112595761822961;
static float IC6 = 0.0652960640300348;
static float IC7 = 1.78829584764370;
static float IC8 = 7.05727560072869;
static float IC9 = 7.05714474742141;
static float IC10 = 0;
static float IC11 = 0;
static float IC12 = 0;
static float IC13 = 0;
static float IC14 = 3.34289716182018;
static float IC15 = 3.69277248068433;
static float IC16 = 3.87942133769244;
static float IC17 = 3.90061903207543;
static float IC18 = 3.77875734283571;
static float IC19 = 3.55364471589659;

const int NUM_EQUATIONS = 19;

class ODE
{
public:
    //Default Constructor -> will never be called
    ODE();
    
    //Constructor which takes in our parameters from user input -> T4S, T4A, T3S, T3A
    ODE(float dial1, float dial2, float dial3, float dial4);
    
     static void computeDerivatives(float t, float q[], float qDot[]);
    
    void resetDose(float *q, float dose, int eventId);
    
    void getTheNumbers();
    
    //Private Variables to be used by manipulated in the creation of the 19 equations

     static float p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16;
     static float p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32;
     static float p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46;
      static float p47;
      static float p48;
     static float d1, d2, d3, d4, u1, u4, kdelay;

};

void getTheNumbers();




#endif /* defined(__THYROSIM__DifferentialEquationSetUp__) */
