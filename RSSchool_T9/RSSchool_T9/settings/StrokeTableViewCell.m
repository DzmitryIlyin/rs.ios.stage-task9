//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/4/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "StrokeTableViewCell.h"


@interface StrokeTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *completedIndicatorView;

@end

@implementation StrokeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        if (self) {
            [self setupViews];
        }
        return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
