//
//  EventCell.h
//  DepartInfo
//
//  Created by 濱田裕史 on 2016/09/24.
//  Copyright © 2016年 濱田裕史. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *eventCell;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *period;
@property (weak, nonatomic) IBOutlet UILabel *departName;

@end
