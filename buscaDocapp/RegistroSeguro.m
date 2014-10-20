//
//  RegistroSeguro.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 19/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "RegistroSeguro.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface RegistroSeguro ()

@end

@implementation RegistroSeguro

NSMutableArray * respuestaseg;
NSMutableArray * respuesta1;
NSMutableArray * respuesta;
NSMutableArray * idsseguros;
NSNumber*  idseguro1;
NSNumber*  idseguro2;
NSNumber*  idseguro3;
NSNumber*  idseguro4;
NSNumber* idultimopaciente;

int variable;

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
    seguros = [[NSMutableArray alloc] init];
    idsseguros = [[NSMutableArray alloc] init];
    [self sacoSeguros];
    
    self.seguro1.delegate=self;
    self.seguro2.delegate=self;
    self.seguro3.delegate=self;
    self.seguro4.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)seApretoSiguiente:(id)sender {
    
    [self SacaUltimoPaciente];
    
    [self performSegueWithIdentifier:@"idsegue" sender:self];
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    
    picker = [[UIPickerView alloc]initWithFrame:pickerFrame];
    
    picker.delegate=self;
    
    if (self.seguro1.isEditing) {
        
        self.seguro1.text= [seguros objectAtIndex:0];
        self.seguro1.inputView = picker;
        variable=1;
        
    }else if (self.seguro2.isEditing){
        
        self.seguro2.text= [seguros objectAtIndex:0];
        self.seguro2.inputView=picker;
        variable=2;
        
    } else if (self.seguro3.isEditing){
        self.seguro3.text= [seguros objectAtIndex:0];
        self.seguro3.inputView=picker;
        variable=3;
        
    } else if (self.seguro4.isEditing){
        self.seguro4.text = [seguros objectAtIndex:0];
        self.seguro4.inputView=picker;
        variable=4;
        
    }
    
    
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.seguro1 resignFirstResponder];
    [self.seguro2 resignFirstResponder];
    [self.seguro3 resignFirstResponder];
    [self.seguro4 resignFirstResponder];
}

//metodos del picker view

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;
    
}

-(NSInteger) pickerView: (UIPickerView*) picker numberOfRowsInComponent:(NSInteger)component{
    
    if (variable==1) {
        return (seguros.count);
    } else if (variable==2){
        return (seguros.count);
    }else if (variable==3){
        return (seguros.count);
    }else if (variable==4) {
        return (seguros.count);
    }else return 0;
    
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (variable==1) {
        return [seguros objectAtIndex:row];
    } else if (variable==2){
        return [seguros objectAtIndex:row];
    } else if(variable==3){
        return [seguros objectAtIndex:row];
    }else if(variable==4){
        return [seguros objectAtIndex:row];
    }
    else return 0;
    
    
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (variable==1) {
        self.seguro1.text= seguros[row];
        idseguro1= idsseguros[row];
    } else if (variable==2){
        self.seguro2.text= seguros[row];
        idseguro2 = idsseguros[row];
    } else if(variable==3){
        self.seguro3.text=seguros[row];
        idseguro3=idsseguros[row];
    } else if (variable==4){
        self.seguro4.text=seguros[row];
        idseguro4 = idsseguros[row];
    }
    
    
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
    if (variable==1) {
        tView.text= seguros[row];
        idseguro1= idsseguros[row];
    } else if (variable==2){
        tView.text= seguros[row];
        idseguro2 = idsseguros[row];
    } else if(variable==3){
        tView.text=seguros[row];
        idseguro3=idsseguros[row];
    } else if (variable==4){
        tView.text=seguros[row];
        idseguro4 = idsseguros[row];
    }
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
            
            idultimopaciente=idpaciente;
            
            
        }
        
        [self RegistroSeguros];
        
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

//Para registrar seguros

-(void) RegistroSeguros{
    
    if (idseguro1==nil) {
        idseguro1=0;
    }
    if (idseguro2==nil) {
        idseguro2=0;
    }
    if (idseguro3==nil) {
        idseguro3=0;
    }
    if (idseguro4==nil) {
        idseguro4=0;
    }
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:idultimopaciente,@"idpaciente",idseguro1,@"idseguro1",idseguro2,@"idseguro2",idseguro3,@"idseguro3",idseguro4,@"idseguro4",nil];
    
    //NSDictionary *consulta = @{@"name": self.nombre};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:guardaSegurosxPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
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
