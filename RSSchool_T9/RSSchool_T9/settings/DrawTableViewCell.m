//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/4/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "DrawTableViewCell.h"

@implementation DrawTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            [self setupViews];
        }
        return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

@end
