//
//  PostCell.h
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "Post.h" 

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *smallUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) Post *post;  //stores the reference to the current post

@end

NS_ASSUME_NONNULL_END
