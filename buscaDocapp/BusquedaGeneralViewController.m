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
#import "DocsBusquedaTableViewController.h"

@interface BusquedaGeneralViewController ()



@end

@implementation BusquedaGeneralViewController
@synthesize lblEspecialidad;

NSMutableArray * respuestaesp;
NSMutableArray * respuestadis;
NSMutableArray * respuestaseg;
NSMutableArray * respuesta;
NSMutableArray * idsespecialidad;
NSMutableArray * idsdistrito;
NSMutableArray * idsseguro;

int variable;
NSNumber* idespecialidad;
NSNumber*  iddistrito;
NSNumber*  idseguro;
NSString *fechatexto;
NSNumber * turno;

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
    distrito = [[NSMutableArray alloc] init];
    seguro = [[NSMutableArray alloc] init];
    fechas = [[NSMutableArray alloc]init];
    idsespecialidad = [[NSMutableArray alloc] init];
    idsdistrito = [[NSMutableArray alloc] init];
    idsseguro = [[NSMutableArray alloc] init];
    [self sacoEspecialidades];
    [self sacoDistritos];
    [self sacoSeguros];
    [self llenoFechas ];
    
    
    lblEspecialidad.delegate = self;
    self.lblDistrito.delegate=self;
    self.lblSeguro.delegate=self;
    self.lblDia.delegate=self;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}

//METODO PARA EL SEGMENTED CONTROL
- (IBAction)seApretoSegmented:(id)sender {
    
    if([sender selectedSegmentIndex]==0){
        turno=@0;
    }else if([sender selectedSegmentIndex]==1){
        turno=@1;
    }
}




-(void) textFieldDidBeginEditing:(UITextField *)textField{

    CGRect pickerFrame = CGRectMake(0, 44, 0, 0);
    
    pickerespecialidad = [[UIPickerView alloc]initWithFrame:pickerFrame];
    
    pickerespecialidad.delegate=self;
    
    if (lblEspecialidad.isEditing) {
 
        lblEspecialidad.text= [especialidad objectAtIndex:0];
        lblEspecialidad.inputView = pickerespecialidad;
        variable=1;
        
    }else if (self.lblDistrito.isEditing){
    
        self.lblDistrito.text= [distrito objectAtIndex:0];
        self.lblDistrito.inputView=pickerespecialidad;
        variable=2;
    
    } else if (self.lblSeguro.isEditing){
        self.lblSeguro.text= [seguro objectAtIndex:0];
        self.lblSeguro.inputView=pickerespecialidad;
        variable=3;
    
    } else if (self.lblDia.isEditing){
        self.lblDia.text = [fechas objectAtIndex:0];
        self.lblDia.inputView=pickerespecialidad;
        variable=4;
    
    }
    
    

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [lblEspecialidad resignFirstResponder];
    [self.lblDistrito resignFirstResponder];
    [self.lblDia resignFirstResponder];
    [self.lblSeguro resignFirstResponder];
}





//metodos del picker view

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 1;

}

-(NSInteger) pickerView: (UIPickerView*) picker numberOfRowsInComponent:(NSInteger)component{
    
    if (variable==1) {
        return (especialidad.count);
    } else if (variable==2){
        return (distrito.count);
    }else if (variable==3){
        return (seguro.count);
    }else if (variable==4) {
        return (fechas.count);
    }else return 0;

}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (variable==1) {
        return [especialidad objectAtIndex:row];
    } else if (variable==2){
        return [distrito objectAtIndex:row];
    } else if(variable==4){
        return [fechas objectAtIndex:row];
    }
    else return 0;


}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (variable==1) {
        lblEspecialidad.text= especialidad[row];
        idespecialidad= idsespecialidad[row];
    } else if (variable==2){
        self.lblDistrito.text= distrito[row];
        iddistrito = idsespecialidad[row];
    } else if(variable==3){
        self.lblSeguro.text=seguro[row];
        idseguro=idsseguro[row];
    } else if (variable==4){
        self.lblDia.text=fechas[row];
        fechatexto = fechas[row]; //AQUI SE ASIGNA STRING
    }
    
    
}



-(void) sacoEspecialidades{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaespecialidades parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestaesp = responseObject;
        NSLog(@"JSON: %@", respuestaesp);
        
        for(int i=0;i<respuestaesp.count;i++){
            NSDictionary * diccionario = respuestaesp[i];
            NSDictionary * diccionario2=  diccionario[@"specialty"];
            NSString * NombresEspecialidades= diccionario2[@"name"];
            NSNumber * IDSpecialty = diccionario2[@"idspecialty"];
            
            
            [especialidad addObject:NombresEspecialidades];
            [idsespecialidad addObject:IDSpecialty];
            
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

-(void) sacoDistritos{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listadistritos parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestadis = responseObject;
        NSLog(@"JSON: %@", respuestadis);
        
        for(int i=0;i<respuestadis.count;i++){
            NSDictionary * diccionario = respuestadis[i];
            NSDictionary * diccionario2=  diccionario[@"district"];
            NSString * Distrito= diccionario2[@"name"];
            NSNumber *IDDistrito = diccionario2[@"iddistrict"];
            
            
            [distrito addObject:Distrito];
            [idsdistrito addObject:IDDistrito];

        }

        NSLog(@"JSON: %@", distrito);
        
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
            
            
            [seguro addObject:Seguro];
            [idsseguro addObject:IDSeguro];
            
        }
        
        NSLog(@"JSON: %@", seguro);
        
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

-(void) llenoFechas{

    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    
    NSInteger dc = [currentCalendar  ordinalityOfUnit:NSDayCalendarUnit
                                               inUnit:NSYearCalendarUnit
                                              forDate:today];

    
    for (int index = dc; index <= 365; index++)
    {
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:index];
        [components setYear:2014];
        //NSCalendar *gregorian = [[NSCalendar alloc]
                                //initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        NSDate *date = [currentCalendar dateFromComponents:components];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        NSString *articleDateString = [formatter stringFromDate:date];
        NSString *pickerItemTitle = [NSString stringWithFormat: @"%@",articleDateString];
        [fechas addObject: pickerItemTitle];

}
}

//Para pasar los datos a la otra ventana!

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    DocsBusquedaTableViewController *escenadestino = segue.destinationViewController;
    escenadestino.idespecialidad= idespecialidad;
    escenadestino.iddistrito=iddistrito;
    escenadestino.idseguromed=idseguro;
    escenadestino.fecha= fechatexto;
    escenadestino.turno=turno;

}

@end
