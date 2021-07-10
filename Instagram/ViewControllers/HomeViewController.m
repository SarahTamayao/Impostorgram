//
//  HomeViewController.m
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "Post.h"
#import "PostCell.h"
#import "ComposeViewController.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/PFImageView.h>
#import "NSDate+DateTools.h"
#import "DetailsViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "CommentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HomeViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *story1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayOfPosts;

@property (assign, nonatomic) BOOL dataDoneLoading;
 
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.story1.userInteractionEnabled =YES;
    self.story1.layer.cornerRadius = 30;
    [self.story1.layer setBorderColor: [[UIColor orangeColor] CGColor]];
    [self.story1.layer setBorderWidth: 1.2];
    
    
    
    
    
    
    //get the data to display and store it in local variable
    [self getData:20];

    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    [refreshControl setTintColor:[UIColor lightGrayColor]];
     
    
    //table view delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //get rid of horizontal line separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
     
    
    
  //  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:true];
    
    

    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if( !self.dataDoneLoading && indexPath.row + 1 == [self.arrayOfPosts count]){
        [self getData:(int)[self.arrayOfPosts count] + 20];
    }
 
}

- (void)getData: (int) postLimit {
 
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = postLimit;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSMutableArray* postsMutableArray = [posts mutableCopy];
            self.arrayOfPosts = postsMutableArray;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", @"CANNOT GET STUFF");
        }
    }]; 
}


- (void)refresh {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = self.arrayOfPosts.count;
 
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSMutableArray* postsMutableArray = [posts mutableCopy];
            self.arrayOfPosts = postsMutableArray;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", @"CANNOT GET STUFF");
        }
    }];
    
    [self.tableView reloadData];
  
}


//set how many rows in timeline display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfPosts count]; 
}

//enables custom cell displays
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    Post *post = self.arrayOfPosts[indexPath.row];
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    cell.post = post;
   
    
    cell.profileImage.layer.cornerRadius = 20;
    cell.profileImage.clipsToBounds = YES;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"image"]) {
        PFFileObject *picFile =user[@"image"];
        [picFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if(error==nil) {
                cell.profileImage.image = [UIImage imageWithData:data];
            }
        }];
    
    } 
      
    cell.usernameLabel.text = post.author.username;
    
    cell.smallUsernameLabel.text =post.author.username;
    
    cell.captionLabel.text = post.caption;
    
    cell.postImageView.file = post.image;
    
    cell.dateLabel.text = post.createdAt.timeAgoSinceNow;
    
    NSString* numString = [NSString stringWithFormat:@"%@", post.likeCount];
    cell.numLikesLabel.text = numString;
          
    return cell;
}



// Makes a network request to get updated data
 // Updates the tableView with the new data
 // Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // Parse query
    
    // Reload the tableView now that there is new data
    if(self.arrayOfPosts.count < 20) {
        [self getData: (int) 20];
    } else if(self.arrayOfPosts.count >= 20) {
        [self getData: (int) self.arrayOfPosts.count];
    }
    [self.tableView reloadData];
 
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];

}




- (IBAction)didTapCompose:(id)sender {
    [self performSegueWithIdentifier:@"composeSegue" sender:self];
} 


//when user clicks on Tweet after composing a tweet.
//adds the new tweet onto the tweet array (displays at the top of timeline)
- (void)didPost {
    // Reload the tableView now that there is new data
    [self getData:(int) self.arrayOfPosts.count];
    [self.tableView reloadData];

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    //if the user clicks on compose icon
    if ([[segue identifier] isEqualToString:@"composeSegue"]) {
        UINavigationController *navigationController = [segue destinationViewController];
            ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
            composeController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"detailsSegue"]){
        //post details segue
         
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        Post *post = self.arrayOfPosts[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.post = post;
        
    } else if ([[segue identifier] isEqualToString:@"commentsSegue"]){
        //comemnts details segue
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        
        Post *post = self.arrayOfPosts[indexPath.row];
        
        CommentViewController *commentsViewController = [segue destinationViewController];
        
        commentsViewController.post = post;
    
        
    }
}


@end
