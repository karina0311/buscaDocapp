//
//  HorarioDocViewController.m
//  buscaDocapp
//
//  Created by inf227al on 23/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "HorarioDocViewController.h"
#import "ReservasViewController.h"
#import "DIDatepicker.h"
#import "BloqueEspTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface HorarioDocViewController ()



@end

@implementation HorarioDocViewController
NSDictionary *respuesta;
NSMutableArray *respuesta2;
NSString * fechajson;


NSMutableArray *idsbloques;
NSMutableArray *horasinicio;
NSMutableArray *horasfin;
NSMutableArray *dias;
NSMutableArray *estados;
NSMutableArray *idschedules;
NSInteger var;



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
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    [self.datepicker fillDatesFromCurrentDate:14];
    [self.datepicker selectDateAtIndex:0];
    
    idsbloques = [[NSMutableArray alloc] init];
    horasinicio = [[NSMutableArray alloc] init];
    horasfin = [[NSMutableArray alloc] init];
    dias = [[NSMutableArray alloc] init];
    estados = [[NSMutableArray alloc] init];
    idschedules = [[NSMutableArray alloc] init];
    
    
    
    //[self.datepicker fillCurrentWeek];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//ESTE METODO SIRVE CUANDO SE SELECCIONA UNA FECHA
- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0 locale:nil];
 
    idsbloques = [[NSMutableArray alloc] init];
    horasinicio = [[NSMutableArray alloc] init];
    horasfin = [[NSMutableArray alloc] init];
    dias = [[NSMutableArray alloc] init];
    estados = [[NSMutableArray alloc] init];
    idschedules = [[NSMutableArray alloc] init];
    
    [self.table reloadData];
    

    fechajson = [formatter stringFromDate:self.datepicker.selectedDate];
    NSLog(@"JSON: %@", fechajson);
    if (fechajson != nil) {
        [self cargaBloquesporFecha];
    }

}

//METODOS PARA EL TABLE VIEW CONTROLLER

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (idsbloques.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"celdaBloque";
    BloqueEspTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    
    ((BloqueEspTableViewCell*)cell).lblHoras.text= [NSString stringWithFormat:@"%@ - %@ ", horasinicio[indexPath.row],horasfin[indexPath.row]];
    
    if (((NSNumber*)estados[indexPath.row]).intValue==0) {
        ((BloqueEspTableViewCell*)cell).imageDisponibilidad.image= [UIImage imageNamed:@"ok-26.png"];
        ((BloqueEspTableViewCell*)cell).btnReservar.alpha=1;
    }else {
        ((BloqueEspTableViewCell*)cell).imageDisponibilidad.image= [UIImage imageNamed:@"cancel-26.png"];
        ((BloqueEspTableViewCell*)cell).btnReservar.alpha=0;
    }
    
    cell.btnReservar.tag=indexPath.row;
    return cell;
}

- (IBAction)apretoReservar:(UIButton *)sender {
    
    var=sender.tag;
}




-(void) cargaBloquesporFecha{
    
     NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:fechajson,@"fecha", self.iddoctor,@"iddoctor",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:bloquexhorario parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        
        for(int i=0;i<respuesta2.count;i++){
            
            NSDictionary * diccionario = respuesta2[i];
            NSDictionary * diccionario2=  diccionario[@"block"];
            NSNumber * IDBlock= diccionario2[@"idblock"];
            NSString * Date= diccionario2[@"date"];
            NSString * horainicio= diccionario2[@"start_time"];
            NSString * horafin= diccionario2[@"end_time"];
            NSNumber *estado= diccionario2[@"status"];
            NSNumber *idschedule = diccionario2[@"idschedule"];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss-zz:zz"];
            
            NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
            [dateFormat3 setDateFormat:@"HH:mm"];
            
            NSDate *fecha = [dateFormat dateFromString:Date];
            
            NSDate *date = [dateFormat dateFromString:horainicio];
            NSTimeInterval secondsInEightHours = 29 * 60 * 60;
            NSDate *dateEightHoursAhead = [date dateByAddingTimeInterval:secondsInEightHours];
            
            
            NSDate *date2 = [dateFormat dateFromString:horafin];
            NSTimeInterval secondsInEightHours1 = 29 * 60 * 60;
            NSDate *dateEightHoursAhead1 = [date2 dateByAddingTimeInterval:secondsInEightHours1];
            
            
            
            NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];
            NSString *horaf= [dateFormat3 stringFromDate:dateEightHoursAhead1];
            
            [idsbloques addObject:IDBlock];
            [dias addObject:fecha];
            [horasinicio addObject:horai];
            [horasfin addObject:horaf];
            [estados addObject:estado];
            [idschedules addObject:idschedule];

            
        }
        
        [self.table reloadData];
        
        
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
    
    ReservasViewController *escenadestino = segue.destinationViewController;

    escenadestino.idclinic=self.idclinic;
    escenadestino.name=self.name;
    escenadestino.lastname=self.lastname;
    escenadestino.nombreespecialidad=self.nombreespecialidad;
    escenadestino.idblock=idsbloques[var];
    escenadestino.idschedule=idschedules[var];
    escenadestino.horainicio=horasinicio[var];
    escenadestino.horafin=horasfin[var];
    
}

@end
