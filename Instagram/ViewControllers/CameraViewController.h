//
//  CameraViewController.h
//  Instagram
//
//  Created by Anna Thomas on 7/12/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCapturePhotoOutput.h>
#import <AVFoundation/AVCaptureOutput.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraViewController : UIViewController <AVCapturePhotoCaptureDelegate>

@end

NS_ASSUME_NONNULL_END
