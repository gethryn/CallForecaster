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
    
    NSLog(@"Program Executed at %@\nBy User %@\n\n",[NSDate date], NSUserName());
    
    Shrinkage *shrink = [[Shrinkage alloc] initWithPaidHoursPerDay:8.0f andPaidDaysPerWeek:5.0f andVac:80.0f andSick:48.0f andOtherLeave:0.0f andOffPhoneItemArray:nil];
    
    NSLog(@"\nSHRINKAGE OBJECT CREATED WITH INPUTS\n"\
          "Shrinkage Factor: %2f\tNet Prod Hours: %2f\n", shrink.factorShrinkage, shrink.prodHoursTotal);
    NSString *archivePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Shrink.archive"];
    BOOL result = [NSKeyedArchiver archiveRootObject:shrink toFile:archivePath];
    NSLog(@"\nShrinkage Model Archived to %@, with response: %i\n",archivePath,result);
    [shrink release];
    
    Shrinkage *shrink2 = [[NSKeyedUnarchiver unarchiveObjectWithFile:archivePath] retain];
    NSLog(@"\n\nSHRINKAGE OBJECT CREATED FROM ARCHIVE AT %@.\n", archivePath);
    NSLog(@"Shrinkage Factor: %2f\tNet Prod Hours: %2f\n",shrink2.factorShrinkage, shrink2.prodHoursTotal);
    [shrink2 release];
    
    
    ForecastModel *fcModel = [[ForecastModel alloc] initWithName:@"Test Forecast Model" andGroupIdentifier:@"12345" andGroupName:@"gethdev.com" andUsername:@"Gethryn Ghavalas" andIntervalLength:k30MIN andIntervalLabelType:LABELISSTART andHOOP:nil andHolidays:nil andInputs:nil andShrinkageFactor:nil andFactors:nil];
    
    NSLog(@"\nFORECAST MODEL CREATED WITH INPUTS FOR: %@\nby %@\nNCO for YEAR: %i",fcModel.modelName, fcModel.userName,fcModel.modelYearNCO);  
    
    NSString *archivePathFM = [NSTemporaryDirectory() stringByAppendingPathComponent:@"ForecastModel.archive"];
    BOOL qpla = [NSKeyedArchiver archiveRootObject:fcModel toFile:archivePathFM];
    NSLog(@"\nForecast Model Archived to %@, with response: %i\n",archivePathFM,qpla);
    [fcModel release];
    
    ForecastModel *fcModel2 = [[NSKeyedUnarchiver unarchiveObjectWithFile:archivePathFM] retain];
    
    NSLog(@"\nFORECAST MODEL CREATED FROM ARCHIVE: %@\nby %@\nNCO for YEAR: %i",fcModel2.modelName, fcModel2.userName,fcModel2.modelYearNCO);
    
    [fcModel2 release];
    
    NSLog(@"Program Completed at %@\nBy User %@\n\n",[NSDate date], NSUserName());
    
    [pool drain];
    return 0;
}

