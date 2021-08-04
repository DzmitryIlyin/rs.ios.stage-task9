//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 7/28/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsMainViewController.h"
#import "StrokeTableViewCell.h"
#import "DrawTableViewCell.h"
#import "StrokeColorSelection.h"

@interface SettingsMainViewController ()
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation SettingsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:StrokeTableViewCell.class forCellReuseIdentifier:@"CellId"];
    [self.tableView registerClass:DrawTableViewCell.class forCellReuseIdentifier:@"drawTableCell"];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(void)switchDidChange:(UISwitch*)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"drawTableCell" forIndexPath:indexPath];
        cell.textLabel.text = @"Draw stories";
        
        UISwitch *switchView = [[UISwitch alloc] init];
        [switchView setOn:NO];
        [switchView addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
        
        cell.accessoryView = switchView;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
        cell.textLabel.text = @"Stroke color";
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        StrokeColorSelection *viewController = [StrokeColorSelection new];
        [self.navigationController pushViewController:viewController animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

@end
