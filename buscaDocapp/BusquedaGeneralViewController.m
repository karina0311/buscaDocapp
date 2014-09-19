//
//  BusquedaGeneralViewController.m
//  buscaDocapp
//
//  Created by inf227al on 10/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "BusquedaGeneralViewController.h"

@interface BusquedaGeneralViewController ()



@end

@implementation BusquedaGeneralViewController
@synthesize lblEspecialidad;

NSMutableArray * respuesta;

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
    especialidad = [[NSMutableArray alloc] init];
    [self sacoEspecialidades];
    
    lblEspecialidad.delegate = self;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}



-(void) textFieldDidBeginEditing:(UITextField *)textField{

    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    pickerespecialidad = [[UIPickerView alloc]initWithFrame:pickerFrame];

    lblEspecialidad.text= [especialidad objectAtIndex:0];
    lblEspecialidad.inputView = pickerespecialidad;
    
    pickerespecialidad.delegate=self;

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [lblEspecialidad resignFirstResponder];

}





//metodos del picker view

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;

}

-(NSInteger) pickerView: (UIPickerView*) picker numberOfRowsInComponent:(NSInteger)component{
    return (especialidad.count);

}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [especialidad objectAtIndex:row];

}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    lblEspecialidad.text= [especialidad objectAtIndex:row];
}


-(void) sacoEspecialidades{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaespecialidades parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = [respuesta objectAtIndex:i];
            NSDictionary * diccionario2=  [diccionario objectForKey:@"specialty"];
            NSString * NombresEspecialidades= [diccionario2 objectForKey:@"name"];
            
            
            [especialidad addObject:NombresEspecialidades];
            
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

@end
