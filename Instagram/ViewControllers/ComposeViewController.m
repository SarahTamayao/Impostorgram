//
//  ComposeViewController.m
//  Instagram
//
//  Created by Anna Thomas on 7/6/21.
//

#import "ComposeViewController.h"
#import <UIKit/UIKit.h>
#import "PostCell.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import <Parse/ParseUIConstants.h>
#import <Parse/PFInstallation.h>
#import <Parse/Parse.h>
#import <Parse/PFImageView.h>
#import "MBProgressHUD.h"
#import "CameraViewController.h"
#import "SceneDelegate.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (weak, nonatomic) IBOutlet PFImageView *imageView;


@end

@implementation ComposeViewController
- (IBAction)didTapCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil]; 
    
}


- (IBAction)didTapPost:(id)sender {
    // Display HUD right before the request is made
    [MBProgressHUD showHUDAddedTo:self.view animated:TRUE];
    
    [Post postUserImage:self.imageView.image withCaption: self.captionTextField.text withCompletion:nil];
    
    // Hide HUD once the network request comes back (must be done on main UI thread)
    
    [MBProgressHUD hideHUDForView:self.view animated:TRUE];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(dismissThisView)
                                   userInfo:nil
                                    repeats:NO];
              
    [self.delegate didPost];
}

-(void) dismissThisView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.userInteractionEnabled = YES;
 
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];

    tapGesture1.numberOfTapsRequired = 1; 

    tapGesture1.delegate = self;

    [self.imageView addGestureRecognizer:tapGesture1];

 
}

- (void) tapGesture: (id)sender
{
//    //instantiate an image picker
//    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
//    imagePickerVC.delegate = self;
//    imagePickerVC.allowsEditing = YES;
//
//    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//    else {
//        NSLog(@"Camera 🚫 available so we will use photo library instead");
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }
//
//    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
//    CameraViewController *customCameraView = [CameraViewController new];
//    [self presentViewController:customCameraView animated:YES completion:nil];
//
    
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController *cameraViewController = [storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    myDelegate.window.rootViewController = cameraViewController; 
 }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
   // UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
     
    UIImage *finalImage = [self resizeImage:editedImage withSize:CGSizeMake(300, 300)];

    // Do something with the images (based on your use case)
   // Post *newPost = [[Post alloc] init];

    
    self.imageView.image = finalImage;
    [self.imageView reloadInputViews];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
