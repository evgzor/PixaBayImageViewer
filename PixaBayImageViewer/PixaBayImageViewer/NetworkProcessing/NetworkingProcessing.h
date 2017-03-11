//
//  NetworkingProcessing.h
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

@interface NetworkingProcessing : NSObject
/**
 *  Retrieve list of images from "pixabay" reopository for user token
 *
 *  @param completitionBlock sucsessful retriving data from responce
 *  @param errorBlock        error processing from responce
 *  @param query             search query
 */
+(void)retrieveDataFromPixabay:(void(^)(NSArray* imagesData))completitionBlock onError:(void(^)(NSError* error))errorBlock forQuery:(NSString*) query;

@end
