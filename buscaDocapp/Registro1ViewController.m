//
//  Registro1ViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 8/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Registro1ViewController.h"
#import "Registro2ViewController.h"

@interface Registro1ViewController ()

@end

@implementation Registro1ViewController

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
    [self.txtNombre resignFirstResponder];
    [self.txtApellidoP resignFirstResponder];
    [self.txtApellidoM resignFirstResponder];
    [self.txtDireccion resignFirstResponder];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    Registro2ViewController *escenadestino = segue.destinationViewController;
    escenadestino.nombre=self.txtNombre.text;
    escenadestino.apellidop=self.txtApellidoP.text;
    escenadestino.apellidom=self.txtApellidoM.text;
    escenadestino.direccion=self.txtDireccion.text;

}

- (IBAction)btnCancelar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)regresarLogin{
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:vc animated:YES completion:nil];
}

@end
