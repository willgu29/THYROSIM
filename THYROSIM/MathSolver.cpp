//
//  DifferentialEquationSetUp.cpp
//  THYROSIM
//
//  Created by Dylan Hoang on 12/20/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

#include "MathSolver.hpp"
#include <math.h>
#include <map>
#include <vector>

float ODE::p1, ODE::p2, ODE::p3, ODE::p4, ODE::p5, ODE::p6, ODE::p7, ODE::p8, ODE::p9, ODE::p10, ODE::p11, ODE::p12, ODE::p13, ODE::p14, ODE::p15, ODE::p16;
float ODE::p17, ODE::p18, ODE::p19, ODE::p20, ODE::p21, ODE::p22, ODE::p23, ODE::p24, ODE::p25, ODE::p26, ODE::p27, ODE::p28, ODE::p29, ODE::p30, ODE::p31, ODE::p32;
float ODE::p33, ODE::p34, ODE::p35, ODE::p36, ODE::p37, ODE::p38, ODE::p39, ODE::p40, ODE::p41, ODE::p42, ODE::p43, ODE::p44, ODE::p45, ODE::p46;
float ODE::p47;
float ODE::p48;
float ODE::d1, ODE::d2, ODE::d3, ODE::d4, ODE::u1, ODE::u4, ODE::kdelay;

storeData::storeData(float simulTime, float T4S, float T4A, float T3S, float T3A )
{
    ODE_cur = new ODE(T4S, T4A, T3S, T3A);
    num_hours = (int) simulTime * 24;
}

//Stores final three array values!
//myInputArray is in form
//   ID, dose, dose_interval, start_time, end_time, ID, dose, dose_interval, start_time, end_time,.....,
void storeData::getTheNumbers(float *myInputArray, int count)
{
    //Time 1 and time 2 initialized, as start and ending hours
    int t1 = 0;
    int t2 = num_hours;
    
    //Initial State
    float *q =  new float[NUM_EQUATIONS];
    q[0] = IC1;
    q[1] = IC2;
    q[2] = IC3;
    q[3] = IC4;
    q[4] = IC5;
    q[5] = IC6;
    q[6] = IC7;
    q[7] = IC8;
    q[8] = IC9;
    q[9] = IC10;
    q[10] = IC11;
    q[11] = IC12;
    q[12] = IC13;
    q[13] = IC14;
    q[14] = IC15;
    q[15] = IC16;
    q[16] = IC17;
    q[17] = IC18;
    q[18] = IC19;
    
    float *qDot = new float[NUM_EQUATIONS];
    
    //Now qDot has the derivatives of the initial q array
    ODE_cur->computeDerivatives(t1, q, qDot);
    
    //Here is where the map is initialized
    std::map <int, std::vector<InputEvent>> map;
    
    //For loop which maps every hour (int) to a list of input events
    for (int i = 0; i < count; i+=5)
    {
        switch ((int)myInputArray[i])
        {
                //ORAL LIST
            case 1:
            case 2:
            case 3:
            case 4:
            {
                //Iterates between the start time and end time of each input event, in intervals denoted by dose interval
                for (double time = myInputArray[i+3]; time <= myInputArray[i+4]; time += myInputArray[i+2])
                {
                    int hour = (int) round(time*24);
                    map[hour].push_back(InputEvent(hour, (int)myInputArray[i],myInputArray[i+1]));
                }
            }
                break;
                
                //Infusion List
            case 5:
            case 6:
            {
                int hour_start = (int) round(myInputArray[i+3]*24);
                int hour_end = (int) round(myInputArray[i+4]*24);
                map[hour_start].push_back(InputEvent(hour_start, (int)myInputArray[i],myInputArray[i+1] ));
                map[hour_end].push_back(InputEvent(hour_end, (int)myInputArray[i]+2,myInputArray[i+1] ));
            }
                break;
            default:
                break;
        }
    }
    
    float relative_error = 1;
    float absolute_error = 2;
    
    T4 = new float[(int)t2 - (int)t1 + 1];
    T3 = new float[(int)t2 - (int)t1 + 1];
    TSH = new float[(int)t2 - (int)t1 + 1];
    
    
    for (int i = t1; i <= t2; i++)
    {
        //add input events
        
        //Search the map to see if the current hour is contained as a key
        std::map <int, std::vector<InputEvent>>::iterator map_iterator = map.find(i);
        
        //If it is then..
        if (map_iterator != map.end())
        {
            
            //For each InputEvent in its vector value
            for (std::vector<InputEvent>::iterator vector_iterator = map[i].begin(); vector_iterator != map[i].end(); vector_iterator++)
            {
                //Reset the Dose-> affecting the q array
                ODE_cur->resetDose(q, vector_iterator->dose, vector_iterator->eventID);
            }
        }
        
        float x = (float) i;
        float y = x + 1;
        // converting mols to units
        T4[i] = round(q[0] * 777 / ODE_cur->getp47() * 1000) / 1000.0;
        T3[i] = round(q[3] * 651 / ODE_cur->getp47() * 1000) / 1000.0;
        TSH[i] = round(q[6] * 5.6 / ODE_cur->getp48() * 1000) / 1000.0;
        r4_rkf45(&ODE::computeDerivatives, NUM_EQUATIONS, q, qDot, &x, y, &relative_error, absolute_error, 1);
    }
    
}

//Constructor for ODE class which initializes the variables according to T4S, T4A, T3S, T3A as defined by the user
ODE::ODE(float dial1, float dial2, float dial3, float dial4)
{
    d1 = (float)dial1/100.0;
    d2 = (float)dial2/100.0;
    d3 = (float)dial3/100.0;
    d4 = (float)dial4/100.0;
    if (d2 != 0)
        d2 = ((0.88*(1-d2))/d2)/0.12;
    if (d4 != 0)
        d4 = ((0.88*(1-d4))/d4)/0.12;
    u1 = 0;
    u4 = 0;
    kdelay = 0.625;
    p1 = 0.00174155; // S4
    p2 = 8; // tau
    p3 = 0.868; // k12
    p4 = 0.108; // k13
    p5 = 584; // k31free
    p6 = 1503; // k21free
    p7 = 0.000289; // A
    p8 = 0.000214; // B
    p9 = 0.000128; // C
    p10 = -8.83 * pow(10, -6); // D
    p11 = 0.88; // k4absorb; originally 0.881
    p12 = 0.0189; // k02
    p13 = 0.00998996; // VmaxD1fast
    p14 = 2.85; // KmD1fast
    p15 = 6.63 * pow(10, -4); // VmaxD1slow
    p16 = 95; // KmD1slow
    p17 = 0.00074619; // VmaxD2slow
    p18 = 0.075; // KmD2slow
    p19 = 3.3572 * pow(10, -4); // S3
    p20 = 5.37; // k45
    p21 = 0.0689; // k46
    p22 = 127; // k64free
    p23 = 2043; // k54free
    p24 = 0.00395; // a
    p25 = 0.00185; // b
    p26 = 0.00061; // c
    p27 = -0.000505; // d
    p28 = 0.88; // k3absorb; originally 0.882
    p29 = 0.207; // k05
    p30 = 1166; // Bzero
    p31 = 581; // Azero
    p32 = 2.37; // Amax
    p33 = -3.71; // phi
    p34 = 0.53; // kdegTSH-HYPO
    p35 = 0.037; // VmaxTSH
    p36 = 23; // K50TSH
    p37 = 0.118; // k3
    p38 = 0.29; // T4P-EU
    p39 = 0.006; // T3P-EU
    p40 = 0.037; // KdegT3B
    p41 = 0.0034; // KLAG-HYPO
    p42 = 5; // KLAG
    p43 = 1.3; // k4dissolve
    p44 = 0.12 * d2; // k4excrete; originally 0.119
    p45 = 1.78; // k3dissolve
    p46 = 0.12 * d4; // k3excrete; originally 0.118
    // p47 and p48 are only used in converting mols to units.
    p47 = 3.2; // Vp
    p48 = 4.3; // VTSH
}

//Calculates the derivative equations and stores them into member variable qDot
void ODE::computeDerivatives(float t, float q[], float qDot[])
{
    // Auxillary equations
    float q4F = (p24 + p25 * q[0] + p26 * pow(q[0], 2) + p27 * pow(q[0], 3)) * q[3]; // FT3p
    float q1F = (p7 + p8 * q[0] + p9 * pow(q[0], 2) + p10 * pow(q[0], 3)) * q[0]; // FT4p
    float SR3 = (p19 * q[18]) * d3; // Brain delay
    float SR4 = (p1 * q[18]) * d1; // Brain delay
    float fCIRC = 1 + (p32 / (p31 * exp(-q[8])) - 1) * (1 / (1 + exp(10 * q[8] - 55)));
    float SRTSH = (p30 + p31 * fCIRC * sin( M_PI / 12 * t - p33)) * exp(-q[8]);
    float fdegTSH = p34 + p35 / (p36 + q[6]);
    float fLAG = p41 + 2 * pow(q[7], 11) / (pow(p42, 11) + pow(q[7], 11));
    float f4 = p37 + 5 * p37 / (1 + exp(2 * q[7] - 7));
    float NL = p13 / (p14 + q[1]);
    
    // ODEs
    // q1dot
    qDot[0] = SR4 + p3 * q[1] + p4 * q[2] - (p5 + p6) * q1F + p11 * q[10] + u1;
    // q2dot
    qDot[1] = p6 * q1F - (p3 + p12 + NL) * q[1];
    // q3dot
    qDot[2] = p5 * q1F - (p4 + p15 / (p16 + q[2]) + p17 / (p18 + q[2])) * q[2];
    // q4dot
    qDot[3] = SR3 + p20 * q[4] + p21 * q[5] - (p22 + p23) * q4F + p28 * q[12] + u4;
    // q5dot
    qDot[4] = p23 * q4F + NL * q[1] - (p20 + p29) * q[4];
    // q6dot
    qDot[5] = p22 * q4F + p15 * q[2] / (p16 + q[2]) + p17 * q[2] / (p18 + q[2]) - p21 * q[5];
    // q7dot
    qDot[6] = SRTSH - fdegTSH * q[6];
    // q8dot
    qDot[7] = f4 / p38 * q[0] + p37 / p39 * q[3] - p40 * q[7];
    // q9dot
    qDot[8] = fLAG * (q[7] - q[8]);
    // q10dot
    qDot[9] = -p43 * q[9];
    // q11dot
    qDot[10] = p43 * q[9] - (p44 + p11) * q[10];
    // q12dot
    qDot[11] = -p45 * q[11];
    // q13dot
    qDot[12] = p45 * q[11] - (p46 + p28) * q[12];
    
    // Delay ODEs
    // q14dot
    qDot[13] = -kdelay * q[13] + q[6];
    // q15dot
    qDot[14] = kdelay * (q[13] - q[14]);
    // q16dot
    qDot[15] = kdelay * (q[14] - q[15]);
    // q17dot
    qDot[16] = kdelay * (q[15] - q[16]);
    // q18dot
    qDot[17] = kdelay * (q[16] - q[17]);
    // q19dot
    qDot[18] = kdelay * (q[17] - q[18]);
}

void ODE::resetDose(float *q, float dose, int eventId)
{
    // need converting mcg to mols
    switch (eventId) {
        case 1:  // Add T3 Oral °™°™ q12
            q[11] += dose / 651;
            break;
        case 2:  // Add T4 Oral °™°™ q10
            q[9] += dose / 777;
            break;
        case 3:  // Add T3 IV °™°™ q4
            q[3] += dose / 651;
            break;
        case 4:  // Add T4 IV °™°™ q1
            q[0] += dose / 777;
            break;
        case 5:  // Add T3 Infusion °™°™ u4
            u4 += dose / 651 / 24;
            break;
        case 6:  // Add T4 Infusion °™°™ u1
            u1 += dose / 777 / 24;
            break;
        case 7:  // Remove T3 Infusion °™°™ u4
            u4 -= dose / 651 / 24;
            break;
        case 8:  // Remove T4 Infusion °™°™ u1
            u1 -= dose / 777 / 24;
            break;
        default:
            break;
    }
}

