//
//  HomeViewController.h
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h" 

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
 
@end

NS_ASSUME_NONNULL_END
