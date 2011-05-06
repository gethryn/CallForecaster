//
//  Shrinkage.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Shrinkage.h"


@implementation Shrinkage

@synthesize paidHoursPerDay, paidHoursPerYearVacation, paidHoursPerYearSick, paidHoursPerYearOther, paidDaysPerWeek, 
offPhoneItems, paidHoursTotal, paidHoursAtWorkTotal, paidHoursOnLeaveTotal, offPhoneHoursTotal, prodHoursTotal, factorShrinkage;

-(BOOL)addOffPhoneItem:(NSString *)name ofValue:(float)value 
        withConversion:(shrinkConversion)cnv andCritcality:(shrinkCriticality)crit {
    
    // assumes init has created the array
    
    NSInteger i = [offPhoneItems count];
    
    NSDictionary *dict =  [NSDictionary dictionaryWithObjectsAndKeys:
                           name,                                @"name",    
                           [NSNumber numberWithFloat:value],    @"value",   
                           [NSNumber numberWithInt: cnv],       @"cnv",
                           [NSNumber numberWithInt: crit],      @"crit",
                           nil];
    
        [offPhoneItems addObject:dict];
    
    if ( [offPhoneItems count] == (i+1) ) {
        return YES;
    } else {
        return NO;
    }
    
}

-(BOOL)removeOffPhoneItemWithName:(NSString *)name{
    NSInteger j = [offPhoneItems count];
    if (j > 0) {
        for (id shrinkItem in offPhoneItems) {
            NSInteger i = [offPhoneItems indexOfObject:shrinkItem];
            if ([shrinkItem objectForKey:@"name"] == name) {
                [offPhoneItems removeObjectAtIndex:i];
                if ([offPhoneItems count] == (j-1)) {
                    return YES;
                }
            } 
        }
    } 
    return NO;
}

-(float)getMultiplierForShrinkConversion:(shrinkConversion)cnv {
    // converting all to HOURSPERMONTH
    switch (cnv) {
        case MINSPERHOUR:   return ( 1.0f / MINSinHOUR * paidHoursPerDay * paidDaysPerWeek * WEEKSinYEAR / MONTHSinYEAR ); break;
        case MINSPERDAY:    return ( 1.0f / MINSinHOUR * paidDaysPerWeek * WEEKSinYEAR / MONTHSinYEAR ); break;
        case MINSPERWEEK:   return ( 1.0f / MINSinHOUR * WEEKSinYEAR / MONTHSinYEAR ); break;
        case MINSPERMONTH:  return ( 1.0f / MINSinHOUR ); break; 
        case HOURSPERDAY:   return ( 1.0f * paidDaysPerWeek * WEEKSinYEAR / MONTHSinYEAR ); break;
        case HOURSPERWEEK:  return ( 1.0f * WEEKSinYEAR / MONTHSinYEAR ); break;
        case HOURSPERMONTH: return ( 1.0f ); break;
        case HOURSPERYEAR:  return ( 1.0f / MONTHSinYEAR ); break;
        case DAYSPERWEEK:   return ( 1.0f * paidHoursPerDay * WEEKSinYEAR / MONTHSinYEAR ); break;
        case DAYSPERMONTH:  return ( 1.0f * paidHoursPerDay ); break;
        case DAYSPERYEAR:   return ( 1.0f * paidHoursPerDay / MONTHSinYEAR ); break;
        case WEEKSPERMONTH: return ( 1.0f * paidDaysPerWeek * paidHoursPerDay ); break;
        case WEEKSPERYEAR:  return ( 1.0f * paidDaysPerWeek * paidHoursPerDay / MONTHSinYEAR ); break;
        case MONTHSPERYEAR: return ( 1.0f * WEEKSinYEAR / MONTHSinYEAR * paidDaysPerWeek * paidHoursPerDay ); break;
        default:            return 1.0f; break;
    }
}

-(BOOL)addShrinkItemsToSelf {
 // dummy code to mimic import
    
    NSMutableArray *offPhoneItemsDebug = [[NSMutableArray alloc] initWithCapacity:20] ;
    
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Paid Breaks",                         @"name",    
                                    [NSNumber numberWithFloat:30.0f],       @"value",   
                                    [NSNumber numberWithInt: MINSPERDAY],   @"cnv",
                                    [NSNumber numberWithInt: CRITICAL],     @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Training",                            @"name",    
                                    [NSNumber numberWithFloat:2.0f],        @"value",   
                                    [NSNumber numberWithInt: HOURSPERMONTH],@"cnv",
                                    [NSNumber numberWithInt: MEDIUM],       @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Quality Assurance",                   @"name",    
                                    [NSNumber numberWithFloat:30.0f],       @"value",   
                                    [NSNumber numberWithInt: MINSPERWEEK],  @"cnv",
                                    [NSNumber numberWithInt: HIGH],         @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Meetings",                            @"name",    
                                    [NSNumber numberWithFloat:1.0f],        @"value",   
                                    [NSNumber numberWithInt: HOURSPERWEEK], @"cnv",
                                    [NSNumber numberWithInt: MEDIUM],       @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Paid Lunch",                          @"name",    
                                    [NSNumber numberWithFloat:30.0f],       @"value",   
                                    [NSNumber numberWithInt: MINSPERDAY],   @"cnv",
                                    [NSNumber numberWithInt: CRITICAL],     @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Back Office",                         @"name",    
                                    [NSNumber numberWithFloat:1.0f],        @"value",   
                                    [NSNumber numberWithInt: HOURSPERDAY],  @"cnv",
                                    [NSNumber numberWithInt: MEDIUM],       @"crit",
                                    nil]];
    [offPhoneItemsDebug addObject: [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Supervisor Duties",                   @"name",    
                                    [NSNumber numberWithFloat:0.0f],        @"value",   
                                    [NSNumber numberWithInt: HOURSPERMONTH],@"cnv",
                                    [NSNumber numberWithInt: LOW],          @"crit",
                                    nil]];
    
    offPhoneItems = [offPhoneItemsDebug copy];
    
    [offPhoneItemsDebug release];
    
    return YES;
}

// loop through the shrinkage items, and calculate a total.
-(float)calculateShrinkageHoursTotal {
    //
    float result = 0.0f;
    for (id shrinkItem in offPhoneItems) {
        result +=   ([[shrinkItem objectForKey:@"value"] floatValue]) * 
                    ([self getMultiplierForShrinkConversion:[[shrinkItem objectForKey:@"cnv"] intValue]]);
    }
    return result;
}


// constuctor (will calculate all other values)
-(Shrinkage *)initWithPaidHoursPerDay:(float)paidPerDay andPaidDaysPerWeek:(float)daysPerWeek andVac:(float)vacHours
                              andSick:(float)sickHours andOtherLeave:(float)otherHours andOffPhoneItemArray:(NSArray *)shrinkItems {
    self = [super init];
    if (self) {
        
        // user provided values;
        self.paidHoursPerDay = paidPerDay;
        self.paidDaysPerWeek = daysPerWeek;
        self.paidHoursPerYearVacation = vacHours;
        self.paidHoursPerYearSick = sickHours;
        self.paidHoursPerYearOther = otherHours;
        
        // calculations for at work
        self.paidHoursTotal         = ( paidPerDay * daysPerWeek * WEEKSinYEAR / MONTHSinYEAR );
        self.paidHoursOnLeaveTotal  = ( ( paidHoursPerYearVacation + paidHoursPerYearSick + paidHoursPerYearOther ) / MONTHSinYEAR );
        self.paidHoursAtWorkTotal   = ( paidHoursTotal - paidHoursOnLeaveTotal );
        
        // calculations for off phone: get thre shrinkage items and add them to the object.
        // during DEV this is used to dummy import; normally we would:  self.offPhoneItems = (NSMutableArray *)shrinkItems;
        BOOL shrinkImported = [self addShrinkItemsToSelf];
        
        // if we managed to import shrink items, calculate the total, otherwise 0
        if (shrinkImported) {
            self.offPhoneHoursTotal = [self calculateShrinkageHoursTotal];
        } else {
            self.offPhoneHoursTotal = 0.0f;
        }
        self.prodHoursTotal         = ( paidHoursAtWorkTotal - offPhoneHoursTotal );
        
        // calculate shrink factor
        self.factorShrinkage        = ( 1.0f + ( (paidHoursTotal - prodHoursTotal ) / paidHoursTotal ) );
    }
    return self;
}

- (void)dealloc
{
    [offPhoneItems release];
    [super dealloc];
}

@end
