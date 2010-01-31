/* ========================================================================
 *
 * Author: Edward Patel, Memention AB, http://memention.com
 *
 * ======================================================================== */

#import <Foundation/Foundation.h>

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Decode received archive
	NSData *rdata = [NSData dataWithContentsOfFile:
					 [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding]];
	NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:rdata];
	
	// Get some expected things
	NSString *name = [unarch decodeObjectForKey:@"name"];
	float v1 = [unarch decodeFloatForKey:@"v1"];
	int v2 = [unarch decodeIntForKey:@"v2"];
	[unarch finishDecoding];
	
	// Encode to send
	NSMutableData *sdata = [NSMutableData data];
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:sdata];
	
	[arch encodeObject:[NSString stringWithFormat:@"Hello %@!", name] forKey:@"greet"];
	[arch encodeFloat:v1+v2 forKey:@"sum"];
	[arch finishEncoding];
	
	// And spit it out...
	int len = sdata.length;
	const unsigned char *body = sdata.bytes;
	
	for (int i=0; i<len; i++) 
		printf("%c", body[i]);
	
    [pool drain];
    return 0;
}
