//
//  PixaBayImageModel.m
//
//  Created by Evgeny Zorin on 09/03/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "PixaBayImageModel.h"
#import "Hits.h"


static NSString *const kPixaBayImageModelHits = @"hits";
static NSString *const kPixaBayImageModelTotal = @"total";
static NSString *const kPixaBayImageModelTotalHits = @"totalHits";


@interface PixaBayImageModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PixaBayImageModel

@synthesize hits = _hits;
@synthesize total = _total;
@synthesize totalHits = _totalHits;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedHits = dict[kPixaBayImageModelHits];
    NSMutableArray *parsedHits = [NSMutableArray array];
    if ([receivedHits isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHits) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHits addObject:[Hits modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHits isKindOfClass:[NSDictionary class]]) {
       [parsedHits addObject:[Hits modelObjectWithDictionary:(NSDictionary *)receivedHits]];
    }

    _hits = [NSArray arrayWithArray:parsedHits];
            _total = [[self objectOrNilForKey:kPixaBayImageModelTotal fromDictionary:dict] doubleValue];
            _totalHits = [[self objectOrNilForKey:kPixaBayImageModelTotalHits fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForHits = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hits) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHits addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHits addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHits] forKey:kPixaBayImageModelHits];
    [mutableDict setValue:@(self.total) forKey:kPixaBayImageModelTotal];
    [mutableDict setValue:@(self.totalHits) forKey:kPixaBayImageModelTotalHits];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = dict[aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    _hits = [aDecoder decodeObjectForKey:kPixaBayImageModelHits];
    _total = [aDecoder decodeDoubleForKey:kPixaBayImageModelTotal];
    _totalHits = [aDecoder decodeDoubleForKey:kPixaBayImageModelTotalHits];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hits forKey:kPixaBayImageModelHits];
    [aCoder encodeDouble:_total forKey:kPixaBayImageModelTotal];
    [aCoder encodeDouble:_totalHits forKey:kPixaBayImageModelTotalHits];
}

- (id)copyWithZone:(NSZone *)zone
{
    PixaBayImageModel *copy = [[[self class] alloc] init];
    
    if (copy) {

        copy.hits = [self.hits copyWithZone:zone];
        copy.total = self.total;
        copy.totalHits = self.totalHits;
    }
    
    return copy;
}

+ (NSArray*)arrayWithResultsArray:(NSArray*)array
{
  NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:array.count];
  for (NSDictionary* dictionary in array)
  {
    [tempArray addObject:[self modelObjectWithDictionary: dictionary]];
  }
  return [NSArray arrayWithArray:tempArray];
}



@end
