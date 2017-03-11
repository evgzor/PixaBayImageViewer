//
//  ImageMainListTableViewCell.h
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageMainListTableViewCell : UITableViewCell

  @property(nonatomic, strong) NSURL* imageUrl;
  @property(nonatomic, copy) NSString* titleText;
  @property(nonatomic, copy) NSString* subTitleText;

@end
