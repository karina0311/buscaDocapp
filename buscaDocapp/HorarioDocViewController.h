//
//  HorarioDocViewController.h
//  buscaDocapp
//
//  Created by inf227al on 23/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DIDatepicker.h"

@interface HorarioDocViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet DIDatepicker *datepicker;



@end
