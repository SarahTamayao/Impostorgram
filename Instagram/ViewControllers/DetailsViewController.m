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


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Post *post = self.post;
    
    //set custom details display
    self.profileImage.layer.cornerRadius = 20;
    self.profileImage.clipsToBounds = YES;
    
    self.profileImage.layer.cornerRadius = 20;
    self.profileImage.clipsToBounds = YES;
     
    self.usernameLabel.text = post.author.username;
    
    self.smallUsernameLabel.text =post.author.username;
    
    self.captionLabel.text = post.caption;
    
    self.postImageView.file = post.image;
    
    self.dateLabel.text = post.createdAt.timeAgoSinceNow; 
       
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
