//
//  Registro3ViewController.m
//  buscaDocapp
//
//  Created by inf227al on 24-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Registro3ViewController.h"
#import "URLS json.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface Registro3ViewController ()

@end

@implementation Registro3ViewController

NSMutableArray *respuesta1;
NSDictionary *respuesta2;
NSDictionary *consulta;
NSString * paciente;
NSNumber * idultimopaciente;
NSString * resultado;
NSString * emailpaciente;

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
}

-(void)dismissKeyboard {
    [self.lblUsuario resignFirstResponder];
    [self.lblPassword resignFirstResponder];
    [self.lblPalabraSecreta resignFirstResponder];

    
}

- (IBAction)btnCreatuCuenta:(id)sender {
    
    [self SacaUltimoPaciente];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) SacaUltimoPaciente{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:sacaUltimoPaciente parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta1 = responseObject;
        NSLog(@"JSON: %@", respuesta1);
        
        
        for(int i=0;i<respuesta1.count;i++){
            NSDictionary * diccionario = respuesta1[i];
            NSDictionary * diccionario2=  diccionario[@"patient"];
            NSNumber * idpaciente= diccionario2[@"idpatient"];
            NSString * nombre= diccionario2[@"name"];
            NSString * correo= diccionario2[@"email"];
            
            idultimopaciente=idpaciente;
            paciente=[NSString stringWithString:nombre];
            emailpaciente = [NSString stringWithString:correo];


        }
        
        [self RegistroPaciente];

    }

    failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];


}


-(void) RegistroPaciente{
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:idultimopaciente,@"idpaciente",self.lblUsuario.text,@"user",self.lblPassword.text,@"password",self.lblPalabraSecreta.text,@"palabra",emailpaciente,@"email",nil];
    
    //NSDictionary *consulta = @{@"name": self.nombre};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:guardaUser parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        resultado=  respuesta2[@"status"];
        
        
        if ([resultado isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"El usuario se registró correctamente"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }

        
    }
          failure:^(AFHTTPRequestOperation *task, NSError *error) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                                  message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              [alertView show];
          }];
    
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [alertView cancelButtonIndex]){
         [self performSegueWithIdentifier:@"regresaLogin" sender:self];
    }
   
}

@end
