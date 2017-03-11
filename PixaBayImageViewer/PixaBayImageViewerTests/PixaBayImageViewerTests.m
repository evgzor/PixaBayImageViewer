//
//  PixaBayImageViewerTests.m
//  PixaBayImageViewerTests
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkingProcessing.h"
#import "AFNetworking.h"

static NSTimeInterval const kTimeOut = 10.f;
static NSString *const kUrlReq = @"https://pixabay.com/api";
static NSString *const kPersonalToken = @"4787339-d63fe94a98390ef456fd6cab8";

@interface PixaBayImageViewerTests : XCTestCase
@property (nonatomic,strong)  id responceObject;
@property (nonatomic,strong)  NSDictionary* staticObject;
@end

@implementation PixaBayImageViewerTests

- (void)setUp {
    [super setUp];
  
  //__weak typeof(self) weakSelf = self;
  
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  NSDictionary* parameters = @{@"key": kPersonalToken, @"q": @"apples", @"image_type": @"photo"};
  [manager GET:kUrlReq parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON: %@", jsonString);
    self.responceObject = responseObject;
    
  } failure:^(NSURLSessionTask *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    
  }];
  
  while (!self.responceObject) {
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
  }
  self.staticObject = [[self class] dictionaryWithContentsOfJSONString:@"sampleData.json"][@"hits"];
}

- (void)tearDown {
    [super tearDown];
}

+(id)dictionaryWithContentsOfJSONString:(NSString*)fileLocation{
  
  
  NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:fileLocation.stringByDeletingPathExtension ofType:fileLocation.pathExtension];
  NSData* data = [NSData dataWithContentsOfFile:filePath];
  __autoreleasing NSError* error = nil;
  id result = [NSJSONSerialization JSONObjectWithData:data
                                              options:NSJSONReadingMutableContainers error:&error];
  
  if (error != nil) return nil;
  return result;
}

- (void)testAListRetrive {
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"Request should retrive list"];
  [NetworkingProcessing retrieveDataFromPixabay:^(NSArray *imagesData) {
    XCTAssertGreaterThan(imagesData.count, (uint)1);
    [expectation fulfill];
  } onError:^(NSError *error) {
    XCTFail(@"Server Error");
  } forQuery:@"apples"];
  
  [self waitForExpectationsWithTimeout:kTimeOut handler:^(NSError *error) {
    if (error != nil) {
      NSLog(@"Error: %@", error.localizedDescription);
      XCTFail(@"Server Error");
    }
    
  }];
}


-(void) testCParceList
{
  NSArray* dataFromFile = [Hits arrayWithResultsArray: (NSArray*)self.staticObject];
  
  XCTAssertGreaterThan(dataFromFile.count, (uint)1);
  
  /*"id": 52970,
   "iserId": "julenka",
   "comments" : 9,
   "tags" : "apples, red, green apple"
   */
  
  Hits* item = dataFromFile[0];
  
  XCTAssertEqual((NSInteger)item.userId, 52970);
  XCTAssertEqualObjects(item.user, @"julenka");
  XCTAssertEqual(item.comments, 9);
  XCTAssertEqualObjects(item.tags, @"apples, red, green apple");
  
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
