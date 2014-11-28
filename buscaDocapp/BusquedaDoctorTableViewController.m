//
//  BusquedaDoctorTableViewController.m
//  buscaDocapp
//
//  Created by inf227al on 10/11/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "BusquedaDoctorTableViewController.h"
#import "BusquedaDocTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "PerfilDocViewController.h"

@interface BusquedaDoctorTableViewController ()

@end

@implementation BusquedaDoctorTableViewController

NSMutableArray *names;
NSMutableArray *lastnames;
NSMutableArray *maidennames;
NSMutableArray *iddoctors;
NSMutableArray *idclinics;
NSMutableArray *gender;
NSMutableArray *specialties;
NSMutableArray * respuestaesp;
NSMutableArray *especialidades;
NSMutableArray *idsespecialidades;

NSMutableArray * respuesta;
NSDictionary *consulta;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
   
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    names = [[NSMutableArray alloc] init];
    lastnames = [[NSMutableArray alloc] init];
    iddoctors = [[NSMutableArray alloc] init];
    idclinics = [[NSMutableArray alloc] init];
    gender = [[NSMutableArray alloc] init];
    specialties =[[NSMutableArray alloc] init];
    especialidades = [[NSMutableArray alloc] init];
    idsespecialidades = [[NSMutableArray alloc] init];

    switch (self.opcion) {
        case 0:
            [self busquedaNombre];
            break;
        case 1:
            [self busquedaApellido];
            break;
        case 2:
            [self busquedaNombreApellido];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaBusquedaDoc"];
    
    ((BusquedaDocTableViewCell*)cell).lblNombre.text= [NSString stringWithFormat:@"Dr. %@ %@ ",(NSString*)names[indexPath.row], (NSString*)lastnames[indexPath.row]];
    
    //((BusquedaDocTableViewCell*)cell).lblClinica.text= [especialidades objectAtIndex: ((NSNumber*)specialties[indexPath.row]).intValue -1 ];
    
    if (((NSNumber*)gender[indexPath.row]).intValue==70) {
        ((BusquedaDocTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"female50.png"];
    }else ((BusquedaDocTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"male50.png"];
    
    
    return cell;
}


/////////////////////////////////////

-(void) busquedaNombre{
    
    NSDictionary *consulta = @{@"name": self.nombre};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaDoctorporNombre parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"doctor"];
            NSNumber * IDDoctor= diccionario2[@"iddoctor"];
            NSString * NombreDoctor= diccionario2[@"name"];
            NSString * ApellidoDoctor= diccionario2[@"lastName"];
            NSString * Apellido2Doctor= diccionario2[@"maidenName"];
            NSNumber * idespecialidad = diccionario2[@"idspecialty"];
            NSNumber *IDClinic= diccionario2[@"idclinic"];
            NSString *Genero = diccionario2[@"gender"];
            
            [iddoctors addObject:IDDoctor];
            [names addObject:NombreDoctor];
            [lastnames addObject:ApellidoDoctor];
            [maidennames addObject:Apellido2Doctor];
            [idclinics addObject:IDClinic];
            [specialties addObject:idespecialidad];
            [gender addObject:Genero];
        }
        
        
        
        [self.tableView reloadData];
        
        
        
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


-(void) busquedaApellido{
    
    NSDictionary *consulta = @{@"last_name": self.apellido};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaDoctorporApellido parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"doctor"];
            NSNumber * IDDoctor= diccionario2[@"iddoctor"];
            NSString * NombreDoctor= diccionario2[@"name"];
            NSString * ApellidoDoctor= diccionario2[@"lastName"];
            NSString * Apellido2Doctor= diccionario2[@"maidenName"];
            NSNumber * idespecialidad = diccionario2[@"idspecialty"];
            NSNumber *IDClinic= diccionario2[@"idclinic"];
            NSString *Genero = diccionario2[@"gender"];
            
            [iddoctors addObject:IDDoctor];
            [names addObject:NombreDoctor];
            [lastnames addObject:ApellidoDoctor];
            [maidennames addObject:Apellido2Doctor];
            [idclinics addObject:IDClinic];
            [specialties addObject:idespecialidad];
            [gender addObject:Genero];
        }
        
        
        
        [self.tableView reloadData];
        
        
        
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

-(void) busquedaNombreApellido{
    
    NSDictionary *consulta = @{@"name": self.nombre, @"last_name": self.apellido,};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:sacaDoctorporNombreApellido parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"doctor"];
            NSNumber * IDDoctor= diccionario2[@"iddoctor"];
            NSString * NombreDoctor= diccionario2[@"name"];
            NSString * ApellidoDoctor= diccionario2[@"lastName"];
            NSString * Apellido2Doctor= diccionario2[@"maidenName"];
            NSNumber * idespecialidad = diccionario2[@"idspecialty"];
            NSNumber *IDClinic= diccionario2[@"idclinic"];
            NSString *Genero = diccionario2[@"gender"];
            
            [iddoctors addObject:IDDoctor];
            [names addObject:NombreDoctor];
            [lastnames addObject:ApellidoDoctor];
            [maidennames addObject:Apellido2Doctor];
            [idclinics addObject:IDClinic];
            [specialties addObject:idespecialidad];
            [gender addObject:Genero];
        }
        
        
        
        [self.tableView reloadData];
        
        
        
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
    
    PerfilDocViewController *escenadestino = segue.destinationViewController;
    NSIndexPath *filaseleccionada = [self.tableView indexPathForSelectedRow];
    escenadestino.iddoctor = iddoctors[filaseleccionada.row];
    escenadestino.name = names[filaseleccionada.row];
    escenadestino.lastname = lastnames[filaseleccionada.row];
    escenadestino.idclinic = idclinics[filaseleccionada.row];
    escenadestino.cantidadfilas = iddoctors.count;

    
}

@end
