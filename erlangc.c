/*
 *  erlangc.c
 *  ErlangC_Simple
 *
 *  Created by Gethryn Ghavalas on 15/05/10.
 *  Copyright 2010 Geth Home. All rights reserved.
 *
 */

#include "erlangc.h"
#include "gammadist.h"


// calculates the value of n!
double factorial(double n) {
	if (n==0) {
		return 1;
	}
	else {
		return n * factorial(n-1);
	}
}

// calculates the probability that m will equal u using the Poisson Distribution
// use cuml = false for standard, and cuml = true for cumulative result.
double poisson(double m, double u, bool cuml) {
	
	long double ld_m =(long double)m, ld_u =(long double)u, result=0.0;
	//double result=0;
	int k;
	
	if (cuml==false) {
		// standard result
		result = ((expl(-ld_u) * powl(ld_u,ld_m)) / factrl((int)m));
	}
	else {
		// cumulative result
		for (k=0; k<=m; k++) {
			result += poisson(k,u,false);
		}
	}
	return (double)result;
}

// calculates traffic intensity using events per interval (cpi), the length of the interval
// in seconds -- usually 30 mins = 1800 (interval), and the length of each event -- average
// handling time (aht).
double traffic_intensity(double cpi, double interval, double aht) {
	//
	return (cpi / interval * aht);
}

// calculates likelihood an event will experience delay before handling given a certain number
// of events per interval (cpi), the length of the interval in seconds -- usually 30 mins = 1800
// (interval), the length of each event -- average handling time (aht), and the number of agents
// processing the event (m).  Expressed as a % probability.
double erlangc_alt(double cpi, double interval, double aht, double m) {
	double result = 0;
	double u = traffic_intensity(cpi,interval,aht);
	double rho = (u / m); // occupancy
	
	result = poisson(m, u, false) / (poisson(m, u, false)+((1-rho)*poisson(m-1, u, true)));
	
	return result;
}

double erlangCCalc(double cpi, double interval, double aht, double m) {
	
	double num, denom, u, rho;
	
	u = traffic_intensity(cpi, interval, aht);
	rho = u / m;
	
	num = exp((m * log(u)) - gammln(m+1)-u);
	denom = num + ((1-rho) * gammq(m, u));
	
	return num/denom;
	
}

// calculates the inverse of erlangC: probability a call will not experience delay
double immAnsCalc(double cpi, double interval, double aht, double m) {
    return (1.0 - erlangCCalc(cpi, interval, aht, m));
}

// calculates the Erlang B formula -- the likelihood that a call will be lost.
// Adapted from http://en.wikipedia.org/wiki/Erlang_unit
double erlangBCalc(double m, double u) {
	double invb = 1.0;
	int j;
	
	for (j=0; j<=m; j++) {
		invb = 1.0 + j / u * invb;
	}
	return 1.0 / invb;
}

// calculates the probability a call/event will be answered/processed within a goal answer time
// takes same arguments as erlang c function, and adds the goal answer time (asa_goal) in secs.
double svlCalc(double cpi, double interval, double aht, double m, double asa_goal) {
	double result = 0.0;
	double u = traffic_intensity(cpi, interval, aht);
	
	result = (1.0 - (erlangCCalc(cpi, interval, aht, m) * exp((-(m-u)) * (asa_goal / aht))));
	
	return result;
}

// calculates how busy each agent is -- % of time occupied, given a certain number of calls/events
// (cpi) within an interval (interval) of average length (aht), and with m agents working.
// sometimes referred to as rho.
double agent_occCalc(double cpi, double interval, double aht, double m) {
	return ((cpi/interval*aht) / m);
}

// calculates the average speed of answer in secs, given a certain number of calls/events
// (cpi) within an interval (interval) of average length (aht), and with m agents working.
double asaCalc(double cpi, double interval, double aht, double m) {
	double result = 0;
	double u = traffic_intensity(cpi, interval, aht);
	double rho = (u / m); // occupancy
	
	result = (erlangCCalc(cpi, interval, aht, m) * aht) / (m * (1-rho));
	
	return result;
}

// this function returns rho (u / m ), where u is traffic intensity and m is number of agents
double rhoCalc(double cpi, double interval, double aht, int m) {
    return (traffic_intensity(cpi, interval, aht) / ((double) m));
}


// this funtion provides a table of output giving from optimum-5 to optimum+10 agents and the
// corresponding occupancy, service level and average speed of answer for each of these numbers
// of agents.  The function returns the optiumum number of agents for future use.
int how_many_agents (double cpi, double interval, double aht, double svl_goal, 
					 double asa_goal, double occ_goal) {
	
	int i = 1, optimum_m;
	bool optimum_svl = false;
	
	// starts at 1 agent, and repeats until the number of agents (i) gives a svl that exceeds
	// or equals that requested by the user.
	while (optimum_svl == false) {
		if ((svlCalc(cpi,interval,aht,i,asa_goal) >= (svl_goal/100.0)) && 
			agent_occCalc(cpi, interval, aht, i)<1.0 && 
			agent_occCalc(cpi, interval, aht, i)<=(occ_goal/100.0) &&
			asaCalc(cpi,interval,aht,i) <= asa_goal) {
			optimum_svl = true;
			optimum_m = i;
		}
		//debug
		//printf("i=%i\tsvl=%g\tocc=%g\tasa=%g\n",i, svl(cpi,interval,aht,i,asa_goal), 
		//	   agent_occ(cpi, interval, aht, i),asa(cpi,interval,aht,i));
		i++;
		if (i>2500) {
			return 0;
		}
	}
	return	optimum_m;
}


