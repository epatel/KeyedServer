//
//  KeyedClientViewController.h
//  KeyedClient
//
//  Created by Edward Patel on 2010-01-31.
//  Copyright Memention AB 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyedClientViewController : UIViewController {
	IBOutlet UITextField *nameField;
	IBOutlet UILabel *value1Label;
	IBOutlet UILabel *value2Label;
	IBOutlet UISlider *value1Slider;
	IBOutlet UISlider *value2Slider;
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UILabel *resultLabel;
}

- (IBAction)send:(id)sender;
- (IBAction)valueChanged:(id)sender;

@end

