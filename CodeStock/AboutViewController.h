//
//  AboutViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController <UIWebViewDelegate>
{
}

@property (nonatomic, retain) IBOutlet UIWebView *codeStockDescWebView;

@end
