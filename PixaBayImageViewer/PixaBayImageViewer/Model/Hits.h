//
//  Hits.h
//
//  Created by Evgeny Zorin on 09/03/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Hits : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) NSInteger favorites;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger downloads;
@property (nonatomic, assign) double imageWidth;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, assign) double webformatHeight;
@property (nonatomic, assign) double imageHeight;
@property (nonatomic, strong) NSURL *webformatURL;
@property (nonatomic, assign) double webformatWidth;
@property (nonatomic, assign) double views;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSURL *pageURL;
@property (nonatomic, assign) double hitsIdentifier;
@property (nonatomic, assign) double previewHeight;
@property (nonatomic, strong) NSURL *previewURL;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, assign) double previewWidth;
@property (nonatomic, assign) NSInteger comments;
@property (nonatomic, strong) NSURL *userImageURL;

/**
 *  Static inialization model by dictionary
 *
 *  @param dict NSDictionary instance for convertion ReposData
 *
 *  @return ReposData instance
 */
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
/**
 *  Init instance by dictionary
 *
 *  @param dict NSDictionary instance for convertion ReposData
 *
 *  @return ReposData instance
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

/**
 *  Convert data do NSDictionary instances
 *
 *  @return dictionary converted JsonData
 */
- (NSDictionary *)dictionaryRepresentation;
/**
 *  Fill Array of data by PixaBayImageModel class instances
 *
 *  @param array Array of json dictionaries
 *
 *  @return Array of PixaBayImageModel Dictionaries
 */
+ (NSArray*)arrayWithResultsArray:(NSArray*)array;

@end
