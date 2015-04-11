//
//  usualViewCell.m
//  UIScroll1
//
//  Created by eddie on 15-3-29.
//  Copyright (c) 2015年 Test. All rights reserved.
//

#import "usualViewCell.h"
#import "LikeButton.h"
@implementation usualViewCell

- (void)awakeFromNib {
    // Initialization code
  
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.imageView setImage:[UIImage imageNamed:@"2.png"]];
        LikeButton *btn=[[LikeButton alloc]init];
        //  [btn setTitle:@"喜欢" forState:UIControlStateNormal];
        [self addSubview:btn];
      //  [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
