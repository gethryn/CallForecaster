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
typedef enum {MONTHFACTOR, WEEKDAYFACTOR, INTERVALFACTOR, HOLIDAYFACTOR} factorType;
typedef enum {k15MIN = 900, k30MIN = 1800, k60MIN = 3600} intervalLength;
typedef enum {JAN=1,FEB=2,MAR=3,APR=4,MAY=5,JUN=6,JUL=7,AUG=8,SEP=9,OCT=10,NOV=11,DEC=12} monthName;
typedef enum {SUN,MON,TUE,WED,THU,FRI,SAT,HOL} dayName;
typedef enum {PLIST, CSV} importFileType;

@interface ForecastModel : NSObject {
@private
    NSString *modelName;
    NSString *groupIdentifier;
    NSString *groupName;
    NSString *userName;
    NSDate *lastUpdated;
    NSArray *hoursOfOperation;
    NSMutableArray *holidays;
    NSDictionary *factors;
    NSDictionary *inputs;
    Shrinkage *shrink;
    intervalLabelType intLabel;
    intervalLength intLength; // what is the length of the interval
    BOOL isValid;
    int modelForecastYear, modelYearNCO, modelMonthAvgNCO, modelDayAvgNCO, modelIntervalAvgNCO;
}

@property (assign) NSString *modelName, *groupIdentifier, *groupName, *userName; 
@property (assign) NSDate *lastUpdated;
@property (assign) NSArray *hoursOfOperation;
@property (assign) NSMutableArray *holidays;
@property (assign) Shrinkage *shrink;
@property (assign) NSDictionary *inputs, *factors;
@property (readwrite) intervalLabelType intLabel;
@property (readwrite) intervalLength intLength;
@property (readwrite) BOOL isValid;
@property (readwrite) int modelForecastYear, modelYearNCO, modelMonthAvgNCO, modelDayAvgNCO, modelIntervalAvgNCO;

// how many intervals in one day, based on interval length
-(int)intervalsInDay:(intervalLength)intLength;
-(int)workDaysInMonth:(monthName)month andYear:(int)year;
-(int)workDaysInYear:(int)year;
-(int)getTimeinSeconds:(NSDate *)intervalStart;

// create hours of operation (HOOP) arrays of intervals
-(BOOL)addHoursOfOperationToSelf;
-(BOOL)setHoursOfOperationforDay:(dayName)day withOpenTime:(int)openTime andCloseTime:(int)closeTime;
-(NSArray *)getHOOPArrayOfIntervalsForDay:(dayName)day;
-(NSDictionary *)getHOOPForAllDays; //dictionary would contain dayName, then NSArray of intervals for each dayName.
-(NSArray *)getHOOPArrayOfIntervalsFrom:(NSDate *)openTime to:(NSDate *)closeTime forDay:(dayName)day;
-(NSString *)makeIntervalLabelForIntervalStaringAt:(NSDate *)intStart withMarker:(BOOL)includeMarker;

// read in factors in variety of formats
-(id)importFactorsFromFileWithFormat:(importFileType)filetype;

// create or read in factors
-(BOOL)addFactorsToSelf;
-(NSArray *)getFactorsFromFile:(NSString *)fileName ofFileType:(importFileType)fmt forFactorType:(factorType)factorType;
-(NSDictionary *)buildFactorsFromArray:(NSArray *)factorArray forType:(factorType)factorType withFactors:(NSArray *)factorValues;

// create or read in holidays
-(BOOL)addHolidayForDate:(NSDate *)holDate withDesc:(NSString *)holDesc andHolidayFactor:(float)holFactor;
-(BOOL)removeHolidayForDate:(NSDate *)holDate;
-(BOOL)isHoliday:(NSDate *)holDate;

// inputs dictionary
-(BOOL)addInputsToSelf;
-(NSDictionary *)configureInputsAsAHT:(int)inputAHT andSvlGoal:(int)inputSvlGoal andASAGoal:(int)inputASAGoal 
                    andIntervalLength:(intervalLength)inputIntLength andMaxOcc:(int)inputMaxOcc;

// shrinkage model
-(BOOL)addShrinkageModelToSelf;

// constructor
-(ForecastModel *)initWithName:(NSString *)name andGroupIdentifier:(NSString *)grpID andGroupName:(NSString *)grpName
                            andUsername:(NSString *)username andIntervalLength:(intervalLength)intLen 
                   andIntervalLabelType:(intervalLabelType)intLabType andHOOP:(NSArray *)hoursOfOp andHolidays:(NSArray *)hol
                              andInputs:(NSDictionary *)dictInputs andShrinkageFactor:(Shrinkage *)shrinkModel andFactors:(NSArray *)fct;

// model encoding
-(void)encodeWithCoder:(NSCoder *)coder;
-(id)initWithCoder:(NSCoder *)coder;

@end
