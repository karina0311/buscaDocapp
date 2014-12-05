//
//  BusquedaDoctorViewController.m
//  buscaDocapp
//
//  Created by inf227al on 10/11/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "BusquedaDoctorViewController.h"
#import "BusquedaDoctorTableViewController.h"

@interface BusquedaDoctorViewController ()

@end

@implementation BusquedaDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.autocapitalizationType=UITextAutocapitalizationTypeSentences;
    self.lastnameField.autocapitalizationType=UITextAutocapitalizationTypeSentences;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    BusquedaDoctorTableViewController *escenadestino = segue.destinationViewController;
    
    escenadestino.nombre = self.nameField.text;
    escenadestino.apellido = self.lastnameField.text;
    
    if ((self.nameField.text!=nil) && (self.lastnameField.text==nil || (self.lastnameField.text.length==0))) {
        escenadestino.opcion=0;
    } else if (((self.nameField.text==nil) || (self.nameField.text.length==0)) && (self.lastnameField.text!=nil)){
        escenadestino.opcion=1;
    } else if ((self.nameField.text!=nil) && (self.lastnameField.text!=nil)){
        escenadestino.opcion=2;
    }
}

- (IBAction)cerrarSesion:(id)sender {
    
    
    UIAlertView* alertView;
    alertView = [[UIAlertView alloc] initWithTitle:@"Cerrar Sesión"
                                           message:@"Está seguro que desea cerrar sesión?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Si",nil];
    [alertView show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1){
        
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"NombreUsuario"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ContraseñaUsuario"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}


@end
