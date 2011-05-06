//
//  Forecast.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Forecast.h"

// { dayName; date; {intervalLabel; ErlangRequest}; dayFactor; forecastNCO; rawFTE } [index+1=intDayOfYear].
// { monthName; daysOpenInMonth; monthFactor; forecastNCO} [index+1=monthName].

@implementation Forecast

@synthesize ncoAnnual, ncoMonthlyAverage, ncoDailyAverage, ncoIntervalAverage,
fcModel, dayOfYear, monthOfYear;

// shorthand for day of year, etc
-(int)dayOfYearWithYear:(NSDate *)forecastDate {
    return 0;
}
-(int)daysOpenInMonth:(monthName)monthName {
    return 0;
}

// create an interval name by providing the number of seconds
-(NSString *)getIntervalLabelWithSeconds:(int)seconds andIntervalLength:(intervalLength)intLength includeMarker:(BOOL)mrk {
    return @"";
}

// create a forecasted value for a given period
-(int)forecastForMonth:(monthName)forecastMonth withAnnualVolume:(int)ncoAnnual {
    return 0;
}

-(int)forecastForDay:(dayName)forecastDay inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual {
    return 0;
}


-(int)forecastForInterval:(int)intSecondsSinceMidnight onDay:(dayName)forecastDay 
                  inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual {
    return 0;
}

// constructors
- (id)initWithNCOAnnual:(int)nco_annual andForecastModel:(ForecastModel *)fc {
    
    self = [super init];
    
    if (self) {
        //init here
    }
    return self;    
}

- (void)dealloc
{
    [fcModel     release];
    [dayOfYear   release];
    [monthOfYear release];
    [super dealloc];
}

@end
