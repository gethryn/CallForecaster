//
//  ForecastModel.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForecastModel.h"

/*
 SETUP: ForecastModelObject {
 HoursOfOps:
 dayName: dayName
 openTime: NSDate
 closeTime: NSDate
 Holidays:
 date: NSDate
 holidayName: NSString
 holidayFactor: int
 Factors:
 factorType: factorType
 key: value
 ...etc
 Inputs:
 inputType: inputType //like AHT, SVL_GOAL, etc
 value: value
 ... etc
 
 SHRINKAGE: ShrinkageObject {}
 */

@implementation ForecastModel

@synthesize modelName, groupIdentifier, groupName, userName, lastUpdated, hoursOfOperation, 
factors, holidays, shrink, inputs, intLabel, intLength;

// how many intervals in one day, based on interval length
-(int)intervalsInDay:(intervalLength)intLength{
    //
}

// create hours of operation (HOOP) arrays of intervals
-(NSArray *)getHOOPArrayOfIntervalsForDay:(dayName)day{
    //
}

-(NSDictionary *)getHOOPForAllDays{
    //
}
 //dictionary would contain dayName, then NSArray of intervals for each dayName.
-(NSArray *)getHOOPArrayOfIntervalsFrom:(NSDate *)openTime to:(NSDate *)closeTime forDay:(dayName)day{
    //
}

-(NSString *)makeIntervalLabelForIntervalStaringAt:(NSDate *)intStart withMarker:(BOOL)includeMarker{
    //
}


// create or read in factors
-(NSDictionary *)getFactorsFromCSV:(NSString *)fileName forType:(factorType)factorType{
    //
}

-(NSDictionary *)buildFactorsFromArray:(NSArray *)factorArray forType:(factorType)factorType withFactors:(NSArray *)factorValues{
    //
}


// create or read in holidays
-(NSDictionary *)getHolidaysFromCSV:(NSString *)fileName{
    //
}

-(NSDictionary *)buildHolidaysFromArray:(NSArray *)holidayArray{
    //
}

-(BOOL)addHolidayForDate:(NSDate *)holDate withDesc:(NSString *)holDesc andHolidayFactor:(float)holFactor{
    //
}

-(BOOL)removeHolidayForDate:(NSDate *)holDate{
    //
}

-(BOOL)isHoliday:(NSDate *)holDate{
    //
}


// inputs dictionary
-(NSDictionary *)configureInputsAsAHT:(int)inputAHT andSvlGoal:(int)inputSvlGoal andASAGoal:(int)inputASAGoal 
                    andIntervalLength:(intervalLength)inputIntLength andMaxOcc:(int)inputMaxOcc{
    //
}


// constructor
-(ForecastModel *)forecastModelWithName:(NSString *)modelName andGroupIdentifier:(NSString *)groupID andGroupName:(NSString *)groupName
                            andUsername:(NSString *)username andIntervalLength:(intervalLength)intLength 
                   andIntervalLabelType:(intervalLabelType)intLabelType andHOOP:(NSArray *)hoursOfOp andHolidays:(NSArray *)hols
                              andInputs:(NSDictionary *)inputs andShrinkageFactor:(Shrinkage *)shrinkModel andFactors:(NSArray *)fct{
    //
}


- (void)dealloc
{
    [super dealloc];
}

@end
