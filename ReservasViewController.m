//
//  ReservasViewController.m
//  buscaDocapp
//
//  Created by inf227al on 21/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "ReservasViewController.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface ReservasViewController ()


@end

@implementation ReservasViewController

NSDictionary * respuesta;
NSDictionary * respuesta2;
NSString *fechasel;

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
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self ActualizaDatosClinica];

    
}

- (IBAction)confirmarReserva:(id)sender {
    
    [self RegistroCita];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) ActualizaDatosClinica{
    
    NSDictionary *consulta = @{@"idclinic": self.idclinic};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:clinicaxid parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        NSDictionary * diccionario2=  respuesta[@"clinic"];
        NSString *clinicaname= diccionario2[@"name"];
        NSString *direccion= diccionario2[@"address"];
        NSString *telefono= diccionario2[@"phone"];
        
        
        self.iconCita.layer.cornerRadius = self.iconCita.frame.size.width / 2;
        self.iconCita.clipsToBounds = YES;
        self.lblNombreDoctor.text= [NSString stringWithFormat:@"Dr. %@ %@ ", self.name, self.lastname];
        self.lblEspecialidad.text= self.nombreespecialidad;
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
        [dateFormat2 setDateFormat:@"dd/MM/yyyy"];
        
        NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
        [dateFormat3 setDateFormat:@"HH:mm"];
        
        //NSDate *fecha = [dateFormat dateFromString:self.horainicio];
        
        //NSDate *date = [dateFormat dateFromString:fecha];
        //NSTimeInterval secondsInEightHours = 29 * 60 * 60;
        //NSDate *dateEightHoursAhead = [self.horainicio dateByAddingTimeInterval:secondsInEightHours];
        
        
        fechasel =[dateFormat stringFromDate:self.fechaseleccionada];
        //NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];
        
        
        self.lblHora.text=self.horainicio;
        self.lblFecha.text=fechasel;
        self.lblNombreClinica.text=clinicaname;
        self.lblDireccion.text=direccion;
        self.lblTelefono.text=telefono;
        
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


//PARA EL REGISTRO DE CITAS

-(void) RegistroCita{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    self.idpatient = [NSNumber numberWithInt:pat];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.idblock,@"idblock",self.idschedule,@"idschedule",self.idpatient,@"idpatient",self.horainicio,@"start_time",self.horafin,@"end_time",self.iddoctor,@"iddoctor", fechasel,@"fecha",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:guardaCita parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        NSString* resultado=  respuesta2[@"status"];
        
        
        if ([resultado isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Se registro correctamente su Cita"
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



@end
