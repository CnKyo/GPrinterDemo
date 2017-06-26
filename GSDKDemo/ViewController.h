//
//  ViewController.h
//  GSDKDemo
//
//  Created by kai.shang on 15/4/28.
//  Copyright (c) 2015年 kai.shang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, assign) BOOL flag;

@property(nonatomic, strong) IBOutlet UILabel *mConnLabel;

@property(nonatomic, strong) IBOutlet UITextField *mIP;
@property(nonatomic, strong) IBOutlet UITextField *mPort;


-(IBAction) ConnectWiFi:(id)sender;
-(IBAction) ValueChanged:(id)sender;

-(IBAction) scan:(id)sender;

-(IBAction) printText:(id)sender;
-(IBAction) printBarcode:(id)sender;
-(IBAction) printQRCode:(id)sender;
-(IBAction) printPicture:(id)sender;

-(IBAction) printTextESC:(id)sender;
-(IBAction) printBarcodeESC:(id)sender;
-(IBAction) printQRCodeESC:(id)sender;
-(IBAction) printPictureESC:(id)sender;

-(IBAction) printESCCode128ABC:(id)sender;

-(IBAction) HideKeyboard:(id)sender;

@end

