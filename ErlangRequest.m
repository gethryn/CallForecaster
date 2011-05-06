//
//  ErlangRequest.m
//  ErlangObject
//
//  Created by Gethryn Ghavalas on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ErlangRequest.h"
//#import "ErlangRequest+Reports.h"


@implementation ErlangRequest

// getters for inputs
-(double) nco { return nco; }
-(double) aht { return aht; }
-(double) interval { return interval; }
-(double) svl_goal { return svl_goal; }
-(double) asa_goal { return asa_goal; }
-(double) max_occ { return max_occ; }

// getters for calculated variables
-(double) svl { return svl; }
-(double) asa { return asa; }
-(double) occ { return occ; }
-(double) ia { return ia; }
-(double) erlangc { return erlangc; }
-(double) erlangb { return erlangb; }
-(double) traffic { return traffic; }
-(double) rho { return rho; }
-(double) optimum { return optimum; }

// error checking
-(int) errorCount { return errorCount; }
-(int) warningCount { return warningCount; }
-(BOOL) validRequest { return validRequest; }
-(BOOL) requestHasWarnings { return hasWarnings; }
-(NSString *) errorListDesc { return [errorList description]; }
-(NSString *) warningListDesc { return [warningList description]; }

// check inputs
-(void) validateNCO: (int) ncoInput
            andAHT: (int) ahtInput 
       andInterval: (int) intervalInput 
            andSVL: (double) svlInput 
            andASA: (double) asaInput 
         andMaxOcc: (double) maxOccInput
{
    
    errorList = [NSMutableArray arrayWithCapacity:2];
    warningList = [NSMutableArray arrayWithCapacity:4];
    
    // nco >0, <10000; error if out of range (can't proceed)
    if (ncoInput <= 0 || ncoInput > 10000) {
        // raise error: NCO out of range
        [errorList addObject:[NSString stringWithFormat: @"ERROR: NCO must be between 1 and 10000 calls [%i].",ncoInput]];
    };
    
    // interval: 900, 1800 or 3600 secs; default=1800.
    if (intervalInput != 900 && intervalInput != 1800 && intervalInput !=3600) {
        interval = 1800;
        // raise warning: interval can be either 900, 1800 or 3600 seconds; used 1800 secs.
        [warningList addObject:@"WARNING: Interval length should be 900, 1800 or 3600 secs in length; default used [1800]."];
    };
    
    // aht <=0,  >1800; error if out of range (can't proceed)
    if (ahtInput <= 0 || ahtInput > 1800) {
        // raise error: AHT out of range
        [errorList addObject:[NSString stringWithFormat:@"ERROR: AHT must be between 1 and 1800 secs [%i].",ahtInput]];
    };
    
    // svl_goal: >0, < 100; default=80;
    if (svlInput <= 0.0 || svlInput > 100.0) {
        svl_goal = 80.0;
        // raise warning: svl value must be between 1 and 100%; corrected to 80%
        [warningList addObject:@"WARNING: Service Level goal should be between 1% and 100%; default used [80]."];
    }
    
    // asa_goal: >0, <=600; default=20;
    if (asaInput <= 0.0 || asaInput > 600.0) {
        asa_goal = 20.0;
        // raise warning: asa must be between 1 and 600 secs; corrected to 20 secs;
        [warningList addObject:@"WARNING: Average Speed of Answer (ASA) goal should be between 1 and 600 secs; default used [20]."];
    }
    
    // max_occ: >0, <=100; default=100;
    if (maxOccInput <= 0.0 || maxOccInput > 100.0) {
        max_occ = 100.0;
        // raise warning: max occ value must be between 1 and 100%; corrected to 100%
        [warningList addObject:@"WARNING: Maximum Occupancy should be between 1% and 100%; default used [100]."];
    }
    
    errorCount = 0 + ((int) [errorList count]);
    warningCount = 0 + ((int) [warningList count]);
    validRequest = errorCount == 0 ? YES : NO;
    hasWarnings = warningCount > 0 ? YES : NO;
}

// setter for all inputs together
-(BOOL) setNCO: (int) ncoInput 
        andAHT: (int) ahtInput 
   andInterval: (int) intervalInput 
        andSVL: (double) svlInput 
        andASA: (double) asaInput 
     andMaxOcc: (double) maxOccInput
{
    // get input values
    nco = (double) ncoInput;
    aht = (double) ahtInput;
    interval = (double) intervalInput;
    svl_goal = svlInput;
    asa_goal = asaInput;
    max_occ = maxOccInput;
    
    // validate input values
    // if inputs (or inputs+defaults) are valid, calculate the results
    if ([self validRequest]) {
        
        // calculate result values for Optimum Agents
        [self setResult:AGENTS];
        [self setResult:SVL];
        [self setResult:ASA];
        [self setResult:OCC];
        [self setResult:IA];
        [self setResult:ERLANGC];
        [self setResult:ERLANGB];
        [self setResult:TRAFFIC];
        [self setResult:RHO];
        return YES;
        
    } else {
        
        return NO;
    }
    
}

// dynamic result request
-(double) getResult: (rqItem) req withAgents: (int) m {
    
    // AGENTS=0, SVL=1, ASA=2, OCC=3, IA=4, ERLANGC=5, ERLANGB=6, TRAFFIC=7, RHO=8
    
    if ( m < 0 || m > 9999 ) {
        // raise error: must use between 1 and 9999 agents
        return 0.0;
    }
    
    double result = 0.0;
    
    switch (req) {
        case SVL:
            result = svlCalc(nco, interval, aht, m, asa_goal); 
            break;
        case ASA:
            result = asaCalc(nco, interval, aht, m);
            break;
        case OCC:
            result = agent_occCalc(nco, interval, aht, m);
            break;
        case IA:
            result = immAnsCalc(nco, interval, aht, m);
            break;
        case ERLANGC:
            result = erlangCCalc(nco, interval, aht, m);
            break;
        case ERLANGB:
            result = erlangBCalc(m, traffic_intensity(nco, interval, aht));
            break;
        case TRAFFIC:
            result = traffic_intensity(nco, interval, aht);
            break;
        case RHO:
            result = rhoCalc(nco, interval, aht, m);
            break;
            
        default:
            // raise error: invalid variable requested from getResult:withAgents: "req"
            result = 0.0;
            break;
    }
    
    return result;
}

-(void) setResult: (rqItem) req {
    
    double result = [self getResult:req withAgents:optimum];
    
    switch (req) {
        case AGENTS:
            optimum = how_many_agents(nco, interval, aht, svl_goal, asa_goal, max_occ);
            break;
        case SVL:
            svl = result;
            break;
        case ASA:
            asa = result;
            break;
        case OCC:
            occ = result;
            break;
        case IA:
            ia = result; 
            break;
        case ERLANGC:
            erlangc = result;
            break;
        case ERLANGB:
            erlangb = result;
            break;
        case TRAFFIC:
            traffic  = result;
            break;
        case RHO:
            rho = result;
            break;
            
        default:
            // raise error: invalid variable specified in setResult "req"
            break;
    };
}

// optimum offsets
-(int) offsetFromOptimumWithAgents: (int) m {
    return m - ((int) optimum);
}

// constructors
-(ErlangRequest *) initWithNCO: (int) ncoInput andAHT: (int) ahtInput andInterval: (int) intervalInput 
                    andSVLGoal: (double) svlInput andASAGoal: (double) asaInput andMaxOcc: (double) maxOccInput {
    
    self = [super init];
    if (self) {
        
        [self validateNCO:ncoInput andAHT:ahtInput andInterval:intervalInput 
                   andSVL:svlInput andASA:asaInput andMaxOcc:maxOccInput];
        
        if(validRequest)
        {
            // if defaults were set to the object by validation process, use these over inputs
            [self setNCO: ncoInput 
                  andAHT: ahtInput 
             andInterval: (interval > 0.0 ? interval : (double) intervalInput) 
                  andSVL: (svl_goal > 0.0 ? svl_goal : svlInput) 
                  andASA: (asa_goal > 0.0 ? asa_goal : asaInput) 
               andMaxOcc: (max_occ > 0.0 ? max_occ : maxOccInput)];
            return self;
        } else {
            return self;
        };
        
    } else {
        
        return nil;
    }
}

@end
