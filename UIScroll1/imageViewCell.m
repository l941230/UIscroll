//
//  imageViewCell.m
//  UIScroll1
//
//  Created by eddie on 15-3-29.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "imageViewCell.h"

@implementation imageViewCell
float DEVICE_WIDTH,DEVICE_HEIGHT;
- (void)awakeFromNib {
    // Initialization code
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [super frame].size.width, 200)];
        [imageView setImage:[UIImage imageNamed:@"1.png"]];
        [self addSubview:imageView];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
