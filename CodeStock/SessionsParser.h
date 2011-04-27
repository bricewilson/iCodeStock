//
//  SessionsParser.h
//  CodeStock
//
//  Created by Brice Wilson on 4/14/11.
//  Copyright 2011 TeamHealth. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Session;


@interface SessionsParser : NSObject  <NSXMLParserDelegate>
{
}

@property (nonatomic, retain) NSMutableString *currentXMLValue;
@property (nonatomic, retain) Session *currentSession;
@property (nonatomic, retain) NSMutableArray *allSessions;

- (id) init;

@end
