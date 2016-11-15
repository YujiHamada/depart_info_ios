//
//  FirstViewController.m
//  Depart-info
//
//  Created by 濱田裕史 on 2016/09/30.
//  Copyright © 2016年 濱田裕史. All rights reserved.
//

#import "FirstViewController.h"
#import "EventCell.h"
#import "GTMDefines.h"
#import "GTMNSString+HTML.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *eventTable;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _eventTable.delegate = self;
    _eventTable.dataSource = self;
    NSString *urlString = @"http://yuji.local/IOSController";
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSError *error = nil;
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    todaysEvents = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    _eventTable.contentInset = UIEdgeInsetsMake(0, -15, 0, 0);
    
    [_eventTable registerNib:[UINib nibWithNibName:@"EventCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [todaysEvents count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * CellIdentifier;
    if(indexPath.row == 0){
        CellIdentifier = @"image";
    }else{
        CellIdentifier = @"Cell";
    }
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"isetan_shinjuku.jpg"];
        //cell.separatorInset = UIEdgeInsetsZero;
        //cell.layoutMargins = UIEdgeInsetsZero;
        //_eventTable.layoutMargins = UIEdgeInsetsZero;
        return cell;
    }
    
    NSString *originalEventName = [todaysEvents[indexPath.row][@"name"] gtm_stringByUnescapingFromHTML];
    NSString *trimedEventName = [originalEventName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    cell.eventName.text = trimedEventName;
    cell.eventName.numberOfLines = 0;
    
    cell.period.text = [NSString stringWithFormat:@"%@月%@日〜%@月%@日",
                        todaysEvents[indexPath.row][@"start_month"],
                        todaysEvents[indexPath.row][@"start_day"],
                        todaysEvents[indexPath.row][@"end_month"],
                        todaysEvents[indexPath.row][@"end_day"]];
    [cell.period sizeToFit];

    //cell.eventName.numberOfLines = 2;
    //[cell.eventName setLineBreakMode:NSLineBreakByCharWrapping];
    //[cell.eventName sizeToFit];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 300;
    }
    return 125;
}

@end
