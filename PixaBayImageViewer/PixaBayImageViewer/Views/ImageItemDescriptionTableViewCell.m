//
//  ImageItemDescriptionTableViewCell.m
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ImageItemDescriptionTableViewCell.h"

@interface ImageItemDescriptionTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel* parameterName;
@property (weak, nonatomic) IBOutlet UILabel* parameterValue;

@end

@implementation ImageItemDescriptionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)prepareForReuse {
  [super prepareForReuse];
  self.parameterName.text = @"";
  self.parameterName.text = @"";
}

-(void)setParameterNameText:(NSString *)parameterNameText
{
  self.parameterName.text = parameterNameText;
}

-(void)setParameterValueText:(NSString *)parameterValueText {
  self.parameterValue.text = parameterValueText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
