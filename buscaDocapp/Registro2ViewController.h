//
//  Registro2ViewController.h
//  buscaDocapp
//
//  Created by inf227al on 24-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Registro2ViewController : UIViewController

@property NSString *nombre;
@property NSString *apellidop;
@property NSString *apellidom;
@property NSString *direccion;

@property (weak, nonatomic) IBOutlet UITextField *txtTelefono;
@property (weak, nonatomic) IBOutlet UITextField *txtFechaNac;
@property (weak, nonatomic) IBOutlet UITextField *txtDni;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtSeguro;


@end
