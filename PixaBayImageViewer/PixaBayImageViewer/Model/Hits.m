//
//  Hits.m
//
//  Created by Evgeny Zorin on 09/03/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Hits.h"


static NSString *const kHitsFavorites = @"favorites";
static NSString *const kHitsLikes = @"likes";
static NSString *const kHitsUserId = @"user_id";
static NSString *const kHitsDownloads = @"downloads";
static NSString *const kHitsImageWidth = @"imageWidth";
static NSString *const kHitsTags = @"tags";
static NSString *const kHitsWebformatHeight = @"webformatHeight";
static NSString *const kHitsImageHeight = @"imageHeight";
static NSString *const kHitsWebformatURL = @"webformatURL";
static NSString *const kHitsWebformatWidth = @"webformatWidth";
static NSString *const kHitsViews = @"views";
static NSString *const kHitsType = @"type";
static NSString *const kHitsPageURL = @"pageURL";
static NSString *const kHitsId = @"id";
static NSString *const kHitsPreviewHeight = @"previewHeight";
static NSString *const kHitsPreviewURL = @"previewURL";
static NSString *const kHitsUser = @"user";
static NSString *const kHitsPreviewWidth = @"previewWidth";
static NSString *const kHitsComments = @"comments";
static NSString *const kHitsUserImageURL = @"userImageURL";


@interface Hits ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Hits

@synthesize favorites = _favorites;
@synthesize likes = _likes;
@synthesize userId = _userId;
@synthesize downloads = _downloads;
@synthesize imageWidth = _imageWidth;
@synthesize tags = _tags;
@synthesize webformatHeight = _webformatHeight;
@synthesize imageHeight = _imageHeight;
@synthesize webformatURL = _webformatURL;
@synthesize webformatWidth = _webformatWidth;
@synthesize views = _views;
@synthesize type = _type;
@synthesize pageURL = _pageURL;
@synthesize hitsIdentifier = _hitsIdentifier;
@synthesize previewHeight = _previewHeight;
@synthesize previewURL = _previewURL;
@synthesize user = _user;
@synthesize previewWidth = _previewWidth;
@synthesize comments = _comments;
@synthesize userImageURL = _userImageURL;


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
            _favorites = [[self objectOrNilForKey:kHitsFavorites fromDictionary:dict] integerValue];
            _likes = [[self objectOrNilForKey:kHitsLikes fromDictionary:dict] integerValue];
            _userId = [[self objectOrNilForKey:kHitsUserId fromDictionary:dict] integerValue];
            _downloads = [[self objectOrNilForKey:kHitsDownloads fromDictionary:dict] integerValue];
            _imageWidth = [[self objectOrNilForKey:kHitsImageWidth fromDictionary:dict] doubleValue];
            _tags = [self objectOrNilForKey:kHitsTags fromDictionary:dict];
            _webformatHeight = [[self objectOrNilForKey:kHitsWebformatHeight fromDictionary:dict] doubleValue];
            _imageHeight = [[self objectOrNilForKey:kHitsImageHeight fromDictionary:dict] doubleValue];
            _webformatURL = [NSURL URLWithString:[self objectOrNilForKey:kHitsWebformatURL fromDictionary:dict]];
            _webformatWidth = [[self objectOrNilForKey:kHitsWebformatWidth fromDictionary:dict] doubleValue];
            _views = [[self objectOrNilForKey:kHitsViews fromDictionary:dict] doubleValue];
            _type = [self objectOrNilForKey:kHitsType fromDictionary:dict];
            _pageURL = [NSURL URLWithString:[self objectOrNilForKey:kHitsPageURL fromDictionary:dict]];
            _hitsIdentifier = [[self objectOrNilForKey:kHitsId fromDictionary:dict] doubleValue];
            _previewHeight = [[self objectOrNilForKey:kHitsPreviewHeight fromDictionary:dict] doubleValue];
            _previewURL = [NSURL URLWithString:[self objectOrNilForKey:kHitsPreviewURL fromDictionary:dict]];
            _user = [self objectOrNilForKey:kHitsUser fromDictionary:dict];
            _previewWidth = [[self objectOrNilForKey:kHitsPreviewWidth fromDictionary:dict] doubleValue];
            _comments = [[self objectOrNilForKey:kHitsComments fromDictionary:dict] integerValue];
            _userImageURL = [NSURL URLWithString:[self objectOrNilForKey:kHitsUserImageURL fromDictionary:dict]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:@(self.favorites) forKey:kHitsFavorites];
    [mutableDict setValue:@(self.likes) forKey:kHitsLikes];
    [mutableDict setValue:@(self.userId) forKey:kHitsUserId];
    [mutableDict setValue:@(self.downloads) forKey:kHitsDownloads];
    [mutableDict setValue:@(self.imageWidth) forKey:kHitsImageWidth];
    [mutableDict setValue:self.tags forKey:kHitsTags];
    [mutableDict setValue:@(self.webformatHeight) forKey:kHitsWebformatHeight];
    [mutableDict setValue:@(self.imageHeight) forKey:kHitsImageHeight];
    [mutableDict setValue:self.webformatURL forKey:kHitsWebformatURL];
    [mutableDict setValue:@(self.webformatWidth) forKey:kHitsWebformatWidth];
    [mutableDict setValue:@(self.views) forKey:kHitsViews];
    [mutableDict setValue:self.type forKey:kHitsType];
    [mutableDict setValue:self.pageURL forKey:kHitsPageURL];
    [mutableDict setValue:@(self.hitsIdentifier) forKey:kHitsId];
    [mutableDict setValue:@(self.previewHeight) forKey:kHitsPreviewHeight];
    [mutableDict setValue:self.previewURL forKey:kHitsPreviewURL];
    [mutableDict setValue:self.user forKey:kHitsUser];
    [mutableDict setValue:@(self.previewWidth) forKey:kHitsPreviewWidth];
    [mutableDict setValue:@(self.comments) forKey:kHitsComments];
    [mutableDict setValue:self.userImageURL forKey:kHitsUserImageURL];

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

    _favorites = [aDecoder decodeIntegerForKey:kHitsFavorites];
    _likes = [aDecoder decodeIntegerForKey:kHitsLikes];
    _userId = [aDecoder decodeIntegerForKey:kHitsUserId];
    _downloads = [aDecoder decodeIntegerForKey:kHitsDownloads];
    _imageWidth = [aDecoder decodeDoubleForKey:kHitsImageWidth];
    _tags = [aDecoder decodeObjectForKey:kHitsTags];
    _webformatHeight = [aDecoder decodeDoubleForKey:kHitsWebformatHeight];
    _imageHeight = [aDecoder decodeDoubleForKey:kHitsImageHeight];
    _webformatURL = [aDecoder decodeObjectForKey:kHitsWebformatURL];
    _webformatWidth = [aDecoder decodeDoubleForKey:kHitsWebformatWidth];
    _views = [aDecoder decodeDoubleForKey:kHitsViews];
    _type = [aDecoder decodeObjectForKey:kHitsType];
    _pageURL = [aDecoder decodeObjectForKey:kHitsPageURL];
    _hitsIdentifier = [aDecoder decodeDoubleForKey:kHitsId];
    _previewHeight = [aDecoder decodeDoubleForKey:kHitsPreviewHeight];
    _previewURL = [aDecoder decodeObjectForKey:kHitsPreviewURL];
    _user = [aDecoder decodeObjectForKey:kHitsUser];
    _previewWidth = [aDecoder decodeDoubleForKey:kHitsPreviewWidth];
    _comments = [aDecoder decodeIntegerForKey:kHitsComments];
    _userImageURL = [aDecoder decodeObjectForKey:kHitsUserImageURL];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeInteger:_favorites forKey:kHitsFavorites];
    [aCoder encodeInteger:_likes forKey:kHitsLikes];
    [aCoder encodeDouble:_userId forKey:kHitsUserId];
    [aCoder encodeInteger:_downloads forKey:kHitsDownloads];
    [aCoder encodeDouble:_imageWidth forKey:kHitsImageWidth];
    [aCoder encodeObject:_tags forKey:kHitsTags];
    [aCoder encodeDouble:_webformatHeight forKey:kHitsWebformatHeight];
    [aCoder encodeDouble:_imageHeight forKey:kHitsImageHeight];
    [aCoder encodeObject:_webformatURL forKey:kHitsWebformatURL];
    [aCoder encodeDouble:_webformatWidth forKey:kHitsWebformatWidth];
    [aCoder encodeDouble:_views forKey:kHitsViews];
    [aCoder encodeObject:_type forKey:kHitsType];
    [aCoder encodeObject:_pageURL forKey:kHitsPageURL];
    [aCoder encodeDouble:_hitsIdentifier forKey:kHitsId];
    [aCoder encodeDouble:_previewHeight forKey:kHitsPreviewHeight];
    [aCoder encodeObject:_previewURL forKey:kHitsPreviewURL];
    [aCoder encodeObject:_user forKey:kHitsUser];
    [aCoder encodeDouble:_previewWidth forKey:kHitsPreviewWidth];
    [aCoder encodeInteger:_comments forKey:kHitsComments];
    [aCoder encodeObject:_userImageURL forKey:kHitsUserImageURL];
}

- (id)copyWithZone:(NSZone *)zone
{
    Hits *copy = [[[self class]  alloc] init];
    
    if (copy) {

        copy.favorites = self.favorites;
        copy.likes = self.likes;
        copy.userId = self.userId;
        copy.downloads = self.downloads;
        copy.imageWidth = self.imageWidth;
        copy.tags = [self.tags copyWithZone:zone];
        copy.webformatHeight = self.webformatHeight;
        copy.imageHeight = self.imageHeight;
        copy.webformatURL = [self.webformatURL copyWithZone:zone];
        copy.webformatWidth = self.webformatWidth;
        copy.views = self.views;
        copy.type = [self.type copyWithZone:zone];
        copy.pageURL = [self.pageURL copyWithZone:zone];
        copy.hitsIdentifier = self.hitsIdentifier;
        copy.previewHeight = self.previewHeight;
        copy.previewURL = [self.previewURL copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.previewWidth = self.previewWidth;
        copy.comments = self.comments;
        copy.userImageURL = [self.userImageURL copyWithZone:zone];
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
