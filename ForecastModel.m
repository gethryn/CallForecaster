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
-(id)importFactorsFromFileWithFormat:(importFileType)filetype {
    
    NSString *filePath, *error;
    NSData *fileData;
    id importedObject;
    
    
    switch (filetype) {
        case PLIST:
            // filePath =[[NSBundle mainBundle] pathForResource:@"ForecastFactors" ofType:@"plist"];
            filePath = @"/Users/geth/Development/CallForecaster/CallForecaster/ForecastFactors.plist";
            NSPropertyListFormat format;
            fileData = [NSData dataWithContentsOfFile:filePath];
            importedObject = [NSPropertyListSerialization propertyListFromData:fileData 
                                                              mutabilityOption:NSPropertyListImmutable
                                                                        format:&format
                                                              errorDescription:&error];
            break;
            
        case CSV:
            break;
            
        default:
            break;
    }
    
    if (!importedObject) {
        NSLog(@"%@",error);
        [error release];
        return nil;
    }
    
    return importedObject;
    
}

-(BOOL)addFactorsToSelf {
    
    NSDictionary *dictFactors = [self importFactorsFromFileWithFormat:PLIST];
    
    if (dictFactors) {
        NSDictionary *dictFactorsNormal = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [dictFactors objectForKey:@"monthFactors"],       [NSNumber numberWithInt:MONTHFACTOR],
                                           [dictFactors objectForKey:@"dayOfWeekFactors"],   [NSNumber numberWithInt:WEEKDAYFACTOR],
                                           [dictFactors objectForKey:@"intervalFactors"],    [NSNumber numberWithInt:INTERVALFACTOR],
                                           nil];
        NSMutableArray *arrayFactorsHoliday = [NSMutableArray arrayWithArray:[dictFactors objectForKey:@"holidayFactors"]];
        
        factors =   [dictFactorsNormal copy];
        holidays =  [arrayFactorsHoliday copy];
        
        if ([factors count] > 0 && [holidays count] > 0) {
            return YES;
        }
        
    }     
    return NO;
}

-(NSArray *)getFactorsFromFile:(NSString *)fileName ofFileType:(importFileType)fmt forFactorType:(factorType)factorType {
    //
    return nil;
}

-(NSDictionary *)buildFactorsFromArray:(NSArray *)factorArray forType:(factorType)factorType withFactors:(NSArray *)factorValues{
    //
    return nil;
}


// create or read in holidays


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
    //assumes holidays is created
    
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
        BOOL okInputs   = [self addInputsToSelf];
        BOOL okShrink   = [self addShrinkageModelToSelf];
        BOOL okFactors  = [self addFactorsToSelf];
        
        if (okHOOP && okInputs && okShrink && okFactors) {
            isValid = YES;
        } else {
            isValid = NO;
        }
    }
    lastUpdated = [NSDate date];
    return self;
}

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
