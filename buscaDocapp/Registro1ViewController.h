//
//  Registro1ViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 8/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Registro3ViewController.h"
@interface Registro1ViewController : UIViewController<LoginDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtNombre;
@property (weak, nonatomic) IBOutlet UITextField *txtApellidoP;
@property (weak, nonatomic) IBOutlet UITextField *txtApellidoM;
@property (weak, nonatomic) IBOutlet UITextField *txtDireccion;


@end
