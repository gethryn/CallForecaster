//
//  ForecastModel.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ForecastModel.h"

/*
 
 May want to add a category that will allow calculation of Factors based on analysis of call volumes.
 Object currently assumes that factors are already calculated (e.g. from spreadsheet).
 
 */

@implementation ForecastModel

@synthesize modelName, groupIdentifier, groupName, userName, lastUpdated, hoursOfOperation, 
factors, holidays, shrink, inputs, intLabel, intLength, isValid,
modelForecastYear, modelYearNCO, modelMonthAvgNCO, modelDayAvgNCO, modelIntervalAvgNCO;

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

// create hours of operation (HOOP) arrays of intervals
-(BOOL)addHoursOfOperationToSelf {
    
    //used in debug, will use csv/plist in app.
    NSMutableArray *hoop = [[NSMutableArray alloc] initWithCapacity:(86400/intLength)];
    int openTime = 32400;   // 9:00 AM
    int closeTime = 61200;  // 5:00 PM
    
    for (int i = 1 ; i <= 5; i++) {  // M-F
        [hoop addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         [NSNumber numberWithInt:i],        @"weekday",
                         [NSNumber numberWithInt:openTime], @"open",
                         [NSNumber numberWithInt:closeTime],@"close",
                         nil]];
        
    }
    
    hoursOfOperation = [(NSArray *)hoop copy];
    [hoop release];
    
    if ([hoursOfOperation count] > 0) {
        return YES;
    }
    return NO;
}

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
                            [monthly copy],     [NSNumber numberWithInt:MONTHFACTOR],
                            [weekday copy],     [NSNumber numberWithInt:WEEKDAYFACTOR],  
                            [byinterval copy],  [NSNumber numberWithInt:INTERVALFACTOR],  
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
-(BOOL)addInputsToSelf {
    
    NSDictionary *dict = [[self configureInputsAsAHT:435 andSvlGoal:80 andASAGoal:20 andIntervalLength:k30MIN andMaxOcc:100] copy];
    
    inputs = [dict copy];
    [dict release];
    
    if ([inputs count] > 0) {
        return YES;
    }
    return NO;
}

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

-(BOOL)addShrinkageModelToSelf {
    shrink = [[Shrinkage alloc] initWithPaidHoursPerDay:8.0f andPaidDaysPerWeek:5.0f 
                                                 andVac:80.0f andSick:48.0f andOtherLeave:0.0f andOffPhoneItemArray:nil];
    if (shrink) {
        return YES;
    }
    return NO;
}

// constructor
-(ForecastModel *)initWithName:(NSString *)name andGroupIdentifier:(NSString *)grpID andGroupName:(NSString *)grpName
                            andUsername:(NSString *)username andIntervalLength:(intervalLength)intLen 
                   andIntervalLabelType:(intervalLabelType)intLabType andHOOP:(NSArray *)hoursOfOp andHolidays:(NSArray *)hol
                              andInputs:(NSDictionary *)dictInputs andShrinkageFactor:(Shrinkage *)shrinkModel andFactors:(NSArray *)fct{
    self = [super init];
    
    if (self) {
        // set from user inputs
        self.modelName = name;
        self.groupIdentifier = grpID;
        self.groupName = grpName;
        self.userName = username;
        self.intLength = intLen;
        self.intLabel = intLabType;
        
        // calculated
        BOOL okHOOP     = [self addHoursOfOperationToSelf];
        BOOL okHols     = [self addHolidaysToSelf];
        BOOL okInputs   = [self addInputsToSelf];
        BOOL okShrink   = [self addShrinkageModelToSelf];
        BOOL okFactors  = [self addFactorsToSelf];
        
        if (okHOOP && okHols && okInputs && okShrink && okFactors) {
            isValid = YES;
        } else {
            isValid = NO;
        }
    }
    lastUpdated = [NSDate date];
    return self;
}
/*
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
 */

// endocoders and decoders
-(void)encodeWithCoder:(NSCoder *)coder {
    
    // instructions for encoding the object
    [coder encodeObject:modelName forKey:@"FMModelName"];
    [coder encodeObject:groupIdentifier forKey:@"FMGroupID"];
    [coder encodeObject:groupName forKey:@"FMGroupName"];
    [coder encodeObject:userName forKey:@"FMUserName"];
    [coder encodeObject:lastUpdated forKey:@"FMLastUpdated"];
    [coder encodeObject:hoursOfOperation forKey:@"FMHoursOfOperation"];
    [coder encodeObject:holidays forKey:@"FMHolidays"];
    [coder encodeObject:shrink forKey:@"FMShrinkageModel"];
    [coder encodeObject:inputs forKey:@"FMInputs"];
    [coder encodeObject:factors forKey:@"FMFactors"];
    [coder encodeInt:intLabel forKey:@"FMIntLabelType"];
    [coder encodeInt:intLength forKey:@"FMIntervalLength"];
    [coder encodeBool:isValid forKey:@"FMIsValid"];
    [coder encodeInt:modelForecastYear forKey:@"FMModelFCYear"];
    [coder encodeInt:modelYearNCO forKey:@"FMModelYearNCO"];
    [coder encodeInt:modelMonthAvgNCO forKey:@"FMModelMonthAvgNCO"];
    [coder encodeInt:modelDayAvgNCO forKey:@"FMModelDayAvgNCO"];
    [coder encodeInt:modelIntervalAvgNCO forKey:@"FMModelIntervalAvgNCO"];
    [coder encodeFloat:0.1f forKey:@"version"];
}

-(ForecastModel *)initWithCoder:(NSCoder *)coder {
    
    self = [super init];
    if (self) {
        modelName =         [[coder decodeObjectForKey:@"FMModelName"] retain];
        groupIdentifier =   [[coder decodeObjectForKey:@"FMGroupID"] retain];
        groupName =         [[coder decodeObjectForKey:@"FMGroupName"] retain];
        userName =          [[coder decodeObjectForKey:@"FMUserName"] retain];
        lastUpdated =       [[coder decodeObjectForKey:@"FMLastUpdated"] retain];
        hoursOfOperation =  [[coder decodeObjectForKey:@"FMHoursOfOperation"] retain];
        holidays =          [[coder decodeObjectForKey:@"FMHolidays"] retain];
        shrink =            [[coder decodeObjectForKey:@"FMShrinkageModel"] retain];
        inputs =            [[coder decodeObjectForKey:@"FMInputs"]retain];
        factors =           [[coder decodeObjectForKey:@"FMFactors"] retain];
        intLabel =          [coder decodeIntForKey:@"FMIntLabelType"];
        intLength =         [coder decodeIntForKey:@"FMIntervalLength"];
        isValid =           [coder decodeBoolForKey:@"FMIsValid"];
        modelForecastYear = [coder decodeIntForKey:@"FMModelFCYear"];
        modelYearNCO =      [coder decodeIntForKey:@"FMModelYearNCO"];
        modelMonthAvgNCO =  [coder decodeIntForKey:@"FMModelMonthAvgNCO"];
        modelDayAvgNCO =    [coder decodeIntForKey:@"FMModelDayAvgNCO"];
        modelIntervalAvgNCO=[coder decodeIntForKey:@"FMModelIntervalAvgNCO"];
        isValid =           [coder decodeFloatForKey:@"version"];     
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
