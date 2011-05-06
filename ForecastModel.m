//
//  ForecastModel.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForecastModel.h"

/*
 
 typedef enum { LABELISSTART, LABELISEND } intervalLabelType; 
 typedef enum {MONTHFACTOR, WEEKDAYFACTOR, INTERVALFACTOR, HOLIDAYFACTOR} factorType;
 typedef enum {k15MIN = 900, k30MIN = 1800, k60MIN = 3600} intervalLength;
 typedef enum {JAN=1,FEB=2,MAR=3,APR=4,MAY=5,JUN=6,JUL=7,AUG=8,SEP=9,OCT=10,NOV=11,DEC=12} monthName;
 typedef enum {SUN,MON,TUE,WED,THU,FRI,SAT,HOL} dayName;
 
 */

@implementation ForecastModel

@synthesize modelName, groupIdentifier, groupName, userName, lastUpdated, hoursOfOperation, 
factors, holidays, shrink, inputs, intLabel, intLength;

// create hours of operation (HOOP) arrays of intervals


-(BOOL)setHoursOfOperationforDay:(dayName)day withOpenTime:(int)openTime andCloseTime:(int)closeTime{
    return NO;
}

-(NSArray *)getHOOPArrayOfIntervalsForDay:(dayName)day{
    //
    return nil;
}

-(NSDictionary *)getHOOPForAllDays{
    // dictionary would contain dayName, then NSArray of intervals for each dayName.
    return nil;
}
 
-(NSArray *)getHOOPArrayOfIntervalsFrom:(NSDate *)openTime to:(NSDate *)closeTime forDay:(dayName)day{
    //
    return nil;
}

-(NSString *)makeIntervalLabelForIntervalStaringAt:(NSDate *)intStart withMarker:(BOOL)includeMarker{
    //
    return @"";
}

// how many intervals in one day, based on interval length
-(int)intervalsInDay:(intervalLength)intLength{
    //
    return 0;
}

-(int)workDaysInMonth:(monthName)month andYear:(int)year{
    //
    return 0;
}

-(int)workDaysInYear:(int)year{
    //
    return 0;
}

-(int)getTimeinSeconds:(NSDate *)intervalStart {
    //
    return 0;
}

// create or read in factors
-(BOOL)addFactorsToSelf {
    
    // monthly, weekday and interval factors (manual).  
    // would normally read from csv/plist.
    NSArray *monthly = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:1.1745f],
                        [NSNumber numberWithFloat:1.1320f],
                        [NSNumber numberWithFloat:1.0376f],
                        [NSNumber numberWithFloat:1.0316f],
                        [NSNumber numberWithFloat:0.8536f],
                        [NSNumber numberWithFloat:1.1770f],
                        [NSNumber numberWithFloat:0.7833f],
                        [NSNumber numberWithFloat:0.9118f],
                        [NSNumber numberWithFloat:0.8068f],
                        [NSNumber numberWithFloat:0.9993f],
                        [NSNumber numberWithFloat:0.9960f],
                        [NSNumber numberWithFloat:1.0965f],
                        nil];
    
    
    NSArray *weekday = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0.0000f],
                        [NSNumber numberWithFloat:0.9963f],
                        [NSNumber numberWithFloat:1.0242f],
                        [NSNumber numberWithFloat:0.9983f],
                        [NSNumber numberWithFloat:0.9917f],
                        [NSNumber numberWithFloat:0.9893f],
                        [NSNumber numberWithFloat:0.0000f],
                        nil];
    
    
    NSArray *byinterval = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:1.0200f],
                           [NSNumber numberWithFloat:0.9950f],
                           [NSNumber numberWithFloat:0.9708f],
                           [NSNumber numberWithFloat:1.0272f],
                           [NSNumber numberWithFloat:0.9814f],
                           [NSNumber numberWithFloat:0.9881f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:1.0046f],
                           [NSNumber numberWithFloat:0.9540f],
                           [NSNumber numberWithFloat:1.0607f],
                           [NSNumber numberWithFloat:0.9833f],
                           [NSNumber numberWithFloat:1.0147f],
                           [NSNumber numberWithFloat:0.9793f],
                           [NSNumber numberWithFloat:1.0525f],
                           [NSNumber numberWithFloat:0.9804f],
                           [NSNumber numberWithFloat:1.0054f],
                           [NSNumber numberWithFloat:0.9846f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           [NSNumber numberWithFloat:0.0000f],
                           nil];
    
    // set up dictionary to hold each factor type: key=factorType, value=NSArray*factors
    NSDictionary *dict =   [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:MONTHFACTOR],    [monthly copy],
                            [NSNumber numberWithInt:WEEKDAYFACTOR],  [weekday copy],
                            [NSNumber numberWithInt:INTERVALFACTOR],  [byinterval copy],
                            nil];
    
    factors = [dict copy];
    
    // clean up
    [dict release];
    [monthly release];
    [weekday release];
    [byinterval release];
    
    if ([factors count] > 0) {
        return YES;
    }
    return NO;
}

-(NSDictionary *)getFactorsFromCSV:(NSString *)fileName forType:(factorType)factorType{
    //
    return nil;
}

-(NSDictionary *)buildFactorsFromArray:(NSArray *)factorArray forType:(factorType)factorType withFactors:(NSArray *)factorValues{
    //
    return nil;
}


// create or read in holidays
-(NSArray *)getHolidaysFromCSV:(NSString *)fileName{
    //
    return nil;
}

-(BOOL)addHolidaysToSelf{
    // setup object
    NSMutableArray *hols = [[NSMutableArray alloc] initWithCapacity:20];
    
    // dummy entries for development.  would normally get these from csv/plist file.
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-01-01"], @"date",
                     @"New Year's Day",                     @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-01-26"], @"date",
                     @"Australia Day",                      @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-04-22"], @"date",
                     @"Good Friday",                        @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-04-24"], @"date",
                     @"Easter Sunday",                      @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-04-25"], @"date",
                     @"ANZAC Day",                          @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-04-26"], @"date",
                     @"Easter Monday (Obs)",                @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-06-13"], @"date",
                     @"Queen's Birthday",                   @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-08-08"], @"date",
                     @"Bank Holiday",                       @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-10-03"], @"date",
                     @"Labour Day",                         @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-12-25"], @"date",
                     @"Christmas Day",                      @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    [hols addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                     [NSDate dateWithString:@"2011-12-26"], @"date",
                     @"Boxing Day",                         @"desc",
                     [NSNumber numberWithFloat:0.0f],       @"holfactor",
                     nil]];
    
    holidays = [hols copy];
    [hols release];
    
    if ([holidays count] > 0) {
        return YES;
    }
    return NO;
}

-(BOOL)addHolidayForDate:(NSDate *)holDate withDesc:(NSString *)holDesc andHolidayFactor:(float)holFactor{
    //assumes holidays is created
    
    NSInteger i = [holidays count];
    NSString *fmtHolDate = [NSDateFormatter localizedStringFromDate:holDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    [holidays addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        fmtHolDate,                             @"date",
                        holDesc,                                @"desc",
                        [NSNumber numberWithFloat:holFactor],   @"holfactor",
                        nil]];

    if ([holidays count] == (i+1)) {
        return YES;
    }
    return NO;
}

-(BOOL)removeHolidayForDate:(NSDate *)holDate{
    //
    return NO;
}

-(BOOL)isHoliday:(NSDate *)holDate{
    //
    return NO;
}


// inputs dictionary
-(NSDictionary *)configureInputsAsAHT:(int)inputAHT andSvlGoal:(int)inputSvlGoal andASAGoal:(int)inputASAGoal 
                    andIntervalLength:(intervalLength)inputIntLength andMaxOcc:(int)inputMaxOcc {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:inputAHT],        @"aht",
                          [NSNumber numberWithInt:inputSvlGoal],    @"svl_goal",
                          [NSNumber numberWithInt:inputASAGoal],    @"asa_goal",
                          [NSNumber numberWithInt:inputIntLength],  @"interval",
                          [NSNumber numberWithInt:inputMaxOcc],     @"max_occ",
                          nil];
    return dict;
}


// constructor
-(ForecastModel *)forecastModelWithName:(NSString *)name andGroupIdentifier:(NSString *)grpID andGroupName:(NSString *)grpName
                            andUsername:(NSString *)username andIntervalLength:(intervalLength)intLen 
                   andIntervalLabelType:(intervalLabelType)intLabType andHOOP:(NSArray *)hoursOfOp andHolidays:(NSArray *)hol
                              andInputs:(NSDictionary *)dictInputs andShrinkageFactor:(Shrinkage *)shrinkModel andFactors:(NSArray *)fct{
    self = [super init];
    
    if (self) {
        self.modelName = name;
        self.groupIdentifier = grpID;
        self.groupName = grpName;
        self.userName = username;
        self.intLength = intLen;
        self.intLabel = intLabType;
        self.hoursOfOperation = [hoursOfOp copy];
        self.holidays = [(NSMutableArray *)hol copy];
        self.inputs = [dictInputs copy];
        self.shrink = [shrinkModel copy];
        self.factors = [fct copy];
    }
    return self;
}


- (void)dealloc
{
    [hoursOfOperation release];
    [holidays release];
    [inputs release];
    [shrink release];
    [factors release];
    [super dealloc];
}

@end
