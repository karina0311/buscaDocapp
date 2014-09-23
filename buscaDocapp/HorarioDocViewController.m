//
//  HorarioDocViewController.m
//  buscaDocapp
//
//  Created by inf227al on 23/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "HorarioDocViewController.h"
#import "DIDatepicker.h"

@interface HorarioDocViewController ()




@end

@implementation HorarioDocViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    [self.datepicker fillDatesFromCurrentDate:14];
    [self.datepicker selectDateAtIndex:0];
    //[self.datepicker fillCurrentWeek];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//ESTE METODO SIRVE CUANDO SE SELECCIONA UNA FECHA
- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEEddMMMM" options:0 locale:nil];
    
    //self.selectedDateLabel.text = [formatter stringFromDate:self.datepicker.selectedDate];
}

//METODOS PARA EL TABLE VIEW CONTROLLER

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];

    return cell;
}

@end
