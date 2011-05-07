//
//  Forecast.h
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErlangRequest.h"
#import "ForecastModel.h"


typedef enum {INTRADAY, DAILY, MONTHLY, YEARLY} forecastType;

@interface Forecast : NSObject {
@private
    int ncoAnnual, ncoMonthlyAverage, ncoDailyAverage, ncoIntervalAverage; // average values    
    forecastType fcType;
    ForecastModel *fcModel;
    NSMutableArray *dayOfYear;      // { dayName; date; {intervalLabel; ErlangRequest}; dayFactor; forecastNCO; rawFTE } [index+1=intDayOfYear].
    NSMutableArray *monthOfYear;    // { monthName; daysOpenInMonth; monthFactor; forecastNCO} [index+1=monthName].
}

@property (readwrite) int ncoAnnual, ncoMonthlyAverage, ncoDailyAverage, ncoIntervalAverage;
@property (assign) ForecastModel *fcModel;
@property (assign) NSMutableArray *dayOfYear, *monthOfYear;

// shorthand for day of year, etc
-(int)dayOfYearWithYear:(NSDate *)forecastDate;
-(int)daysOpenInMonth:(monthName)monthName;

// create an interval name by providing the number of seconds
-(NSString *)getIntervalLabelWithSeconds:(int)seconds andIntervalLength:(intervalLength)intLength includeMarker:(BOOL)mrk;

// create a forecasted value for a given period
-(int)forecastForMonth:(monthName)forecastMonth withAnnualVolume:(int)ncoAnnual;
-(int)forecastForDay:(dayName)forecastDay inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual;
-(int)forecastForInterval:(int)intSecondsSinceMidnight onDay:(dayName)forecastDay 
                  inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual;

@end
