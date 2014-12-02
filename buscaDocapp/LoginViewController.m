//
//  LoginViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 31/08/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "LoginViewController.h"
#import "BloqueEspTableViewCell.h"
#import "URLS json.h"
#import "Login.h"

typedef void (^myCompletion)(BOOL);

@interface LoginViewController ()

@end

@implementation LoginViewController

NSDictionary * respuesta;
Login *objetoLogin;

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
    
    [[self.btnIngresar layer] setCornerRadius:8.0f];
    
    objetoLogin = [Login sharedManager];
    objetoLogin.delegate = self;
    self.cargando.alpha = 0 ;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    [self.lblIUsuario resignFirstResponder];
    [self.lblPassword resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    NSString * NombreUsuario = [datosDeMemoria stringForKey:@"NombreUsuario"];
    
    NSString * ContraseñaUsuario = [datosDeMemoria stringForKey:@"ContraseñaUsuario"];
    
    
    if(![NombreUsuario  isEqual: @""] && ![ContraseñaUsuario  isEqual: @""] && NombreUsuario != nil && ContraseñaUsuario != nil) {
        self.cargando.alpha = 1 ;
        // Arreglo de los indices(indices son Strings)
        [Login jsonLoginConUsuarioPersistente:NombreUsuario yPassword:ContraseñaUsuario];
        
    }
    
    
}
- (IBAction)apretoIngresar:(id)sender {
    
    self.cargando.alpha = 1 ;
    // Arreglo de los indices(indices son Strings)
    [Login jsonLoginConUsuario:self.lblIUsuario.text yPassword:self.lblPassword.text];
}

-(void) myMethod:(myCompletion) compblock {
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    NSString * NombreUsuario = [datosDeMemoria stringForKey:@"NombreUsuario"];
    compblock (YES);
    
}

-(void)loginExito{
    [self myMethod:^(BOOL finished) {
        if(finished){
            
            [self performSegueWithIdentifier:@"exito_login" sender:self];
        }
    }];
    
}

-(void)loginFallo:(NSString *)mensaje{
    UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [miAlert show];
    
    self.cargando.alpha = 0 ;
}

-(void)falloServidor{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fallo en el servicio" message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    self.cargando.alpha = 0 ;
}




@end
