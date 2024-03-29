//
//  APIManager.m
//  GradSchoolZero
//
//  Created by John Jakobsen on 11/29/21.
//

#import "APIManager.h"

@implementation APIManager

+ (NSString *) addParams: (NSDictionary *) params {
    NSMutableString* result = [[NSMutableString alloc] initWithString: @"?"];
    for (NSString *paramName in params) {
        [result appendString: [NSString stringWithFormat: @"%@=%@&", paramName, (NSString *) [params objectForKey: paramName]]];
    }
    return [result substringToIndex: result.length - 1];
}

+ (NSURL *) buildURL: (NSDictionary *) params endpoint: (NSString *) endpoint {
    NSString *urlString = [NSString stringWithFormat: @"http://localhost:3000/%@%@", endpoint, [self addParams: params]];
    NSString *urlStringReplacedSpaces = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL* url = [[NSURL alloc] initWithString:  urlStringReplacedSpaces];
    
    return url;
}

+ (void) POST: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSInteger code)) completion {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setHTTPMethod: @"POST"];
    [req setURL: [self buildURL:params endpoint:endpoint]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
            }
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            completion(error == nil, error, statusCode);
        });
        }] resume] ;
    
}

+ (void) POSTWithRecieving: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSInteger code, NSDictionary *res)) completion {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setHTTPMethod: @"POST"];
    [req setURL: [self buildURL:params endpoint:endpoint]];

    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
            }
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            NSError *jsonError = nil;
            NSDictionary *json = nil;
            if (data != nil) {
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            }
            completion(error == nil, error, statusCode, json);
        });
        }] resume] ;
}

+ (void) GET: (NSString *) endpoint parameters: (NSDictionary *) params completion: (void (^)(bool succeeded, NSError * error, NSDictionary *, NSInteger code)) completion {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setHTTPMethod: @"GET"];
    [req setURL: [self buildURL: params endpoint: endpoint]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"data: %@", data);
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
            }
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            NSError *jsonError = nil;
            NSDictionary *json = nil;
            if (data != nil) {
                json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            }
            completion(error == nil, error, json, statusCode);
        });
        }] resume] ;
}

@end
