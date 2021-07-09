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

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.profileImage.layer.cornerRadius = 50;
    
     
    [self getData:30];
     
     
    
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing =0;
    
    self.profileImage.image = [UIImage imageNamed:@"profile pic instagram"];
    self.profileImage.userInteractionEnabled = YES;
 
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];

    tapGesture1.numberOfTapsRequired = 1;

    tapGesture1.delegate = self;

    [self.profileImage addGestureRecognizer:tapGesture1];
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:refreshControl atIndex:0];
    [refreshControl setTintColor:[UIColor lightGrayColor]]; 
  
    
  //  CGFloat postersPerLine =3;
//    CGFloat itemWidth = (self.collectionView.frame.size.width- layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
//    CGFloat itemHeight = itemWidth * 1.5;
//    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
      
}

// Makes a network request to get updated data
 // Updates the tableView with the new data
 // Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // Parse query
    
    // Reload the tableView now that there is new data
    if(self.posts.count < 20) {
        [self getData: (int) 20];
    } else if(self.posts.count >= 20) {
        [self getData: (int) self.posts.count];
      
    }
   // [self.collectionView reloadData];
 
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing]; 

}
 

- (void) tapGesture: (id)sender
{
    //instantiate an image picker
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
      
 }


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
     
    UIImage *finalImage = [self resizeImage:editedImage withSize:CGSizeMake(300, 300)];

    // Do something with the images (based on your use case)
   // Post *newPost = [[Post alloc] init];

    
    self.profileImage.image = finalImage;
    [self.profileImage reloadInputViews];
        
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    PFUser *currentU = [PFUser currentUser];
    PFFileObject *file = [Post getPFFileFromImage:self.profileImage.image]; 
    currentU[@"image"] = file;
    [currentU saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error!= nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
    
  //  if(indexPath.item == 0) {
  //      return CGSizeMake((CGRectGetWidth(collectionView.frame)), 200);
   // }
    
    
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
