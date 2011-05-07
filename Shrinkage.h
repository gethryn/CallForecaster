//
//  Shrinkage.h
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// typedefs
typedef enum {  MINSPERHOUR, MINSPERDAY, MINSPERWEEK, MINSPERMONTH,MINSPERYEAR,
    HOURSPERDAY, HOURSPERWEEK, HOURSPERMONTH, HOURSPERYEAR,
    DAYSPERWEEK, DAYSPERMONTH, DAYSPERYEAR, 
    WEEKSPERMONTH, WEEKSPERYEAR,
    MONTHSPERYEAR} shrinkConversion;
typedef enum {  CRITICAL, HIGH, MEDIUM, LOW } shrinkCriticality;
typedef enum {  WEEKSinYEAR = 52, MONTHSinYEAR=12, MINSinHOUR=60 } timeConstants;

@interface Shrinkage : NSObject {
@private
    float paidHoursPerDay;
    float paidDaysPerWeek;
    float paidHoursPerYearVacation;
    float paidHoursPerYearSick;
    float paidHoursPerYearOther;
    float paidHoursTotal;
    float paidHoursAtWorkTotal;
    float paidHoursOnLeaveTotal;
    NSMutableArray * offPhoneItems;  // will include NSDictionaries with keys { name, value, conversion, criticality }
    float offPhoneHoursTotal;
    float prodHoursTotal;
    float factorShrinkage;
    BOOL  isValid;
}

@property (readwrite) float paidHoursPerDay, paidHoursPerYearVacation, paidHoursPerYearSick, paidHoursPerYearOther, paidDaysPerWeek;
@property (readwrite,assign) NSMutableArray *offPhoneItems;
@property (readwrite) float paidHoursTotal, paidHoursAtWorkTotal, paidHoursOnLeaveTotal, offPhoneHoursTotal, prodHoursTotal, factorShrinkage;
@property (readwrite) BOOL isValid;


// add a shrinkage item to the offPhoneItems array (NOTE: NAME MUST BE UNIQUE ... ??)
-(BOOL)addShrinkItemsToSelf;
-(float)calculateShrinkageHoursTotal;
-(BOOL)addOffPhoneItem:(NSString *)name ofValue:(float)value withConversion:(shrinkConversion)cnv andCritcality:(shrinkCriticality)crit;
-(BOOL)removeOffPhoneItemWithName:(NSString *)name;
-(float)getMultiplierForShrinkConversion:(shrinkConversion)cnv;


// constuctor (will calculate all other values)
-(BOOL)performShrinkageCalculationWithItems:(NSMutableArray *)shrinkItems;
-(Shrinkage *)initWithPaidHoursPerDay:(float)paidPerDay andPaidDaysPerWeek:(float)daysPerWeek andVac:(float)vacHours
                              andSick:(float)sickHours andOtherLeave:(float)otherHours andOffPhoneItemArray:(NSArray *)shrinkItems;

// encoding and decoding for object saving and opening.
-(void)encodeWithCoder:(NSCoder *)coder;
-(id)initWithCoder:(NSCoder *)coder;

@end
