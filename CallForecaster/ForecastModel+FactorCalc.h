//
//  ForecastModel+FactorCalc.h
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 7/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForecastModel.h"


@interface ForecastModel (ForecastModel_FactorCalc)

-(NSDictionary *)calculateFactor:(factorType)fac withData:(NSDictionary *)factorData withAnnualVolume:(int)ncoAnnual;

@end
