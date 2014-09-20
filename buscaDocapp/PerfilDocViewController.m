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
    self.iconDoctor.layer.cornerRadius = self.iconDoctor.frame.size.width / 2;
    self.iconDoctor.clipsToBounds = YES;
    
    self.lblNombre.text=[NSString stringWithFormat:@"Dr. %@ %@ ", self.name, self.lastname];
    self.lblEspecialidad.text=self.nombreespecialidad;
    
    [self buscaNombreClinica];

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buscaNombreClinica{
    
    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.idclinic, @"idclinic", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:clinicaxid parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);

        NSDictionary * diccionario2=  [respuesta objectForKey:@"clinic"];
        clinicaname= [diccionario2 objectForKey:@"name"];

        
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

    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.iddoctor, @"iddoctor", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:horarioxdoc parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        
        for(int i=0;i<respuesta2.count;i++){
            NSDictionary * diccionario = [respuesta2 objectAtIndex:i];
            NSDictionary * diccionario2=  [diccionario objectForKey:@"schedule"];
            NSString * Dia= [diccionario2 objectForKey:@"day"];
            NSString * StartTime= [diccionario2 objectForKey:@"start_time"];
            NSString * EndTime= [diccionario2 objectForKey:@"end_time"];
            NSNumber *IDSchedule= [diccionario2 objectForKey:@"idschedule"];

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
