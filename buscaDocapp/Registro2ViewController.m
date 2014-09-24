//
//  Registro2ViewController.m
//  buscaDocapp
//
//  Created by inf227al on 24-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Registro2ViewController.h"
#import "URLS json.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface Registro2ViewController ()

@end

@implementation Registro2ViewController

NSDictionary *consulta;
NSString *respuesta;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)dismissKeyboard {
    [self.txtTelefono resignFirstResponder];
    [self.txtFechaNac resignFirstResponder];
    [self.txtDni resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtSeguro resignFirstResponder];
    
}


- (IBAction)seApretoBoton:(id)sender {
    
    [self RegistroPaciente];
    
}



-(void) RegistroPaciente{
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.txtTelefono.text,@"phone",self.txtDni.text,@"dni",self.txtFechaNac.text,@"fecha_nacimiento",self.txtEmail.text,@"correo",self.apellidom,@"apellidom",self.apellidop,@"apellidop", self.nombre,@"name",nil];
    
    //NSDictionary *consulta = @{@"name": self.nombre};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:guardaPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        

    
        
        
        
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

@end
