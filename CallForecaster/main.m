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
    
    NSString *archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Shrink.archive"];
    BOOL result = [NSKeyedArchiver archiveRootObject:shrink toFile:archivePath];
    
    NSLog(@"\n\nResult of Archiving to Shrink.archive: %i\n\n",result);
    
    [shrink release];
    
    Shrinkage *shrink2 = [[NSKeyedUnarchiver unarchiveObjectWithFile:archivePath] retain];
    NSLog(@"\n\nSHRINKAGE FACTOR: %2f\tNET PROD HOURS: %2f\n\n", shrink2.factorShrinkage, shrink2.prodHoursTotal);
    
    [shrink2 release];
    
    
    ForecastModel *fcModel = [[ForecastModel alloc] initWithName:@"Test Forecast Model" andGroupIdentifier:@"12345" andGroupName:@"gethdev.com" andUsername:@"Gethryn Ghavalas" andIntervalLength:k30MIN andIntervalLabelType:LABELISSTART andHOOP:nil andHolidays:nil andInputs:nil andShrinkageFactor:nil andFactors:nil];
    
    NSLog(@"\nINITIAL OBJECT: %@\nby %@",fcModel.modelName, fcModel.userName);  
    
    NSString *archivePathFM = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ForecastModel.archive"];
    BOOL qpla = [NSKeyedArchiver archiveRootObject:fcModel toFile:archivePathFM];
    [fcModel release];
    
    ForecastModel *fcModel2 = [[NSKeyedUnarchiver unarchiveObjectWithFile:archivePathFM] retain];
    
    NSLog(@"\nDECODED OBJECT%@\nby %@, %i",fcModel2.modelName, fcModel2.userName, qpla);
    
    [fcModel2 release];
    
    [pool drain];
    return 0;
}

