//
//  ForecastModel+FactorCalc.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 7/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForecastModel+FactorCalc.h"


@implementation ForecastModel (ForecastModel_FactorCalc)

-(NSDictionary *)calculateFactor:(factorType)fac withData:(NSDictionary *)factorData withAnnualVolume:(int)ncoAnnual {
    
    // NSDictionary *factorData => NSArray *rowLabel, NSArray *weights, NSDictionary *colValuesForRow.
    
    switch (fac) {
            
        case MONTHFACTOR:
            // rowLabel = Year; weights = [as req]; colValuesForRow = nco for Month in Year.
            break;
            
        case WEEKDAYFACTOR:
            //rowLabel = Date (getDayOfWk); weights = nil; colValuesForRow = nco for Day;
            break;
            
        case INTERVALFACTOR:
            // rowLabel = Interval Label; weights = nil; colValuesForRow = nco for 4 x 7 days (in order SUN->SAT, typical wks).
            break;
            
        default:
            break;
    }
    return nil;
}

@end
