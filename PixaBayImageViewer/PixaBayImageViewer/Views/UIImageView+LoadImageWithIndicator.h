//
//  UIImageView+LoadImageWithIndicator.h
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LoadImageWithIndicator)
/**
 *  Load asynchronosly image with indicator
 *
 *  @param url url for image
 *
 */
-(void)loadImageWithIndicatorByURL:(NSURL*)url onError:(void(^)(NSError* error))errorBlock;

@end

