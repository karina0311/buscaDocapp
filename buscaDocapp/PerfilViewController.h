//
//  PerfilViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 26/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfilViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *namePatient;

@property (weak, nonatomic) IBOutlet UILabel *correo;
@property (weak, nonatomic) IBOutlet UILabel *user;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *cellphone;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;

@end
