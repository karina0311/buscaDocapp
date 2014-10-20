//
//  Registro2ViewController.m
//  buscaDocapp
//
//  Created by inf227al on 24-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Registro2ViewController.h"
#import "URLS json.h"
#import "UIImageView+AFNetworking.h"
#import "Registro3ViewController.h"



@interface Registro2ViewController ()

@end

@implementation Registro2ViewController

NSDictionary *consulta;
NSString *respuesta;
NSMutableArray * respuestaseg;
NSMutableArray * idsseguros;
NSNumber*  idseguro1;

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
    seguros = [[NSMutableArray alloc] init];
    idsseguros = [[NSMutableArray alloc] init];
    [self sacoSeguros];
    
    self.txtSeguro.delegate=self;
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

    [self performSegueWithIdentifier:@"idsegue" sender:self];
}


- (IBAction)seApretoBotonSeguros:(id)sender {
    
    [self RegistroPaciente];
    
    [self performSegueWithIdentifier:@"idsegue2" sender:self];
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
- (IBAction)btnCancelar:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//PARA EL PICKER DE SEGUROS


-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    
    picker = [[UIPickerView alloc]initWithFrame:pickerFrame];
    
    picker.delegate=self;
    
    if (self.txtSeguro.isEditing) {
        
        self.txtSeguro.text= [seguros objectAtIndex:0];
        self.txtSeguro.inputView = picker;
        
    }

}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.txtSeguro resignFirstResponder];

}

//metodos del picker view

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
    
}

-(NSInteger) pickerView: (UIPickerView*) picker numberOfRowsInComponent:(NSInteger)component{
    
    return seguros.count;
    
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
   return [seguros objectAtIndex:row];

    
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
        self.txtSeguro.text= seguros[row];
        idseguro1= idsseguros[row];

    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Avenir" size:14]];
        [tView setTextAlignment:UITextAlignmentCenter];
        tView.numberOfLines=3;
    }
    // Fill the label text here
    tView.text=[seguros objectAtIndex:row];
    return tView;
}



-(void) sacoSeguros{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaseguros parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestaseg = responseObject;
        NSLog(@"JSON: %@", respuestaseg);
        
        for(int i=0;i<respuestaseg.count;i++){
            NSDictionary * diccionario = respuestaseg[i];
            NSDictionary * diccionario2=  diccionario[@"insurance"];
            NSString * Seguro= diccionario2[@"name"];
            NSNumber *IDSeguro = diccionario2[@"idinsurance"];
            
            
            [seguros addObject:Seguro];
            [idsseguros addObject:IDSeguro];
            
        }
        
        NSLog(@"JSON: %@", seguros);
        
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
