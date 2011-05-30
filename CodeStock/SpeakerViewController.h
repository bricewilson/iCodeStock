//
//  SpeakerViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/13/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Speaker;

@interface SpeakerViewController : UIViewController <UIWebViewDelegate>
{
	//NSOperationQueue *queue;
}

@property (nonatomic, retain) Speaker *speaker;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *companyLabel;
@property (nonatomic, retain) IBOutlet UILabel *twitterIDLabel;
@property (nonatomic, retain) IBOutlet UILabel *websiteLabel;
@property (nonatomic, retain) IBOutlet UIImageView *speakerImage;
@property (nonatomic, retain) IBOutlet UIWebView *speakerBioWebView;
@property (nonatomic, retain) IBOutlet UITextView *websiteTextView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *waitIndicator;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *dataWaitIndicator;

//- (void)loadImage;

@end
