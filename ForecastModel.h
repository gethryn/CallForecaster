//
//  ForecastModel.h
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shrinkage.h"


// to allow for systems that label intervals with end time vs start time
typedef enum { LABELISSTART, LABELISEND } intervalLabelType; 
typedef enum {MONTH, WEEKDAY, INTERVAL, HOLIDAY} factorType;
typedef enum {k15MIN = 900, k30MIN = 1800, k60MIN = 3600} intervalLength;
typedef enum {JAN=1,FEB=2,MAR=3,APR=4,MAY=5,JUN=6,JUL=7,AUG=8,SEP=9,OCT=10,NOV=11,DEC=12} monthName;
typedef enum {SUN,MON,TUE,WED,THU,FRI,SAT,HOL} dayName;

@interface ForecastModel : NSObject {
@private
    NSString *modelName;
    NSString *groupIdentifier;
    NSString *groupName;
    NSString *userName;
    NSDate *lastUpdated;
    NSArray *hoursOfOperation;
    NSMutableArray *holidays;
    NSArray *factors;
    NSDictionary *inputs;
    Shrinkage *shrink;
    intervalLabelType intLabel;
    intervalLength intLength; // what is the length of the interval
}

@property (assign) NSString *modelName, *groupIdentifier, *groupName, *userName; 
@property (assign) NSDate *lastUpdated;
@property (assign) NSArray *hoursOfOperation, *factors;
@property (assign) NSMutableArray *holidays;
@property (assign) Shrinkage *shrink;
@property (assign) NSDictionary *inputs;
@property (readwrite) intervalLabelType intLabel;
@property (readwrite) intervalLength intLength;

// how many intervals in one day, based on interval length
-(int)intervalsInDay:(intervalLength)intLength;

// create hours of operation (HOOP) arrays of intervals
-(NSArray *)getHOOPArrayOfIntervalsForDay:(dayName)day;
-(NSDictionary *)getHOOPForAllDays; //dictionary would contain dayName, then NSArray of intervals for each dayName.
-(NSArray *)getHOOPArrayOfIntervalsFrom:(NSDate *)openTime to:(NSDate *)closeTime forDay:(dayName)day;
-(NSString *)makeIntervalLabelForIntervalStaringAt:(NSDate *)intStart withMarker:(BOOL)includeMarker;

// create or read in factors
-(NSDictionary *)getFactorsFromCSV:(NSString *)fileName forType:(factorType)factorType;
-(NSDictionary *)buildFactorsFromArray:(NSArray *)factorArray forType:(factorType)factorType withFactors:(NSArray *)factorValues;

// create or read in holidays
-(NSDictionary *)getHolidaysFromCSV:(NSString *)fileName;
-(NSDictionary *)buildHolidaysFromArray:(NSArray *)holidayArray;
-(BOOL)addHolidayForDate:(NSDate *)holDate withDesc:(NSString *)holDesc andHolidayFactor:(float)holFactor;
-(BOOL)removeHolidayForDate:(NSDate *)holDate;
-(BOOL)isHoliday:(NSDate *)holDate;

// inputs dictionary
-(NSDictionary *)configureInputsAsAHT:(int)inputAHT andSvlGoal:(int)inputSvlGoal andASAGoal:(int)inputASAGoal 
                    andIntervalLength:(intervalLength)inputIntLength andMaxOcc:(int)inputMaxOcc;

// constructor
-(ForecastModel *)forecastModelWithName:(NSString *)modelName andGroupIdentifier:(NSString *)groupID andGroupName:(NSString *)groupName
                            andUsername:(NSString *)username andIntervalLength:(intervalLength)intLength 
                   andIntervalLabelType:(intervalLabelType)intLabelType andHOOP:(NSArray *)hoursOfOp andHolidays:(NSArray *)hols
                              andInputs:(NSDictionary *)inputs andShrinkageFactor:(Shrinkage *)shrinkModel andFactors:(NSArray *)fct;

@end
