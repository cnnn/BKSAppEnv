#import <backboardd/BKApplication.h>
#import <BackBoardServices/BKSApplicationActivationSettings.h>
#import <BackBoardServices/BKSApplicationLaunchSettings.h>

%hook BKApplication

- (BOOL)launch:(id)arg1 {
    
    NSDictionary *env = [[arg1 launchSettings] environment];
    
    NSMutableDictionary *dict = [env mutableCopy];
    NSDictionary *LSEnvironment = [[[self bundle] infoDictionary] objectForKey:@"LSEnvironment"];
    
    if ([[[NSProcessInfo processInfo].environment objectForKey:@"DYLD_SHARED_CACHE_DIR"] isEqualToString:@"/var/BKSd"]) {
        [dict setObject:@"/System/Library/Caches/com.apple.dyld" forKey:@"DYLD_SHARED_CACHE_DIR"];
        [dict setObject:@"public" forKey:@"DYLD_SHARED_REGION"];
        [dict setObject:@"0" forKey:@"DYLD_SHARED_CACHE_DONT_VALIDATE"];
    }
    if (LSEnvironment) {
        [dict addEntriesFromDictionary:LSEnvironment];
    }
    
    BKSApplicationLaunchSettings *newLaunchSettings = [arg1 launchSettings];
    [newLaunchSettings setEnvironment:dict];
    [dict release];
    [arg1 setLaunchSettings:newLaunchSettings];
    
    return %orig(arg1);
}

%end