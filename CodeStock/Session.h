//
//  Session.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Session : NSObject
{
}

@property (nonatomic, retain) NSString *sessionAbstract;
@property (nonatomic, retain) NSString *area;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *levelGeneral;
@property (nonatomic, retain) NSString *levelSpecific;
@property (nonatomic, retain) NSString *room;
@property (nonatomic, retain) NSString *sessionID;
@property (nonatomic, retain) NSString *speakerID;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *technology;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *track;
@property (nonatomic, retain) NSDate *startDateTime;
@property (nonatomic, retain) NSDate *endDateTime;
@property (nonatomic, retain) NSString *startTimeFormatted;
@property (nonatomic, retain) NSString *endTimeFormatted;
@property (nonatomic, retain) NSString *startDateFormatted;
@property (nonatomic, retain) NSString *endDateFormatted;

@end
