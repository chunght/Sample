//
//  DynamicButtonsVC.m
//  Day06
//
//  Created by techmaster on 6/27/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "DynamicButtonsVC.h"
#define START_TAG 100
@interface DynamicButtonsVC ()
{
    int row, col;
    float bwidth, bheight;
    NSTimer *timer;
    UIButton* _button1, *_button2; //Hai nút đang đỏ
}
@end

@implementation DynamicButtonsVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    _button1 = nil; _button2 = nil;
    
    [self createArrayButtons];
    
    //Tạo timer để lặp
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5  //0.5 giây lặp một lần
                                             target:self
                                           selector:@selector(flashButton) //flasButton là hàm được gọi trong timer
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];  //kịch hoạt timer
}
- (void) flashButton
{
    //Xoá 2 nút đỏ ở lần trước
    if (_button1) {
        [_button1 setBackgroundColor:[UIColor grayColor]];
    }
    
    if (_button2) {
        [_button2 setBackgroundColor:[UIColor grayColor]];
    }
    
    //Lấy ra 2 vị trí mới để hiện nút đỏ mới
    int ranRow1 = arc4random() % row;
    int ranCol1 = arc4random() % col;
    int ranRow2, ranCol2;
    
    //Lặp cho đến khi vị trí nút số 2 khác số 1
    do {
        ranRow2 = arc4random() % row;
        ranCol2 = arc4random() % col;
    } while (ranRow1 == ranRow2 &&  ranCol1 == ranCol2);
    
    //Tính toán tag của từng nút
    int id1 = START_TAG + ranRow1 * col + ranCol1;
    int id2 = START_TAG + ranRow2 * col + ranCol2;
    
    //Lấy nút ra nhờ vào số tag
    UIButton *button1 = (UIButton *)[self.view viewWithTag:id1];
    [button1 setBackgroundColor:[UIColor redColor]];
    
    UIButton *button2 = (UIButton *)[self.view viewWithTag:id2];
    [button2 setBackgroundColor:[UIColor redColor]];
    
    //Lưu lại 2 nút đỏ hiện thời
    _button1 = button1;
    _button2 = button2;
    
    //self.title = [NSString stringWithFormat:@"Score: %d", ranRow1+ ranCol1];
}
- (void) createArrayButtons
{
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.2f - height = %3.2f", size.width, size.height);
    row = (size.height > 480) ? 9 : 8;
    col = 6;
    float d = 11.0;
    float x = d;
    float y = 60.0 + d;
    bwidth = 40.0;
    bheight = 40.0;
    int buttonCount = 0;
    for (int rowIndex = 0; rowIndex < row; rowIndex ++) {
        for (int colIndex = 0; colIndex < col; colIndex ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.backgroundColor = [UIColor grayColor];
            button.frame = CGRectMake(x, y, bwidth, bheight);
            button.tag = START_TAG + buttonCount;
            buttonCount++;
            [self.view addSubview:button]; //Thêm nút vào giao diện. self.view là UIView chính của ViewController hiện tại
            x += bwidth + d;
            
        }
        x = d;
        y += bheight + d;
    }

}


@end
