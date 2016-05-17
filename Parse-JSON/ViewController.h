//
//  ViewController.h
//  Parse-JSON
//
//  Created by MacBook P on 13/04/13.
//  Copyright (c) 2013 MobileStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *arregloContinentes;
@property (nonatomic, retain) IBOutlet UITableView *mainTable;

@end
