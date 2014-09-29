//
//  DoctoresxDistritoTableViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 22/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "DoctoresxDistritoTableViewController.h"
#import "CeldaDocsDistritoTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "PerfilDocViewController.h"

@interface DoctoresxDistritoTableViewController ()

@end

@implementation DoctoresxDistritoTableViewController

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


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self sacoEspecialidades];
    
    names = [[NSMutableArray alloc] init];
    lastnames = [[NSMutableArray alloc] init];
    iddoctors = [[NSMutableArray alloc] init];
    idclinics = [[NSMutableArray alloc] init];
    gender = [[NSMutableArray alloc] init];
    specialties =[[NSMutableArray alloc] init];
    especialidades = [[NSMutableArray alloc] init];
    idsespecialidades = [[NSMutableArray alloc] init];
    
    //[self recuperoDoctoresporDistrito];

}

- (void)didReceiveMemoryWarning
{
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaDocDistrito"];
    
    ((CeldaDocsDistritoTableViewCell*)cell).lblNombre.text= [NSString stringWithFormat:@"Dr. %@ %@ ",(NSString*)names[indexPath.row], (NSString*)lastnames[indexPath.row]];
    
    ((CeldaDocsDistritoTableViewCell*)cell).lblClinica.text= [especialidades objectAtIndex: ((NSNumber*)specialties[indexPath.row]).intValue -1 ];
    
    if (((NSNumber*)gender[indexPath.row]).intValue==70) {
        ((CeldaDocsDistritoTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"female50.png"];
    }else ((CeldaDocsDistritoTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"male50.png"];

    
    return cell;
}

-(void) recuperoDoctoresporDistrito{
    
    NSDictionary *consulta = @{@"iddistrito": self.iddistrito};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:docsxdistrito parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
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
            
            
            [especialidades addObject:NombresEspecialidades];
            [idsespecialidades addObject:IDSpecialty];
            
        }
        
        [self recuperoDoctoresporDistrito];

        
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
    escenadestino.nombreespecialidad= especialidades[filaseleccionada.row];
    
}



@end
