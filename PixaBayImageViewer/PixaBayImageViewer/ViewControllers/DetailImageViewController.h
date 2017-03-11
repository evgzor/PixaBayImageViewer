//
//  DetailImageViewController.h
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"

@interface DetailImageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Hits* hit;

@end
