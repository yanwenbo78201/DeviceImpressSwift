//
//  ObjcViewController.m
//  DeviceImpressSwift_Example
//
//  Created by Computer  on 07/05/26.
//  Copyright © 2026 CocoaPods. All rights reserved.
//

#import "ObjcViewController.h"
#import <DeviceImpressSwift-Swift.h>

@interface ObjcViewController ()

@end

@implementation ObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",[SystemService getDeviceInfoWithUuid:@""]);
    [ImpressService compressForUpload200to600AsyncWithImage:[UIImage imageNamed:@"big.JPEG"] completion:^(ImpressOutput * _Nullable outPut, NSError * _Nullable error) {
        if (error != nil) {
            
        }else{
            NSLog(@"%@",outPut.base64);
        }
    }];
    
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
