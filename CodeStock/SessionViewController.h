//
//  SessionViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Session;
@class Speaker;

@interface SessionViewController : UIViewController <UIWebViewDelegate>
{
	UIBarButtonItem *speakerButton;
}

@property (nonatomic, retain) Session *currentSession;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *sessionDate;
@property (nonatomic, retain) IBOutlet UILabel *sessionTime;
@property (nonatomic, retain) IBOutlet UILabel *roomLabel;
@property (nonatomic, retain) IBOutlet UILabel *speakerLabel;
@property (nonatomic, retain) Speaker *speaker;
@property (nonatomic, retain) IBOutlet UIWebView *abstractWebView;

- (void) showSpeaker;

@end
