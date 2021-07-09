//
//  ProfileViewController.m
//  Instagram
//
//  Created by Anna Thomas on 7/8/21.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SceneDelegate.h"
#import "Post.h"
#import "GridCell.h"
#import "ComposeViewController.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/PFImageView.h>
#import "NSDate+DateTools.h"


@interface ProfileViewController ()  <UICollectionViewDataSource, UICollectionViewDelegate, UICollisionBehaviorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *bigUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallUsernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *posts;

@end

@implementation ProfileViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser *current = [PFUser currentUser];
    self.bigUsernameLabel.text = current.username;
    self.smallUsernameLabel.text = current.username;
    
//    if(current.image) {
//        self.profileImage.file = current.image;
//    }
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self getData:30];
    
     
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    
  //  CGFloat postersPerLine =3;
//    CGFloat itemWidth = (self.collectionView.frame.size.width- layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
//    CGFloat itemHeight = itemWidth * 1.5;
//    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
      
}

- (void)getData: (int) postLimit {
 
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery whereKey:@"author" equalTo: [PFUser currentUser]];
    postQuery.limit = postLimit;

    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSMutableArray* postsMutableArray = [posts mutableCopy];
            self.posts = postsMutableArray;
            [self.collectionView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
            NSLog(@"%@", @"CANNOT GET STUFF");
        }
    }];
}
 
- (IBAction)didTapLogOut:(id)sender {
   [self didLogOut];

}

//allows user to log out
-(void)didLogOut {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        if (error != nil) {
            NSLog(@"User log out failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged out successfully");
    
        }
    }];
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
    
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
    
    Post *post = self.posts[indexPath.row];
    cell.post = post;
   
    cell.imageView.file = post.image;
     
    return cell;
}

-(CGSize) collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake((CGRectGetWidth(collectionView.frame))/3.0,
                      (CGRectGetWidth(collectionView.frame))/3.0); 
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
