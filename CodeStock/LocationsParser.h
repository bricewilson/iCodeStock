//
//  LocationsParser.h
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Location;

@interface LocationsParser : NSObject <NSXMLParserDelegate>
{
}

@property (nonatomic, retain) NSMutableString *currentXMLValue;
@property (nonatomic, retain) Location *currentLocation;
@property (nonatomic, retain) NSMutableArray *allLocations;


@end
