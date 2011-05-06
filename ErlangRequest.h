//
//  ErlangRequest.h
//  ErlangObject
//
//  Created by Gethryn Ghavalas on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "erlangc.h"

typedef enum {
    AGENTS=0,  // optimum calc only
    SVL=1, ASA=2, OCC=3, IA=4, ERLANGC=5, ERLANGB=6, TRAFFIC=7, RHO=8
} rqItem;


@interface ErlangRequest : NSObject {
    
    double nco, aht, interval, svl_goal, asa_goal, max_occ; //inputs
    double svl, asa, occ, ia, erlangc, erlangb, traffic, rho, optimum; // calc outputs
    NSMutableArray *errorList;
    NSMutableArray *warningList;
    int errorCount, warningCount;
    BOOL validRequest;
    BOOL hasWarnings;
    
}

// getters for input variables
-(double) nco;
-(double) aht;
-(double) interval;
-(double) svl_goal;
-(double) asa_goal;
-(double) max_occ;

// calculated variables
-(double) svl;
-(double) asa;
-(double) occ;
-(double) ia;
-(double) erlangc;
-(double) erlangb;
-(double) traffic;
-(double) rho;
-(double) optimum;

// error checking
-(int) errorCount;
-(int) warningCount;
-(BOOL) validRequest;
-(BOOL) requestHasWarnings;
-(NSString *) errorListDesc;
-(NSString *) warningListDesc;

// check inputs
-(void) validateNCO: (int) ncoInput andAHT: (int) ahtInput andInterval: (int) intervalInput 
             andSVL: (double) svlInput andASA: (double) asaInput andMaxOcc: (double) maxOccInput;

// setter for all inputs together; returns YES if sucessful, NO if errors.
-(BOOL) setNCO: (int) ncoInput andAHT: (int) ahtInput andInterval: (int) intervalInput 
        andSVL: (double) svlInput andASA: (double) asaInput andMaxOcc: (double) maxOccInput; 

// dynamic result request / set
-(void) setResult: (rqItem) req; // uses optimum, and updates object
-(double) getResult: (rqItem) req withAgents: (int) m;

// optimum offsets
-(int) offsetFromOptimumWithAgents: (int) m;

// constructors
-(ErlangRequest *) initWithNCO: (int) ncoInput andAHT: (int) ahtInput andInterval: (int) intervalInput 
                    andSVLGoal: (double) svlInput andASAGoal: (double) asaInput andMaxOcc: (double) maxOccInput;

@end
