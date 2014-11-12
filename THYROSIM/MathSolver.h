//
//  MathSolver.h
//  THYROSIM
//
//  Created by Dylan Hoang on 10/31/14.
//  Copyright (c) 2014 William Gu. All rights reserved.
//

//#ifndef __THYROSIM__MathSolver__
#define __THYROSIM__MathSolver__

//@package com.thu.chenlu.algorithm
//#import "org.apache.commons.math3.ode.FirstOrderDifferentialEquations"
//#import "org.apache.commons.math3.ode.FirstOrderIntegrator"
//#import "org.apache.commons.math3.ode.nonstiff.ClassicalRungeKuttaIntegrator"
//#import "org.apache.commons.math3.ode.nonstiff.DormandPrince853Integrator"
//#import "android.R.integer"
#include <stdio.h>

//public class ODE implements FirstOrderDifferentialEquations {
//    private double p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16;
//    private double p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32;
//    private double p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46;
//    public static double p47;
//    public static double p48;
//    private double d1, d2, d3, d4, u1, u4, kdelay;
//    public static double IC1 = 0.322114215761171;
//    public static double IC2 = 0.201296960359917;
//    public static double IC3 = 0.638967411907560;
//    public static double IC4 = 0.00663104034826483;
//    public static double IC5 = 0.0112595761822961;
//    public static double IC6 = 0.0652960640300348;
//    public static double IC7 = 1.78829584764370;
//    public static double IC8 = 7.05727560072869;
//    public static double IC9 = 7.05714474742141;
//    public static double IC10 = 0;
//    public static double IC11 = 0;
//    public static double IC12 = 0;
//    public static double IC13 = 0;
//    public static double IC14 = 3.34289716182018;
//    public static double IC15 = 3.69277248068433;
//    public static double IC16 = 3.87942133769244;
//    public static double IC17 = 3.90061903207543;
//    public static double IC18  = 3.77875734283571;
//    public static double IC19 = 3.55364471589659;
//    
//    public ODE(Integer dial1, Integer dial2, Integer dial3, Integer dial4) {
//        d1 = (double)dial1/100.0;
//        d2 = (double)dial2/100.0;
//        d3 = (double)dial3/100.0;
//        d4 = (double)dial4/100.0;
//        if (d2 != 0)
//        d2 = ((0.88*(1-d2))/d2)/0.12;
//        if (d4 != 0)
//        d4 = ((0.88*(1-d4))/d4)/0.12;
//        u1 = 0;
//        u4 = 0;
//        
//        kdelay = 0.625;
//        p1 = 0.00174155; // S4
//        p2 = 8; // tau
//        p3 = 0.868; // k12
//        p4 = 0.108; // k13
//        p5 = 584; // k31free
//        p6 = 1503; // k21free
//        p7 = 0.000289; // A
//        p8 = 0.000214; // B
//        p9 = 0.000128; // C
//        p10 = -8.83 * Math.pow(10, -6); // D
//        p11 = 0.88; // k4absorb; originally 0.881
//        p12 = 0.0189; // k02
//        p13 = 0.00998996; // VmaxD1fast
//        p14 = 2.85; // KmD1fast
//        p15 = 6.63 * Math.pow(10, -4); // VmaxD1slow
//        p16 = 95; // KmD1slow
//        p17 = 0.00074619; // VmaxD2slow
//        p18 = 0.075; // KmD2slow
//        p19 = 3.3572 * Math.pow(10, -4); // S3
//        p20 = 5.37; // k45
//        p21 = 0.0689; // k46
//        p22 = 127; // k64free
//        p23 = 2043; // k54free
//        p24 = 0.00395; // a
//        p25 = 0.00185; // b
//        p26 = 0.00061; // c
//        p27 = -0.000505; // d
//        p28 = 0.88; // k3absorb; originally 0.882
//        p29 = 0.207; // k05
//        p30 = 1166; // Bzero
//        p31 = 581; // Azero
//        p32 = 2.37; // Amax
//        p33 = -3.71; // phi
//        p34 = 0.53; // kdegTSH-HYPO
//        p35 = 0.037; // VmaxTSH
//        p36 = 23; // K50TSH
//        p37 = 0.118; // k3
//        p38 = 0.29; // T4P-EU
//        p39 = 0.006; // T3P-EU
//        p40 = 0.037; // KdegT3B
//        p41 = 0.0034; // KLAG-HYPO
//        p42 = 5; // KLAG
//        p43 = 1.3; // k4dissolve
//        p44 = 0.12 * d2; // k4excrete; originally 0.119
//        p45 = 1.78; // k3dissolve
//        p46 = 0.12 * d4; // k3excrete; originally 0.118
//        // p47 and p48 are only used in converting mols to units.
//        p47 = 3.2; // Vp
//        p48 = 4.3; // VTSH
//    }
//    
//    public int getDimension() {
//        return 19;
//    }
//    
//    public void resetDose(double[] q, double dose, int eventId) {
//        // need converting mcg to mols
//        switch (eventId) {
//            case 1:  // Add T3 Oral °™°™obj q12
//            q[11] += dose / 651;
//            break;
//            case 2:  // Add T4 Oral °™°™ q10
//            q[9] += dose / 777;
//            break;
//            case 3:  // Add T3 IV °™°™ q4
//            q[3] += dose / 651;
//            break;
//            case 4:  // Add T4 IV °™°™ q1
//            q[0] += dose / 777;
//            break;
//            case 5:  // Add T3 Infusion °™°™ u4
//            u4 += dose / 651 / 24;
//            break;
//            case 6:  // Add T4 Infusion °™°™ u1
//            u1 += dose / 777 / 24;
//            break;
//            case 7:  // Remove T3 Infusion °™°™ u4
//            u4 -= dose / 651 / 24;
//            break;
//            case 8:  // Remove T4 Infusion °™°™ u1
//            u1 -= dose / 777 / 24;
//            break;
//            default:
//            break;
//        }
//    }
//    
//    public void computeDerivatives(double t, double[] q, double[] qDot) {
//        // Auxillary equations
//        double q4F = (p24 + p25 * q[0] + p26 * Math.pow(q[0], 2) + p27 * Math.pow(q[0], 3)) * q[3]; // FT3p
//        double q1F = (p7 + p8 * q[0] + p9 * Math.pow(q[0], 2) + p10 * Math.pow(q[0], 3)) * q[0]; // FT4p
//        double SR3 = (p19 * q[18]) * d3; // Brain delay
//        double SR4 = (p1 * q[18]) * d1; // Brain delay
//        double fCIRC = 1 + (p32 / (p31 * Math.exp(-q[8])) - 1) * (1 / (1 + Math.exp(10 * q[8] - 55)));
//        double SRTSH = (p30 + p31 * fCIRC * Math.sin(Math.PI / 12 * t - p33)) * Math.exp(-q[8]);
//        double fdegTSH = p34 + p35 / (p36 + q[6]);
//        double fLAG = p41 + 2 * Math.pow(q[7], 11) / (Math.pow(p42, 11) + Math.pow(q[7], 11));
//        double f4 = p37 + 5 * p37 / (1 + Math.exp(2 * q[7] - 7));
//        double NL = p13 / (p14 + q[1]);
//        
//        // ODEs
//        // q1dot
//        qDot[0] = SR4 + p3 * q[1] + p4 * q[2] - (p5 + p6) * q1F + p11 * q[10] + u1;
//        // q2dot
//        qDot[1] = p6 * q1F - (p3 + p12 + NL) * q[1];
//        // q3dot
//        qDot[2] = p5 * q1F - (p4 + p15 / (p16 + q[2]) + p17 / (p18 + q[2])) * q[2];
//        // q4dot
//        qDot[3] = SR3 + p20 * q[4] + p21 * q[5] - (p22 + p23) * q4F + p28 * q[12] + u4;
//        // q5dot
//        qDot[4] = p23 * q4F + NL * q[1] - (p20 + p29) * q[4];
//        // q6dot
//        qDot[5] = p22 * q4F + p15 * q[2] / (p16 + q[2]) + p17 * q[2] / (p18 + q[2]) - p21 * q[5];
//        // q7dot
//        qDot[6] = SRTSH - fdegTSH * q[6];
//        // q8dot
//        qDot[7] = f4 / p38 * q[0] + p37 / p39 * q[3] - p40 * q[7];
//        // q9dot
//        qDot[8] = fLAG * (q[7] - q[8]);
//        // q10dot
//        qDot[9] = -p43 * q[9];
//        // q11dot
//        qDot[10] = p43 * q[9] - (p44 + p11) * q[10];
//        // q12dot
//        qDot[11] = -p45 * q[11];
//        // q13dot
//        qDot[12] = p45 * q[11] - (p46 + p28) * q[12];
//        
//        // Delay ODEs
//        // q14dot
//        qDot[13] = -kdelay * q[13] + q[6];
//        // q15dot
//        qDot[14] = kdelay * (q[13] - q[14]);
//        // q16dot
//        qDot[15] = kdelay * (q[14] - q[15]);
//        // q17dot
//        qDot[16] = kdelay * (q[15] - q[16]);
//        // q18dot
//        qDot[17] = kdelay * (q[16] - q[17]);
//        // q19dot
//        qDot[18] = kdelay * (q[17] - q[18]);
//    }
//    
//    public static void main(String[] args) {
//        int t1 = 0, t2 = 120;
//        FirstOrderIntegrator integrator = new DormandPrince853Integrator(1.0e-8, 100.0, 1.0e-10, 1.0e-10);
//        // FirstOrderIntegrator integrator = new GraggBulirschStoerIntegrator(1.0e-8, 100.0, 1.0e-10, 1.0e-10);
//        double[] q = new double[] { IC1, IC2, IC3, IC4, IC5, IC6, IC7, IC8,
//            IC9, IC10, IC11, IC12, IC13, IC14, IC15, IC16, IC17, IC18, IC19 }; // initial state
//        
//        ODE ode = new ODE(100, 88, 100, 88);
//        // ode.resetDose(q, 100, 1);
//        double[] T4 = new double[t2 - t1 + 1];
//        double[] T3 = new double[t2 - t1 + 1];
//        double[] TSH = new double[t2 - t1 + 1];
//        for (int i = t1; i <= t2; i++) {
//            // converting mols to units
//            T4[i] = q[0] * 777 / p47;
//            T3[i] = q[3] * 651 / p47;
//            TSH[i] = q[6] * 5.6 / p48;
//            integrator.integrate(ode, i, q, i + 1, q); // now q contains final state at time i
//        }
//        String T4Value = "T4 = [ " + T4[t1];
//        String T3Value = "T3 = [ " + T3[t1];
//        String TSHValue = "TSH = [ " + TSH[t1];
//        for (int i = t1 + 1; i <= t2; i++) {
//            T4Value += ("; " + T4[i]);
//            T3Value += ("; " + T3[i]);
//            TSHValue += ("; " + TSH[i]);
//        }
//        T4Value += (" ];");
//        T3Value += (" ];");
//        TSHValue += (" ];");
//        System.out.println(T4Value);
//        System.out.println(T3Value);
//        System.out.println(TSHValue);
//        System.out.println("subplot(3,1,1), plot(T4);subplot(3,1,2),plot(T3);subplot(3,1,3),plot(TSH);");
//    }
//}
//
//#endif /* defined(__THYROSIM__MathSolver__) */
