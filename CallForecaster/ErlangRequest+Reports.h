//
//  ErlangRequest+Reports.h
//  ErlangObject
//
//  Created by Gethryn Ghavalas on 3/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErlangRequest.h"

typedef enum {TEXT, HTML, XML, CSV, IPHONE} reportFormat;

@interface ErlangRequest (ErlangRequest_Reports)

// output reports
-(NSString *) listWarnings;
-(NSString *) listErrors;
-(NSString *) outputReportWithFormat: (reportFormat) fmt;

// format output FULL TEXT
-(NSString *) textReport;

// format output CSV
-(NSString *) csvHeader;
-(NSString *) csvOutputWithAgents: (int) m;
-(NSString *) csvOutputTable;

// format output TABLE (tab)
-(NSString *) tabHeader;
-(NSString *) tabOutputWithAgents: (int) m;
-(NSString *) tabOutputTable;

// format output for IPHONE
-(NSString *) iphoneHeader;
-(NSString *) iphoneOutputWithAgents: (int) m;
-(NSString *) iphoneOutputTable;

@end
