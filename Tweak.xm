#import "TUCall.h"
@interface AVSystemController
+ (id)sharedAVSystemController;
- (BOOL)setVolumeTo:(float)arg1 forCategory:(id)arg2;
@end
@interface SBMediaController
- (_Bool)isRingerMuted;
+ (id)sharedInstance;
- (void)setRingerMuted:(BOOL)arg1;
@end
@interface TUCallCenter
+(id)sharedInstance;
- (id)incomingCall;
@end
static BOOL muteState = NO;
static BOOL enabled = YES;
static NSString * savedName;
%hook TUCall
-(void)_handleStatusChange{
	%orig;
	TUCall * incomingCall = [[%c(TUCallCenter) sharedInstance] incomingCall];
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.joemerlino.powercaller.plist"];
	savedName = [prefs objectForKey:@"savedName"];
	enabled = ([prefs objectForKey:@"enabled"] ? [[prefs objectForKey:@"enabled"] boolValue] : YES);
	if(enabled && [incomingCall.displayName containsString:savedName] && [(SBMediaController *)[%c(SBMediaController) sharedInstance] isRingerMuted]){
		muteState = YES;
		[((SBMediaController *)[%c(SBMediaController) sharedInstance]) setRingerMuted:NO];
		[[%c(AVSystemController) sharedAVSystemController] setVolumeTo:1.0f forCategory:@"Ringtone"];
	}
	else if(!incomingCall.displayName && muteState){
		muteState = NO;
		[((SBMediaController *)[%c(SBMediaController) sharedInstance]) setRingerMuted:YES];
	}
}
%end