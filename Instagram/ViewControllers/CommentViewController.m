//
//  CommentViewController.m
//  Instagram
//
//  Created by Anna Thomas on 7/9/21.
//

#import "CommentViewController.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>
#import "ProfileViewController.h"
#import "CommentCell.h"

@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate> 
@property (weak, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *comments;

 
@end

@implementation CommentViewController


//when user taps on post to psot a comment
- (IBAction)didTapPost:(id)sender {
    
    //send comment to parse backend
    Post *current = self.post;
    
    if(current[@"comments"] == nil) {
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:self.commentTextField.text, nil];
        current[@"comments"] = arr;
    } else {
        NSMutableArray *commentArray = current[@"comments"];
        [commentArray insertObject:self.commentTextField.text atIndex:0];
    }
    
    [current saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error!= nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    self.commentTextField.text = @""; 
    [self.tableView reloadData];
}
    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //makes the keyboard disappear
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc]
                initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    //table view delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    self.profileImage.layer.cornerRadius = 30;
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

      
    [self getData];
    
    
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
    
    
//gets the comment array 
- (void)getData {
     
    if(self.post[@"comments"]) {
        self.comments = self.post[@"comments"];
        [self.tableView reloadData];
    }
}

//set how many rows in display
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

//enables custom cell displays
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
      
    NSString *comment = self.comments[indexPath.row];
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    cell.commentLabel.text = comment;
    
    cell.profileImage.layer.cornerRadius = 20;
    cell.profileImage.clipsToBounds = YES;
    
    PFUser *user = [PFUser currentUser];
    if(user[@"image"]) {
        PFFileObject *picFile =user[@"image"];
        [picFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
            if(error==nil) {
                cell.profileImage.image = [UIImage imageWithData:data];
            }
        }];
    
    }
      
    return cell;
}

/*
#pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little prep
 @end
 aration before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
