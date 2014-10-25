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
    
    [self ActualizaDatosClinica];

    
}

- (IBAction)confirmarReserva:(id)sender {
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
        
        
        NSString *fechasel =[dateFormat stringFromDate:self.fechaseleccionada];
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




@end
