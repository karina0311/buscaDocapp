//
//  LoginTableViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 7/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *login;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;
@property (weak, nonatomic) IBOutlet UITextField *lblUser;
@property (weak, nonatomic) IBOutlet UITextField *lblPassword;

@end
