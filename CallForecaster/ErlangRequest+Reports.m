//
//  ErlangRequest+Reports.m
//  ErlangObject
//
//  Created by Gethryn Ghavalas on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ErlangRequest+Reports.h"


@implementation ErlangRequest (ErlangRequest_Reports)

-(NSString *) listWarnings {
    NSMutableString *output = [NSMutableString stringWithString:@""];
    if ([self requestHasWarnings]) {
        [output appendString:@"\n\nWARNINGS:\n"];
        for (NSString *warning in warningList) {
            [output appendFormat:@"%@\n",[warning description]];
        }
    }
    return (NSString *)output;
}

-(NSString *) listErrors {
    NSMutableString *output = [NSMutableString stringWithString:@""];
    if (![self validRequest]) {
        [output appendString:@"\n\nERRORS:\n"];
        for (NSString *error in errorList) {
            [output appendFormat:@"%@\n",[error description]];
        }
    }
    return (NSString *)output;
}

// format output full TEXT report; assumes that request is valid.
-(NSString *) textReport {
    NSMutableString *output = 
    [NSMutableString stringWithString:
     @"\n================================================================================\n"\
     "ERLANG C STAFFING REQUEST\n"\
     "================================================================================\n\n\n"];
    
    [output appendFormat:
     @"REQUEST: (your supplied input variables) \n"\
     "--------------------------------------------------------------------------------\n\n"\
     "Number of Calls Offered (NCO): %5i calls per interval\n"\
     "Average Handle Time (AHT):     %5i secs per call\n"\
     "Interval Length:               %5i secs (or %i mins)\n"\
     "Service Level:                 %i/%i -- or %i%% of calls answered within %i secs\n"\
     "Maximum Occupancy:             %5i %%\n\n"\
     "\n\n\n",
     (int) nco,
     (int) aht,
     (int) interval,
     (int) (interval/60.0),
     (int) svl_goal, 
     (int) asa_goal, 
     (int) svl_goal, 
     (int) asa_goal,
     (int) max_occ];
    
    [output appendFormat:
     @"RESULTS: (optimum results from your inputs)\n"\
     "--------------------------------------------------------------------------------\n\n"\
     "Number of Agents (FTE):        %6i Full Time Equivalent agents\n"\
     "Service Level:                 %6.1f %% of calls answered in %i secs\n"\
     "Occupancy:                     %6.1f %%\n"\
     "Immediate Answer:              %6.1f %% of calls will not wait in queue\n"\
     "Average Speed of Answer (ASA): %6i secs\n\n"\
     "\n\n\n",
     (int) optimum,
     (svl * 100.0),
     (int) asa_goal,
     (occ * 100.0),
     (ia * 100.0),
     (int) asa];
    
    // text table
    [output appendFormat:
     @"TABLE OUTPUT: (view of expected results at %i +/-5 agents)\n"\
     "--------------------------------------------------------------------------------\n\n",(int)optimum];
    [output appendString:[self tabOutputTable]];
    [output appendString:@"\n\n\n"];
    
    // csv table
    [output appendString:
     @"CSV OUTPUT: (can be pasted to a file for analysis (e.g. in Microsoft Excel))\n"\
     "--------------------------------------------------------------------------------\n\n"];
    [output appendString:[self csvOutputTable]];
    
    return (NSString *)output;
    
}


// format output for CSV header
-(NSString *) csvHeader {
    return @"fte,svl,occ,ia,asa,erlangc,erlangb,traffic,rho,offset,nco,aht,interval,svl_goal,asa_goal,max_occ\n";
}

// format output for CSV data row; assumes request valid.
-(NSString *) csvOutputWithAgents: (int) m {
    return [NSString stringWithFormat:@"%i,%g,%g,%g,%g,%g,%g,%g,%g,%i,%i,%i,%i,%i,%i,%i\n",
            m,
            [self getResult:SVL withAgents:m], //double
            [self getResult:OCC withAgents:m], //double
            [self getResult:IA withAgents:m], //double
            [self getResult:ASA withAgents:m], //double
            [self getResult:ERLANGC withAgents:m], //double
            [self getResult:ERLANGB withAgents:m], //double
            [self getResult:TRAFFIC withAgents:m], //double
            [self getResult:RHO withAgents:m], //double
            [self offsetFromOptimumWithAgents:m],
            (int) nco,
            (int) aht,
            (int) interval,
            (int) svl_goal, 
            (int) asa_goal, 
            (int) max_occ]; 
}

// format final CSV output; assumes request valid.
-(NSString *) csvOutputTable {
    
    int m = [self optimum];
    NSMutableString *result = [NSMutableString stringWithString:@""];
    
    [result appendString:[self csvHeader]];
    
    for (int i=(m-5); i<=(m+5); i++) {
        if ([self getResult:OCC withAgents:i]>0 && [self getResult:OCC withAgents:i]<100) {
            [result appendString:[self csvOutputWithAgents:i]];
        }
    }
    
    return (NSString *) result;
    
}


// format text table header
-(NSString *) tabHeader { 
    return 
    @"+-------+--------+--------+--------+--------+--------+\n"\
    "| FTE   | SVL %  | OCC %  | IA %   | ASA    | OFFSET |\n"\
    "+-------+--------+--------+--------+--------+--------+\n";
}

// format text table data row; assumes request valid
-(NSString *) tabOutputWithAgents: (int) m {
    return [NSString stringWithFormat:@"| %5i | %5.1f%% | %5.1f%% | %5.1f%% | %6i | %+6i |\n",
            (int) m,
            ((float)[self getResult:SVL withAgents:m] * 100),
            ((float)[self getResult:OCC withAgents:m] * 100),
            ((float)[self getResult:IA withAgents:m] * 100),
            (int) [self getResult:ASA withAgents:m],
            [self offsetFromOptimumWithAgents:m]];
}

// format text TAB table output; assumes valid request.
-(NSString *) tabOutputTable{
    
    int m = [self optimum];
    NSMutableString *result = [NSMutableString stringWithString:@""];
    
    [result appendString:[self tabHeader]];
    
    for (int i=(m-5); i<=(m+5); i++) {
        if ([self getResult:OCC withAgents:i]>0 && [self getResult:OCC withAgents:i]<100) {
            [result appendString:[self tabOutputWithAgents:i]];
        }
    }
    
    [result appendString:@"+-------+--------+--------+--------+--------+--------+\n"];
    
    return (NSString *) result;
    
}

// format output for iPhone Application in-app view
-(NSString *) iphoneHeader {
    int m = [self optimum];
return [NSString stringWithFormat:@"For %i calls at %i secs each in a %i sec interval, %i "\
    "Full Time Equivalents (FTEs) are required to achieve a %i/%i service level, with maximum " \
    "occupancy of %i\n",
        (int)nco, (int)aht,(int)interval,m,
        (int)svl_goal,(int)asa_goal,(int)max_occ];
}

// format output of iPhone data row; assumes valid request.
-(NSString *) iphoneOutputWithAgents: (int) m {
    return  [NSString stringWithFormat:
             @"\n%03i FTE:\tOCC = %3.0f%%\tSVL = %3.0f%%\tASA = %5.0f  %+i", 
             m, 
             [self getResult:OCC withAgents:m]*100,
             [self getResult:SVL withAgents:m]*100, 
             [self getResult:ASA withAgents:m],
             [self offsetFromOptimumWithAgents:m]];
}

// format output for iPhone in-app view.
-(NSString *) iphoneOutputTable {
    int m = [self optimum];
    NSMutableString *result = [NSMutableString stringWithString:@""];
    
    [result appendString:[self iphoneHeader]];
    
    for (int i=(m-4); i<=(m+4); i++) {
        if ([self getResult:OCC withAgents:i]>0 && [self getResult:OCC withAgents:i]<100) {
            [result appendString:[self iphoneOutputWithAgents:i]];
        }
    }
    [result appendString:[self listErrors]];
    [result appendString:[self listWarnings]];
    return (NSString *) result;
}


-(NSString *) outputReportWithFormat: (reportFormat) fmt {
    
    NSMutableString *output = [NSMutableString stringWithString:@""];
    
    if ([self validRequest]) {
        switch (fmt) {
            case TEXT:
                [output appendString:[self textReport]];
                break;
                
            case CSV:
                [output appendString:[self csvOutputTable]];
                break;
                
            case IPHONE:
                return [self iphoneOutputTable];
                break;
                
            default:
                return @"Report Format Not Yet Implemented!";
                break;
        }
    } else {
        [output appendString:@"Invalid values were supplied. Please adjust inputs and try again\n\n"];
        [output appendString:[self listErrors]];
    }
    
    [output appendString:[self listWarnings]];
    
    return (NSString *)output;
    
}

// default output for the ErlangRequest object.
-(NSString *) description {
    return [self outputReportWithFormat: TEXT];
}


@end
