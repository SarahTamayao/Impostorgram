//
//  PostCell.m
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import "PostCell.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>
  

@implementation PostCell








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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setPost:(Post *)post {
    _post = post;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
} 
 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
