//
//  GridCell.m
//  Instagram
//
//  Created by Anna Thomas on 7/8/21.
//

#import "GridCell.h"
#import "Post.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>

@implementation GridCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
} 


- (void)setPost:(Post *)post {
    _post = post;
    self.imageView.file = self.post.image;
    [self.imageView loadInBackground];
}
@end
