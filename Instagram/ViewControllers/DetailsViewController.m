//
//  DetailsViewController.m
//  Instagram
//
//  Created by Anna Thomas on 7/7/21.
//

#import "DetailsViewController.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>
#import "NSDate+DateTools.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *profileImage;

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
 
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heartImage;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Post *post = self.post;
    
    self.heartImage.alpha =0;
    self.heartImage.hidden = NO;
    
    
    //set custom details display
    self.profileImage.layer.cornerRadius = 20;
    self.profileImage.clipsToBounds = YES;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"image"]) {
        PFFileObject *picFile =user[@"image"];
        [picFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if(error==nil) {
                self.profileImage.image = [UIImage imageWithData:data];
            }
        }];

    }
     
    self.usernameLabel.text = post.author.username;
    
    self.smallUsernameLabel.text =post.author.username;
    
    self.captionLabel.text = post.caption;
    
    self.postImageView.file = post.image;
    
    self.dateLabel.text = post.createdAt.timeAgoSinceNow;
    
    //double tap action 
    self.postImageView.userInteractionEnabled = YES;
 
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];

    tapGesture1.numberOfTapsRequired = 2;

    tapGesture1.delegate = self;

    [self.postImageView addGestureRecognizer:tapGesture1];
        
}

- (void) tapGesture: (id)sender
{
    [UIView animateWithDuration:3.00
      delay: 1.0
      options: 0
      animations:^{
       self.heartImage.alpha = 1.0;
      }
      completion: nil
    ];
    [UIView animateWithDuration:1.0
      delay: 0.0
      options: 0
      animations:^{
       self.heartImage.alpha = 0;
      }
      completion: nil
    ];
    [self refreshDataFavorite];
 }
 
- (IBAction)didTapFavorite:(id)sender {
      
    //favorite
    if(self.favoriteButton.selected ==NO) {
        NSNumber *likes = self.post.likeCount;
        likes = [NSNumber numberWithInt:likes.intValue + 1];
        self.post.likeCount = likes;

        [self refreshDataFavorite];

 
    //unfavorite
    } else if (self.favoriteButton.selected ==YES) {
        NSNumber *likes = self.post.likeCount;
        likes = [NSNumber numberWithInt:likes.intValue - 1];
        self.post.likeCount = likes;

        [self refreshDataFavoriteUnfavorite];

    }
}



//reloads cell view
-(void) refreshDataFavorite {
   
//    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.favoriteButton.selected = YES;
     
}

//reloads cell view
-(void) refreshDataFavoriteUnfavorite {
   
    //self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.favoriteButton.selected = NO;
     
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
