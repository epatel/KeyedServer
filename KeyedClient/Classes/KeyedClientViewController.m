//
//  KeyedClientViewController.m
//  KeyedClient
//
//  Created by Edward Patel on 2010-01-31.
//  Copyright Memention AB 2010. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access

// The php script has a md5 check of the archive so it don't try to read a 
// corrupt one. So these are used to get the md5 here for the server to check
// against...

@interface NSData (Private)
- (NSString*)md5;
@end

@implementation NSData (Private)
- (NSString*)md5
{
    unsigned char result[16];
    CC_MD5( self.bytes, self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];  
}
@end

#import "KeyedClientViewController.h"
#import "ASIFormDataRequest.h"

@implementation KeyedClientViewController

- (IBAction)send:(id)sender
{
	if (spinner.hidden) {
		spinner.hidden = NO;
		[spinner startAnimating];

#error Enter hostname and username for your setup below
		NSURL *url = [NSURL URLWithString:@"http://hostname/~username/keyed.php"];

		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request setDelegate:self];
		
		NSMutableData *data = [NSMutableData data];
		NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
		
		[arch encodeObject:nameField.text forKey:@"name"];
		[arch encodeFloat:value1Slider.value forKey:@"v1"];
		[arch encodeInt:value2Slider.value forKey:@"v2"];
		
		[arch finishEncoding];
		
		[request setData:data forKey:@"arch"];
		[request setPostValue:[data md5] forKey:@"csum"];
		
		[request startAsynchronous];
	}
}

- (IBAction)valueChanged:(id)sender
{
	if (sender == value1Slider) {
		value1Label.text = [NSString stringWithFormat:@"%.2f",[value1Slider value]];
	}
	if (sender == value2Slider) {
		value2Label.text = [NSString stringWithFormat:@"%d",(int)[value2Slider value]];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
	
	@try {
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:responseData];
		NSString *greet = [unarchiver decodeObjectForKey:@"greet"];
		float sum = [unarchiver decodeFloatForKey:@"sum"];
		[unarchiver finishDecoding];
		resultLabel.text = [NSString stringWithFormat:@"%@ - sum: %.2f", greet, sum];
	}
	@catch (NSException *e) {
		resultLabel.text = [e description];
	}	
	[spinner stopAnimating];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	resultLabel.text = [error description];
	[spinner stopAnimating];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self valueChanged:value1Slider];
	[self valueChanged:value2Slider];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
