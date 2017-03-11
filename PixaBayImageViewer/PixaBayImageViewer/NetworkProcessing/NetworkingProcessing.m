//
//  NetworkingProcessing.m
//

#import "NetworkingProcessing.h"
#import "AFNetworking.h"

NSString *const kPixaBayRepoUrl = @"https://pixabay.com/api";
NSString *const kPersonalToken = @"4787339-d63fe94a98390ef456fd6cab8";


@implementation NetworkingProcessing

+(void)retrieveDataFromPixabay:(void(^)(NSArray* imagesData))completitionBlock onError:(void(^)(NSError* error))errorBlock forQuery:(NSString*) query
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?key=%@&q=%@",kPixaBayRepoUrl,kPersonalToken,query]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            errorBlock(error);
        } else {
            NSArray* dataArray = [PixaBayImageModel modelObjectWithDictionary:responseObject].hits;
            
            completitionBlock(dataArray);
        }
    }];
    [dataTask resume];
  
}


@end
