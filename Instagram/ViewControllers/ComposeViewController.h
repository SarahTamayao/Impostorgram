//
//  ComposeViewController.h
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate
- (void)didPost;
@end

@interface ComposeViewController : UIViewController

//delegate for didpost method in homeviewcontroller
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
