//
//  main.m
//  CallForecaster
//
//  Created by Gethryn Ghavalas on 6/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"

int main (int argc, const char * argv[])
{
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    Shrinkage *shrink = [[Shrinkage alloc] initWithPaidHoursPerDay:8.0f andPaidDaysPerWeek:5.0f andVac:80.0f andSick:48.0f andOtherLeave:0.0f andOffPhoneItemArray:nil];
    
    // insert code here...
    NSLog(@"\n\nSHRINKAGE FACTOR: %2f\n\n", [shrink factorShrinkage]);
    [shrink release];
    
    ForecastModel *fcModel = [[ForecastModel alloc] initWithName:@"Test Forecast Model" andGroupIdentifier:@"12345" andGroupName:@"gethdev.com" andUsername:@"Gethryn Ghavalas" andIntervalLength:k30MIN andIntervalLabelType:LABELISSTART andHOOP:nil andHolidays:nil andInputs:nil andShrinkageFactor:nil andFactors:nil];
    
    NSLog(@"\n%@\nby %@, %i",fcModel.modelName, fcModel.userName, fcModel.isValid);
    
    [pool drain];
    return 0;
}

