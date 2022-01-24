#import "ApodDataFetcher.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kAPIKey = @"IXmzbad7DTsMBpLwMn6lWJlo2ZaNIqbZrOgpaBvR";
static NSString *const kResponseDictionaryImageUrlKey = @"url";
static NSString *const kResponseDictionaryDateKey = @"date";
static NSString *const kResponseDictionaryTitleKey = @"title";
static NSString *const kResponseDictionaryDescriptionKey = @"explanation";

@implementation ApodDataFetcher

+ (void)fetchAPOFForDate:(nullable NSDate *)date completion:(void (^)(NSString *imageURL, NSString *title, NSString *description))completion {
    NSString *queryComponent;
    if (date) {
        NSString *dateString = [self formatDate:date];
        queryComponent =[NSString stringWithFormat:@"api_key=%@&date=%@", kAPIKey, dateString];
    } else {
        queryComponent = [NSString stringWithFormat:@"api_key=%@", kAPIKey];
    }
    
    NSMutableURLRequest *request = [self createRequestWithQueryComponent:queryComponent];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in API call");
            return;
        }
        
        NSError *err = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        NSString *imageURL = jsonData[@"url"];
        NSString *title = jsonData[@"title"];
        NSString *description = jsonData[@"explanation"];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(imageURL, title, description);
        });
        
    }];
    [dataTask resume];
}

+ (void)fetchAPOFForStartDate:(nullable NSDate *)startDate endDate:(NSDate *)endDate completion:(void (^)(NSArray<NSDictionary *> *responses))completion {
    NSString *startDateString = @"2022-01-05"; //[self formatDate:startDate];
    NSString *endDateString = @"2022-01-07";//[self formatDate:endDate];
    NSString *queryComponent = [NSString stringWithFormat:@"api_key=%@&start_date=%@&end_date=%@", kAPIKey, startDateString, endDateString];
    
    NSMutableURLRequest *request = [self createRequestWithQueryComponent:queryComponent];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error in API call");
            return;
        }
        
        NSError *err = nil;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        NSMutableArray *responses = [[NSMutableArray alloc] init];
        
        for (NSDictionary *individualJsonData in jsonData) {
            NSMutableDictionary *singleResponseDictionary = [[NSMutableDictionary alloc] init];
            NSString *imageURL = individualJsonData[@"url"];
            NSString *description = individualJsonData[@"explanation"];
            NSString *date = individualJsonData[@"date"];
            NSString *title = individualJsonData[@"title"];
            
            [singleResponseDictionary setValue:imageURL forKey:kResponseDictionaryImageUrlKey];
            [singleResponseDictionary setValue:description forKey:kResponseDictionaryDescriptionKey];
            [singleResponseDictionary setValue:date forKey:kResponseDictionaryDateKey];
            [singleResponseDictionary setValue:title forKey:kResponseDictionaryTitleKey];
            
            [responses addObject:[singleResponseDictionary copy]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(responses);
        });
        
    }];
    [dataTask resume];
}

#pragma mark - Private Helpers

+ (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
}

+ (NSMutableURLRequest *)createRequestWithQueryComponent:(NSString *)queryComponent {
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.nasa.gov";
    components.path = @"/planetary/apod";
    components.query = queryComponent;
    NSURL *url = components.URL;
    NSLog(@"URL = %@", url.absoluteString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:url];
    
    return request;
}

@end

NS_ASSUME_NONNULL_END

