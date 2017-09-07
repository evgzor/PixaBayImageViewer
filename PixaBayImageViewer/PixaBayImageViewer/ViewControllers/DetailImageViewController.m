//
//  DetailImageViewController.m
//  PixaBayImageViewer
//
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "DetailImageViewController.h"
#import "UIImageView+LoadImageWithIndicator.h"
#import "ImageItemDescriptionTableViewCell.h"

static NSString* const kHeaderCellIdentifier = @"cellSimple";
static NSString* const kCellIdentifier = @"cell";

static NSString* const kParameterUserName = @"User Name";
static NSString* const kParameterImageTags = @"Tags";
static NSString* const kParameterNumberOfLikes = @"Likes";
static NSString* const kParameterNumberOfFavorites = @"Favorites";
static NSString* const kParameterNumberOfComments = @"Comments";

@interface DetailImageViewController ()

@property(nonatomic, weak) IBOutlet UIImageView* detailImageView;
@property (copy) NSArray* dataListParameters;

@end

@implementation DetailImageViewController

#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
  [self.detailImageView loadImageWithIndicatorByURL:self.hit.webformatURL onError:^(NSError *error) {
    dispatch_async(dispatch_get_main_queue(), ^{

      UIAlertController *errorAlert =  [UIAlertController
                                        alertControllerWithTitle: NSLocalizedString(@"Server Error", @"Get Data")
                                        message:NSLocalizedString(@"Cannot dowload picture from repository, please check connection settings", @"Retrieve data from Pixabay")
                                        preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *cancelAction   = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {}];
      [errorAlert addAction:cancelAction];
      
      [self presentViewController:errorAlert animated:YES completion:nil];
    });
  }];
  
  
  self.dataListParameters = @[@{kParameterUserName: self.hit.user}, @{kParameterImageTags: self.hit.tags}, @{kParameterNumberOfLikes: @(self.hit.likes)}, @{kParameterNumberOfFavorites: @(self.hit.comments)}, @{kParameterNumberOfComments: @(self.hit.comments)}];
  }

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:    (NSInteger)section
{
  return (NSInteger)self.dataListParameters.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  // Similar to UITableViewCell, but
  ImageItemDescriptionTableViewCell *cell = (ImageItemDescriptionTableViewCell *)[theTableView dequeueReusableCellWithIdentifier: kCellIdentifier];

  cell.parameterNameText = [NSString stringWithFormat:@"%@", [self.dataListParameters[(NSUInteger)indexPath.row] allKeys].firstObject];
  cell.parameterValueText = [NSString stringWithFormat:@"%@", [self.dataListParameters[(NSUInteger)indexPath.row] allValues].firstObject];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

#pragma mark - UITableView Delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCellIdentifier];

  cell.textLabel.text = NSLocalizedString(@"Description Image", nil);
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 1.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
}

@end
