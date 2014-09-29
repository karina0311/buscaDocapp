//
//  PerfilDocViewController.m
//  buscaDocapp
//
//  Created by inf227al on 19-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "PerfilDocViewController.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "HorarioDocViewController.h"

@interface PerfilDocViewController ()

@end

@implementation PerfilDocViewController

NSDictionary *respuesta;
NSMutableArray *respuesta2;
NSString *clinicaname;
NSMutableArray *idshorarios;
NSMutableArray *horasinicio;
NSMutableArray *horasfin;
NSMutableArray *dias;



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
    idshorarios = [[NSMutableArray alloc] init];
    horasinicio = [[NSMutableArray alloc] init];
    horasfin = [[NSMutableArray alloc] init];
    dias = [[NSMutableArray alloc] init];
    
    self.iconDoctor.layer.cornerRadius = self.iconDoctor.frame.size.width / 2;
    self.iconDoctor.clipsToBounds = YES;
    
    self.lblNombre.text=[NSString stringWithFormat:@"Dr. %@ %@ ", self.name, self.lastname];
    self.lblEspecialidad.text=self.nombreespecialidad;
    
    [self buscaNombreClinica];
    
    [self listaHorario];

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buscaNombreClinica{
    
    NSDictionary *consulta = @{@"idclinic": self.idclinic};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:clinicaxid parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);

        NSDictionary * diccionario2=  respuesta[@"clinic"];
        clinicaname= diccionario2[@"name"];

        
        self.lblClinica.text=clinicaname;

    
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

-(void) listaHorario{

    NSDictionary *consulta = @{@"iddoctor": self.iddoctor};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:horarioxdoc parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        
        for(int i=0;i<respuesta2.count;i++){
            NSDictionary * diccionario = respuesta2[i];
            NSDictionary * diccionario2=  diccionario[@"schedule"];
            NSString * Dia= diccionario2[@"day"];
            NSString * StartTime= diccionario2[@"start_time"];
            NSString * EndTime= diccionario2[@"end_time"];
            NSNumber *IDSchedule= diccionario2[@"idschedule"];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss-zz:zz"];
            
            NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
            [dateFormat3 setDateFormat:@"HH:mm"];
            
            NSDate *date = [dateFormat dateFromString:StartTime];
            NSTimeInterval secondsInEightHours = 29 * 60 * 60;
            NSDate *dateEightHoursAhead = [date dateByAddingTimeInterval:secondsInEightHours];
            
            NSDate *date2 = [dateFormat dateFromString:EndTime];
            NSTimeInterval secondsInEightHours2 = 29 * 60 * 60;
            NSDate *dateEightHoursAhead2 = [date2 dateByAddingTimeInterval:secondsInEightHours2];
            
            
            NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];
            NSString *horaf= [dateFormat3 stringFromDate:dateEightHoursAhead2];
            
            [dias addObject:Dia];
            [horasinicio addObject:horai];
            [horasfin addObject:horaf];
            [idshorarios addObject:IDSchedule];
    
        }
        
        NSLog(@"JSON: %@", dias);
        
        for(int i=0;i<dias.count;i++){
        
            if([dias[i] isEqualToString:@"Lunes"]) self.lblLunes.text= [NSString stringWithFormat:@"%@ - %@ ", horasinicio[i],horasfin[i]]; ;
            
            if([dias[i] isEqualToString:@"Martes"]) self.lblMartes.text=[NSString stringWithFormat:@"%@ - %@ ", horasinicio[i],horasfin[i]];;
            
            if([dias[i] isEqualToString:@"Miercoles"]) self.lblMiercoles.text=[NSString stringWithFormat:@"%@ - %@ ", horasinicio[i],horasfin[i]];;
            
            if([dias[i] isEqualToString:@"Jueves"]) self.lblJueves.text=[NSString stringWithFormat:@"%@ - %@ ", horasinicio[i],horasfin[i]];;
            
            if([dias[i] isEqualToString:@"Viernes"]) self.lblViernes.text=[NSString stringWithFormat:@"%@ - %@ ", horasinicio[i],horasfin[i]];;
     
        
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    HorarioDocViewController *escenadestino = segue.destinationViewController;
    escenadestino.iddoctor= self.iddoctor;

}

@end
