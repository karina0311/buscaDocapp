//
//  PerfilViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 26/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "PerfilViewController.h"
#import "MiDoctorTableViewCell.h"
#import "MisCitasTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface PerfilViewController ()

@end

@implementation PerfilViewController

NSNumber *idpatient;
NSMutableArray *respuesta;
NSMutableArray *idsappointments;
NSMutableArray *dates;
NSMutableArray *start_times;
NSMutableArray *end_times;
int segindice;

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
    // Do any additional setup after loading the view.
    idsappointments = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    start_times = [[NSMutableArray alloc] init];
    end_times = [[NSMutableArray alloc] init];
    [self loadAppointments];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Metodos para la tabla

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int secciones;
    if(segindice==0){
    
    }else if (segindice==1){
        
    } else if (segindice==2){
        secciones= idsappointments.count;
    }
    
    return secciones;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if(segindice==0){
        
        return cell;
        
    }else if (segindice==1){
        
        return cell;
 
    } else if (segindice==2){
        static NSString *MyIdentifier = @"CitaCell";
        MisCitasTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:MyIdentifier];
        
        ((MisCitasTableViewCell*)cell).lblFecha.text = [dates objectAtIndex:indexPath.row];
        
         ((MisCitasTableViewCell*)cell).lblHora = [start_times objectAtIndex:indexPath.row];
        
        return cell;
       
    }
    return nil;
}



//Cargo Citas por Paciente

-(void) loadAppointments{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    idpatient = [NSNumber numberWithInt:pat];
    
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaCitasporPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"appointment"];
            NSNumber * IDAppointment= diccionario2[@"idappointment"];
            NSString * start_time= diccionario2[@"start_time"];
            NSString * end_time= diccionario2[@"end_time"];
            NSString * date= diccionario2[@"date"];

            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss-zz:zz"];
            
            NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
            [dateFormat2 setDateFormat:@"dd/MM/yyyy"];
            
            NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
            [dateFormat3 setDateFormat:@"HH:mm"];
            
            NSDate *fechaformato =[dateFormat dateFromString:date];
            
            NSDate *date1 = [dateFormat dateFromString:start_time];
            NSTimeInterval secondsInEightHours = 29 * 60 * 60;
            NSDate *dateEightHoursAhead = [date1 dateByAddingTimeInterval:secondsInEightHours];
            
            NSDate *date2 = [dateFormat dateFromString:end_time];
            NSTimeInterval secondsInEightHours2 = 29 * 60 * 60;
            NSDate *dateEightHoursAhead2 = [date2 dateByAddingTimeInterval:secondsInEightHours2];
            
            NSString *fecha = [dateFormat3 stringFromDate:fechaformato];
            NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];
            NSString *horaf= [dateFormat3 stringFromDate:dateEightHoursAhead2];
            
            [idsappointments addObject:IDAppointment];
            [dates addObject:date];
            [start_times addObject:horai];
            [end_times addObject:horaf];

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



- (IBAction)cambioPerfil:(UISegmentedControl *)sender {
    
    if([sender selectedSegmentIndex]==0){
        segindice=0;
        [self.table reloadData];
        
    }else if([sender selectedSegmentIndex]==1){
        segindice=1;
        [self.table reloadData];
        
    }else if([sender selectedSegmentIndex]==2){
        segindice=2;
        [self.table reloadData];
        
}

}

@end
