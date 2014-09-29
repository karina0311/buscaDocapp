//
//  LoginViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 31/08/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"

@interface LoginViewController : UIViewController <loginDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lblIUsuario;
@property (weak, nonatomic) IBOutlet UITextField *lblPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;


@end
