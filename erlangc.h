/*
 *  erlangc.h
 *  ErlangC_Simple
 *
 *  Created by Gethryn Ghavalas on 15/05/10.
 *  Copyright 2010 Geth Home. All rights reserved.
 *
 */


#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>


// Function prototypes
double factorial(double n);
double poisson(double m, double u, bool cuml);
double traffic_intensity(double cpi, double interval, double aht);
double erlangc_altCalc(double cpi, double interval, double aht, double m);
double erlangCCalc(double cpi, double interval, double aht, double m);
double erlangBCalc(double m, double u);
double immAnsCalc(double cpi, double interval, double aht, double m);
double svlCalc(double cpi, double interval, double aht, double m, double asa_goal);
double agent_occCalc(double cpi, double interval, double aht, double m);
double asaCalc(double cpi, double interval, double aht, double m);
double rhoCalc(double cpi, double interval, double aht, int m);
int how_many_agents (double cpi, double interval, double aht, double svl_goal, 
					 double asa_goal,double occ_goal);