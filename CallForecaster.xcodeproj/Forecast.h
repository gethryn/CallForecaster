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

/*  FULL FORECAST OBJECT
 
YEAR: int
    yearDigits: int
    ncoAnnual: int
    ncoMonthlyAverage: int
    ncoDailyAverage: int
    ncoIntervalAverage: int
    dayInt:
        1:
            dayName: dayName
            date: NSDate
            dictionaryOfIntervals: NSDictionary
                @"00:00": ErlangRequest
                @"00:30": ErlangRequest
                ...etc
            dayFactor: float
            forecastNCO: float
            fteRaw: float
        ...etc
    monthInt:
        1:
            monthName: monthName
            daysOpenInMonth: int
            forecastNCO: int
            monthFactor: float
        ...etc
SETUP: ForecastModelObject { }
 
 */

typedef enum {INTRADAY, DAILY, MONTHLY, YEARLY} forecastType;



@interface Forecast : NSObject {
@private
    int ncoAnnual, ncoMonthlyAverage, ncoDailyAverage, ncoIntervalAverage; // average values    
    forecastType fcType;
    ForecastModel *fcModel;
}

// shorthand for day of year, etc
-(int)dayOfYearWithYear:(NSDate *)forecastDate;
-(int)daysOpenInMonth:(monthName)monthName;

// create an interval name by providing the number of seconds
-(NSString *)getIntervalWithSeconds:(int)seconds andIntervalLength:(intervalLength)intLength;

// create a forecasted value for a given period
-(int)forecastForMonth:(monthName)forecastMonth withAnnualVolume:(int)ncoAnnual;
-(int)forecastForDay:(dayName)forecastDay inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual;
-(int)forecastForInterval:(NSString *)intName onDay:(dayName)forecastDay inMonth:(monthName)monthName withAnnualVolume:(int)ncoAnnual;

@end
