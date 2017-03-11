//
//  UIImageView+LoadImageWithIndicator.m
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "UIImageView+LoadImageWithIndicator.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (LoadImageWithIndicator)

-(void)loadImageWithIndicatorByURL:(NSURL*)url onError:(void(^)(NSError* error))errorBlock {
    __block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:activityIndicator];
    activityIndicator.center = self.center;
    [activityIndicator startAnimating];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:30];
    __weak typeof(self) weakSelf = self;
    [self setImageWithURLRequest:imageRequest
                            placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                              weakSelf.image = image;
                              [activityIndicator removeFromSuperview];
                              [activityIndicator stopAnimating];
                            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                              errorBlock(error);
                              [activityIndicator removeFromSuperview];
                              [activityIndicator stopAnimating];
                              
                            }];
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  for (UIView* subView in self.subviews) {
    if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
      subView.center = self.center;
      return;
    }
  }
}

@end
