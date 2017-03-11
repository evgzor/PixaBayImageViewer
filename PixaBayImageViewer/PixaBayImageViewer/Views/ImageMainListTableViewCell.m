//
//  ImageMainListTableViewCell.m
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ImageMainListTableViewCell.h"
#import "UIImageView+LoadImageWithIndicator.h"

@interface ImageMainListTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView* customImageView;
@property (nonatomic, weak) IBOutlet UILabel* title;
@property (nonatomic, weak) IBOutlet UILabel* subTitle;

@end

@implementation ImageMainListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)prepareForReuse {
  
  [super prepareForReuse];
  self.customImageView.image = nil;
  self.titleText = @"";
  self.subTitleText = @"";
}

-(void)setImageUrl:(NSURL *)imageUrl
{
  [self.customImageView loadImageWithIndicatorByURL:imageUrl onError:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTitleText:(NSString *)titleText
{
  self.title.text = titleText;
}

-(void)setSubTitleText:(NSString *)subTitleText
{
  self.subTitle.text = subTitleText;
}

@end
