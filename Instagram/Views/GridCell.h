//
//  GridCell.h
//  Instagram
//
//  Created by Anna Thomas on 7/8/21.
//

#import <UIKit/UIKit.h> 
#import "Post.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridCell : UICollectionViewCell

@property (nonatomic, strong) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;

@end

NS_ASSUME_NONNULL_END
