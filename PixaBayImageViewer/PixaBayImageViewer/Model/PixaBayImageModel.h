//
//  PixaBayImageModel.h
//
//  Created by Evgeny Zorin on 09/03/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PixaBayImageModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSArray *hits;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) double totalHits;

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
