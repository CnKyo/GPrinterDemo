//
//  ViewController.m
//  GSDKDemo
//
//  Created by kai.shang on 15/4/28.
//  Copyright (c) 2015年 kai.shang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "TscCommand.h"
#import "BLKWrite.h"
#import "EscCommand.h"

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic, weak) UITextField *mCurrentUITextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.mIP.placeholder=@"IP";
    self.mPort.placeholder=@"Port";
    self.mIP.text = @"192.168.123.100";
    self.mPort.text = @"9100";
    self.mPort.delegate=self;
    self.mIP.delegate=self;
    
    self.mPort.keyboardType = UIKeyboardTypeDecimalPad;
    self.mIP.keyboardType = UIKeyboardTypeDecimalPad;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        while (1) {
            
            sleep(5);
            
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if([[BLKWrite Instance] isConnecting]){
                    self.mConnLabel.text=@"Connected";
                }
                else{
                    self.mConnLabel.text=@"Disconnect";
                }
            });
        }
    });
}

-(IBAction) HideKeyboard:(id)sender{

    if (self.mCurrentUITextField) {
        [self.mCurrentUITextField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.mCurrentUITextField = textField;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) scan:(id)sender{

    [[BLKWrite Instance] setBWiFiMode:NO];
    AppDelegate *dele = [UIApplication sharedApplication].delegate;
    [self.navigationController pushViewController:dele.mConnBLE animated:YES];
}

-(IBAction) ValueChanged:(id)sender{

    self.flag = ((UISwitch *)sender).on;
}


-(IBAction) ConnectWiFi:(id)sender{
    
    NSLog(@"IP: %@; Port: %@", self.mIP.text, self.mPort.text);
    
    [[BLKWrite Instance] setBWiFiMode:YES];
    [[BLKWrite Instance] setServerIP:self.mIP.text];
    [[BLKWrite Instance] setPort:[self.mPort.text intValue]];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[BLKWrite Instance] initWiFiClient];
    });
}


-(IBAction) printText:(id)sender{

    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:self.flag];
    
    /*
     一定会发送的设置项
     */
    //Size

    [tscCmd addSize:50 :30];
    
    //GAP
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE
    [tscCmd addReference:24
                        :24];
    
    //SPEED
    [tscCmd addSpeed:4];
    
    //DENSITY

    [tscCmd addDensity:8];
    
    //DIRECTION
    [tscCmd addDirection:0];
    
    //fixed command
    [tscCmd addComonCommand];
    [tscCmd addCls];
    
    //unit
    /*
     打印多行标签文本
     */

    for (int i=0; i<2;i++) {
        
        [tscCmd addTextwithX:24
                       withY:(24+i*24)
                    withFont:@"TSS24.BF2"
                withRotation:0
                   withXscal:1
                   withYscal:1
                    withText:@"TSC Print  你好"];
    }
    
    //print
    [tscCmd addPrint:1 :1];
}

-(IBAction) printBarcode:(id)sender
{
    
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //Size
    
    [tscCmd addSize:50 :30];
    
    //GAP
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE
    [tscCmd addReference:24
                        :24];
    
    //SPEED
    [tscCmd addSpeed:4];
    
    //DENSITY
    
    [tscCmd addDensity:8];
    
    //DIRECTION
    [tscCmd addDirection:0];
    
    //fixed command
    [tscCmd addComonCommand];
    [tscCmd addCls];
    
    
   // 条形码
        [tscCmd add1DBarcode:24 :24 :@"EAN13" :40 :1 :0 :2 :4 :@"123123123123"];
 
    //print
    [tscCmd addPrint:1 :1];
    
}

-(IBAction) printQRCode:(id)sender{

    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //Size
    
    [tscCmd addSize:50 :30];
    
    //GAP
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE
    [tscCmd addReference:24
                        :24];
    
    //SPEED
    [tscCmd addSpeed:4];
    
    //DENSITY
    
    [tscCmd addDensity:8];
    
    //DIRECTION
    [tscCmd addDirection:0];
    
    //fixed command
    [tscCmd addComonCommand];
    [tscCmd addCls];
    
    [tscCmd addQRCode:20
                     :4
                     :@"L"
                     :4
                     :@"A"
                     :0
                     :@"佳博集团网站www.Gprinter.com.cn"];
    //print
    [tscCmd addPrint:1 :1];
}
-(IBAction) printPicture:(id)sender{
    
    TscCommand *tscCmd = [[TscCommand alloc] init];
    [tscCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //Size
    
    [tscCmd addSize:50 :30];
    
    //GAP
    [tscCmd addGapWithM:2   withN:0];
    
    //REFERENCE
    [tscCmd addReference:24
                        :24];
    
    //SPEED
    [tscCmd addSpeed:4];
    
    //DENSITY
    
    [tscCmd addDensity:8];
    
    //DIRECTION
    [tscCmd addDirection:0];
    
    //fixed command
    [tscCmd addComonCommand];
    [tscCmd addCls];

    UIImage *pic=[UIImage imageNamed:@"logo2.png"];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tscpic.rtf"];
    NSData *tmpData = [NSData dataWithContentsOfFile: path];
    
    [tscCmd addBitmapwithX:0 withY:20 withWidth:pic.size.width/8 withHeight:pic.size.height withMode:0 withData:tmpData];
    
    //print
    [tscCmd addPrint:1 :1];
}


-(IBAction) printTextESC:(id)sender{
   
    //获取打印机纸张宽度
    int width = [[BLKWrite Instance] PrintWidth];
    NSLog(@"PrintWidth:%d mm", width);
    
    EscCommand *escCmd = [[EscCommand alloc] init];
    [escCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //打印机初始化，清空缓存
    [escCmd addInitializePrinter];
    
    //文本
    [escCmd addText: @"ESC Print  你好"];
    
    [escCmd addPrintMode: 0x1B];
    [escCmd addPrintAndFeedLines:8];
    
    [[BLKWrite Instance] writeEscData:[escCmd getCommand] withResponse:escCmd.hasResponse];
}
-(IBAction) printBarcodeESC:(id)sender{
    EscCommand *escCmd = [[EscCommand alloc] init];
    [escCmd setHasResponse:self.flag];
   
    
    /*
     一定会发送的设置项
     */
    //打印机初始化，清空缓存
    [escCmd addInitializePrinter];
    [escCmd addSetBarcodeHRPosition:2];
    [escCmd addITF:@"1213"];
    [escCmd addPrintMode: 0x1B];
    [escCmd addPrintAndFeedLines:8];
    [[BLKWrite Instance] writeEscData:[escCmd getCommand] withResponse:escCmd.hasResponse];
}
-(IBAction) printQRCodeESC:(id)sender{
    EscCommand *escCmd = [[EscCommand alloc] init];
    [escCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //打印机初始化，清空缓存
    [escCmd addInitializePrinter];

    NSString *content = @"Gprinter";
    [escCmd addQRCodeSizewithpL:0 withpH:0 withcn:0 withyfn:0 withn:5];
    [escCmd addQRCodeSavewithpL:0x0b withpH:0 withcn:0x31 withyfn:0x50 withm:0x30 withData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [escCmd addQRCodePrintwithpL:0 withpH:0 withcn:0 withyfn:0 withm:0];

    [escCmd addPrintMode: 0x1B];
    [escCmd addPrintAndFeedLines:8];
    [[BLKWrite Instance] writeEscData:[escCmd getCommand] withResponse:escCmd.hasResponse];
}
-(IBAction) printPictureESC:(id)sender{
    EscCommand *escCmd = [[EscCommand alloc] init];
    [escCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //打印机初始化，清空缓存
    [escCmd addInitializePrinter];
    
    //图片
    UIImage *pic=[UIImage imageNamed:@"logo2.png"];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"escpic.rtf"];
    NSData *tmpData = [NSData dataWithContentsOfFile: path];

    int picwidth = pic.size.width;
    int picheight = pic.size.height;
    [escCmd addESCBitmapwithM:48 withxL:((picwidth/8)%256) withxH:((picwidth/8)/256) withyL:picheight%256 withyH:picheight/256 withData:tmpData];
    
    [escCmd addPrintMode: 0x1B];
    [escCmd addPrintAndFeedLines:8];
    [[BLKWrite Instance] writeEscData:[escCmd getCommand] withResponse:escCmd.hasResponse];
}

-(IBAction) printESCCode128ABC:(id)sender{
    EscCommand *escCmd = [[EscCommand alloc] init];
    [escCmd setHasResponse:self.flag];
    /*
     一定会发送的设置项
     */
    //打印机初始化，清空缓存
     unsigned char prefix[] = {0x7B, 0x42, 0x31, 0x7B, 0x43, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38};
     NSData *tmp =  [NSData dataWithBytes:prefix length:sizeof(prefix)];
    [escCmd addInitializePrinter];
    [escCmd addSetBarcodeHRPosition:2];
    [escCmd addCODE128ABC:0x68 :0x02 :tmp];
    [escCmd addPrintMode: 0x1B];
    [escCmd addPrintAndFeedLines:8];
    [[BLKWrite Instance] writeEscData:[escCmd getCommand] withResponse:escCmd.hasResponse];
}


@end
