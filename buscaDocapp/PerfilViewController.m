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
#import "CalificarDoctorViewController.h"

@interface PerfilViewController ()

@end

@implementation PerfilViewController

NSNumber *idpatient;
NSMutableArray *respuesta;
NSMutableArray *respuesta2;
NSMutableArray *respuesta3;
NSMutableArray *respuesta4;
NSDictionary  *respuesta5;
NSMutableArray  *respuesta6;


NSMutableArray *clinicAppointment;
NSMutableArray *SpecialtyAppointment;

NSMutableArray *iddoctors;
NSMutableArray *namesdoctor;
NSMutableArray *clinicsdoctor;
NSMutableArray *specialtiesdoctor;
NSMutableArray *idsappointments;
NSMutableArray *dates;
NSMutableArray *dates2;
NSMutableArray *start_times;
NSMutableArray *end_times;
NSMutableArray *scores;

NSString *name;
NSString *lastname;
NSString *maidenname;
NSString *email;
NSString *cellphone;
NSString *username;
NSString *birthday;


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
    [self.table reloadData];

    
}

-(void) viewWillAppear:(BOOL)animated{
    self.table.dataSource=self;
    self.table.delegate=self;
    // Do any additional setup after loading the view.
    idsappointments = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    dates2 = [[NSMutableArray alloc] init];
    start_times = [[NSMutableArray alloc] init];
    end_times = [[NSMutableArray alloc] init];
    
    clinicAppointment= [[NSMutableArray alloc] init];
    SpecialtyAppointment= [[NSMutableArray alloc] init];
    
    iddoctors= [[NSMutableArray alloc] init];
    namesdoctor=[[NSMutableArray alloc] init];
    clinicsdoctor=[[NSMutableArray alloc] init];
    scores=[[NSMutableArray alloc] init];
    specialtiesdoctor=[[NSMutableArray alloc] init];
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2;
    self.icon.clipsToBounds = YES;
    [self loadRatings];
    [self loadPatient];
    [self loadAppointments];
    [self.segmented setSelectedSegmentIndex:0];
    [self.table reloadData];

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
        secciones = iddoctors.count;
    }else if (segindice==1){
        secciones= idsappointments.count;
    }
    
    return secciones;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if(segindice==0){
        static NSString *MyIdentifier = @"DoctorCell";
        MiDoctorTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:MyIdentifier];
        
        ((MiDoctorTableViewCell*)cell).lblNombre.text = [NSString stringWithFormat:@"%@",(NSString*)namesdoctor[indexPath.row]];
        
        ((MiDoctorTableViewCell*)cell).ratingDoc.backgroundColor  = [UIColor clearColor];
        ((MiDoctorTableViewCell*)cell).ratingDoc.starImage = [[UIImage imageNamed:@"starvacia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        ((MiDoctorTableViewCell*)cell).ratingDoc.starHighlightedImage = [[UIImage imageNamed:@"starllena"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        ((MiDoctorTableViewCell*)cell).ratingDoc.maxRating = 5.0;
        ((MiDoctorTableViewCell*)cell).ratingDoc.delegate = self;
        ((MiDoctorTableViewCell*)cell).ratingDoc.horizontalMargin = 15.0;
        ((MiDoctorTableViewCell*)cell).ratingDoc.editable=NO;
        
        ((MiDoctorTableViewCell*)cell).ratingDoc.rating= ((NSNumber*)scores[indexPath.row]).floatValue;
        NSLog(@"%f",((NSNumber*)scores[indexPath.row]).floatValue);

        
        
        ((MiDoctorTableViewCell*)cell).ratingDoc.displayMode=EDStarRatingDisplayHalf;
        [((MiDoctorTableViewCell*)cell).ratingDoc  setNeedsDisplay];
        ((MiDoctorTableViewCell*)cell).ratingDoc.tintColor = [[UIColor alloc] initWithRed:255.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1];
        
        //((MiDoctorTableViewCell*)cell).lblClinica.text = [clinicsdoctor objectAtIndex:indexPath.row];
        
        return cell;
    }else if (segindice==1){
        static NSString *MyIdentifier = @"CitaCell";
        MisCitasTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:MyIdentifier];
        
        ((MisCitasTableViewCell*)cell).lblFecha.text = [dates objectAtIndex:indexPath.row];
        
        ((MisCitasTableViewCell*)cell).lblHora.text = [NSString stringWithFormat:@"%@",(NSString*)start_times[indexPath.row]];
        
        ((MisCitasTableViewCell*)cell).lblClinica.text = [clinicAppointment objectAtIndex:indexPath.row];
        
        ((MisCitasTableViewCell*)cell).lblEspecialidad.text = [SpecialtyAppointment objectAtIndex:indexPath.row];
        
        NSDate *mydate =[dates2 objectAtIndex: indexPath.row];
        NSDate *today =[NSDate date];
        
        if([mydate compare:today] == NSOrderedAscending){
            ((MisCitasTableViewCell*)cell).status.alpha = 0;
        } else  ((MisCitasTableViewCell*)cell).status.alpha = 1;
        
        return cell;
        
 
    }
    return cell;
}

//Cargo Doctores por Paciente

-(void) loadDoctors{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    idpatient = [NSNumber numberWithInt:pat];
    
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaDocsporPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        
        for(int i=0;i<respuesta2.count;i++){
            NSDictionary * diccionario = respuesta2[i];
            NSDictionary * diccionario2=  diccionario[@"doctor"];
            NSNumber * IDDoctor= diccionario2[@"iddoctor"];
            NSString * namedoctor= diccionario2[@"name"];
            NSString * lastnamedoctor= diccionario2[@"lastName"];
            NSString * specialtydoctor= diccionario2[@"idspecialty"];
            NSString * clinicdoctor= diccionario2[@"idclinic"];
            
            
            
            
            [iddoctors addObject:IDDoctor];
            [namesdoctor addObject:[NSString stringWithFormat:@"Dr. %@ %@ ", namedoctor, lastnamedoctor]];
            [specialtiesdoctor addObject:specialtydoctor];
            [clinicsdoctor addObject:clinicdoctor];
            
        }
        
        [self loadClinics];
        
        
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
            int daysToAdd = 1;
            NSDate *fechareal = [fechaformato dateByAddingTimeInterval:60*60*24*daysToAdd];
            
            NSDate *date1 = [dateFormat dateFromString:start_time];
            NSTimeInterval secondsInEightHours = 29 * 60 * 60;
            NSDate *dateEightHoursAhead = [date1 dateByAddingTimeInterval:secondsInEightHours];
            
            NSDate *date2 = [dateFormat dateFromString:end_time];
            NSTimeInterval secondsInEightHours2 = 29 * 60 * 60;
            NSDate *dateEightHoursAhead2 = [date2 dateByAddingTimeInterval:secondsInEightHours2];
            
            NSString *fecha = [dateFormat2 stringFromDate:fechareal];
            NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];
            NSString *horaf= [dateFormat3 stringFromDate:dateEightHoursAhead2];
            
            [idsappointments addObject:IDAppointment];
            [dates addObject:fecha];
            [dates2 addObject:fechareal];
            [start_times addObject:horai];
            [end_times addObject:horaf];

        }
        
        
        [self loadDoctors];
        
        
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

/********************************/

-(void) loadClinics{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    idpatient = [NSNumber numberWithInt:pat];
    
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaClinicaporPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta3 = responseObject;
        NSLog(@"JSON: %@", respuesta3);
        
        
        
        for(int i=0;i<respuesta3.count;i++){
            NSDictionary * diccionario = respuesta3[i];
            NSDictionary * diccionario2=  diccionario[@"clinic"];
            NSString * NameClinic= diccionario2[@"name"];

            
            [clinicAppointment addObject:NameClinic];

        }
        
        
        [self loadSpecialty];
        
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

-(void) loadSpecialty{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    idpatient = [NSNumber numberWithInt:pat];
    
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaEspecialidadporPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta4 = responseObject;
        NSLog(@"JSON: %@", respuesta4);
        
        
        
        for(int i=0;i<respuesta4.count;i++){
            NSDictionary * diccionario = respuesta4[i];
            NSDictionary * diccionario2=  diccionario[@"specialty"];
            NSString * NameSpecialty= diccionario2[@"name"];
            
            
            [SpecialtyAppointment addObject:NameSpecialty];
            
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


/*****************************/




-(void) loadPatient{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    NSInteger pat= [datos integerForKey:@"IDPatient"];
    username = [datos stringForKey:@"NombreUsuario"];
    idpatient = [NSNumber numberWithInteger:pat];
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaInfoPaciente parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta5 = responseObject;
        NSLog(@"JSON: %@", respuesta5);
        
        NSDictionary * diccionario2=  respuesta5[@"patient"];
        name= diccionario2[@"name"];
        lastname= diccionario2[@"last_name"];
        maidenname= diccionario2[@"maiden_name"];
        email= diccionario2[@"email"];
        //cellphone= diccionario2[@"cellphone"];
        
        self.namePatient.text=[NSString stringWithFormat:@"%@ %@ %@", name, lastname, maidenname];
        
        self.correo.text=email;
        self.user.text=username;
        //self.cellphone.text=cellphone;
        
        
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

-(void) loadRatings{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    NSInteger pat= [datos integerForKey:@"IDPatient"];
    username = [datos stringForKey:@"NombreUsuario"];
    idpatient = [NSNumber numberWithInteger:pat];
    
    NSDictionary *consulta = @{@"idpatient": idpatient};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaRating parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta6 = responseObject;
        NSLog(@"JSON: %@", respuesta6);
        
        for(int i=0;i<respuesta6.count;i++){
            NSDictionary * diccionario = respuesta6[i];
            NSDictionary * diccionario2=  diccionario[@"rating"];
            NSNumber * score= diccionario2[@"score"];

            [scores addObject:score];
        
            
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


/********************************/
- (IBAction)cambioPerfil:(UISegmentedControl *)sender {
    
    if([sender selectedSegmentIndex]==0){
        segindice=0;
        [self.table reloadData];
        
    }else if([sender selectedSegmentIndex]==1){
        segindice=1;
        [self.table reloadData];
        
    }

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    CalificarDoctorViewController *escenadestino = segue.destinationViewController;
    NSIndexPath *filaseleccionada = [self.table indexPathForSelectedRow];
    escenadestino.iddoctor = iddoctors[filaseleccionada.row];
    escenadestino.name = namesdoctor[filaseleccionada.row];

    
}

- (IBAction)cerrarSesion:(id)sender {
    
    
    UIAlertView* alertView;
    alertView = [[UIAlertView alloc] initWithTitle:@"Cerrar Sesión"
                                           message:@"Está seguro que desea cerrar sesión?"
                                          delegate:self
                                 cancelButtonTitle:@"No"
                                 otherButtonTitles:@"Si",nil];
    [alertView show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1){
        
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"NombreUsuario"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ContraseñaUsuario"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}

@end
