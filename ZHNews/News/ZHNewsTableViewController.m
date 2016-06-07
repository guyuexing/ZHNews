//
//  ZHNewsTableViewController.m
//  ZHNews
//
//  Created by guyuexing on 16/6/7.
//  Copyright © 2016年 neu. All rights reserved.
//

#import "ZHNewsTableViewController.h"
#import "ZHNewsModel.h"
#import "ZHNewsTableViewCell.h"

@interface ZHNewsTableViewController ()

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,copy) NSString *cellID;


@end

@implementation ZHNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



-(void)setURLString:(NSString *)URLString{
    _URLString = URLString;
    __weak typeof (self) weakSelf = self;
    [ZHNewsModel newsModelWithPath:URLString andFinish:^(NSArray *dataArr) {
        weakSelf.dataArray = dataArr;
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZHNewsModel *model = self.dataArray[indexPath.row];
    self.cellID = @"baseCell";
    if (model.imgType == 1) {
        self.cellID = @"bigCell";
    }
    
    ZHNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZHNewsModel *model = self.dataArray[indexPath.row];
    if (model.imgType == YES) {
        return 140;
    }
    return 80;

}

@end
