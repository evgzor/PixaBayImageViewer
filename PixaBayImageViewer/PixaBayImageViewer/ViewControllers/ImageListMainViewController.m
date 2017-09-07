//
//  ViewController.m
//  PixaBayImageViewer
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ImageListMainViewController.h"
#import "DataModels.h"
#import "NetworkingProcessing.h"
#import "ImageMainListTableViewCell.h"
#import "DetailImageViewController.h"

static NSString* const kTriggerQuerry = @"apples";

@interface ImageListMainViewController ()

@property(weak, nonatomic) IBOutlet UITableView* tableView;
@property(weak, nonatomic) IBOutlet UISearchBar* searchBar;
@property(copy) NSArray* dataList;
@property(nonatomic, strong) UIActivityIndicatorView* spinner;
@property (assign) NSUInteger selectedCell;

@end

@implementation ImageListMainViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  self.searchBar.text = kTriggerQuerry;

}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (!self.spinner) {
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.spinner];
    self.spinner.center = self.view.center;
    [self fetchDataForQuery: kTriggerQuerry];
  }
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection: (NSInteger)section
{
  return (NSInteger)self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)theTableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"cell";
  
  // Similar to UITableViewCell, but
  ImageMainListTableViewCell *cell = (ImageMainListTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
  Hits* hit = (Hits*)_dataList[(NSUInteger)indexPath.row];
  cell.titleText = hit.user;
  cell.subTitleText = hit.tags;
  cell.imageUrl = hit.previewURL;
  return cell;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  [super prepareForSegue:segue sender:sender];
  
   if ([segue.identifier isEqualToString:@"detail"] && [sender isKindOfClass: [UITableViewCell class]]) {
    DetailImageViewController* detailViewController = segue.destinationViewController;
     UITableViewCell* cell = sender;
     NSUInteger row = (NSUInteger)[self.tableView indexPathForCell:cell].row;
     detailViewController.hit = (Hits*)_dataList[row];
  }
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UISerchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [searchBar resignFirstResponder];
  [self fetchDataForQuery:searchBar.text];
  
}

#pragma mark - keyboard show/hide

- (void)keyboardWillShow:(NSNotification *)notification
{
  CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  
  UIEdgeInsets contentInsets;
  if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
    contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
  } else {
    contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
  }
  
  self.tableView.contentInset = contentInsets;
  self.tableView.scrollIndicatorInsets = contentInsets;
  //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  self.tableView.contentInset = UIEdgeInsetsZero;
  self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark - Data Fetching

-(void)fetchDataForQuery:(NSString*)query {
  
  [self.spinner startAnimating];
  

  [NetworkingProcessing retrieveDataFromPixabay:^(NSArray *imagesData) {
    
    self.dataList                 = imagesData;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.tableView reloadData];
      [self.spinner stopAnimating];
    });
    
  } onError:^(NSError *error) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
      
      [self.spinner stopAnimating];
      
      UIAlertController *errorAlert =  [UIAlertController
                                        alertControllerWithTitle: NSLocalizedString(@"Server Error", @"Get Data")
                                        message:NSLocalizedString(@"Cannot access to the Pixabay repository list, please check connection settings", @"Retrieve data from Pixabay")
                                        preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *cancelAction   = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {}];
      [errorAlert addAction:cancelAction];
      
      [self presentViewController:errorAlert animated:YES completion:nil];
    });
    
  } forQuery: [query stringByReplacingOccurrencesOfString:@" " withString: @"+"]];
}

@end
