
//  DocsBusquedaTableViewController.m
//  buscaDocapp
//
//  Created by inf227al on 25/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "DocsBusquedaTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "CeldaDocsBusquedaTableViewCell.h"
#import "PerfilDocViewController.h"

@interface DocsBusquedaTableViewController ()

@end

@implementation DocsBusquedaTableViewController

NSMutableArray *names;
NSMutableArray *lastnames;
NSMutableArray *maidennames;
NSMutableArray *iddoctors;
NSMutableArray *idclinics;
NSMutableArray *gender;

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
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    names = [[NSMutableArray alloc] init];
    lastnames = [[NSMutableArray alloc] init];
    iddoctors = [[NSMutableArray alloc] init];
    idclinics = [[NSMutableArray alloc] init];
    gender = [[NSMutableArray alloc] init];
    [self BusquedaAvanzada];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return names.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaDocBusqueda"];
    
    ((CeldaDocsBusquedaTableViewCell*)cell).lblNombre.text= [NSString stringWithFormat:@"Dr. %@ %@ ",(NSString*)names[indexPath.row], (NSString*)lastnames[indexPath.row]];
    
    if (((NSNumber*)gender[indexPath.row]).intValue==70) {
        ((CeldaDocsBusquedaTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"female50.png"];
    }else ((CeldaDocsBusquedaTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"male50.png"];
    
    return cell;
}

//METODO PARA BUSCAR DOCTORES SEGUN BUSQUEDA AVANZADA

-(void) BusquedaAvanzada{
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.turno,@"shift",self.fecha,@"fecha",self.idseguromed,@"idinsurance",self.iddistrito,@"iddistrict",self.idespecialidad,@"idspecialty",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:docsbusqueda parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"doctor"];
            NSNumber * IDDoctor= diccionario2[@"iddoctor"];
            NSString * NombreDoctor= diccionario2[@"name"];
            NSString * ApellidoDoctor= diccionario2[@"lastName"];
            NSString * Apellido2Doctor= diccionario2[@"maidenName"];
            NSNumber *IDClinic= diccionario2[@"idclinic"];
            NSString *Genero = diccionario2[@"gender"];
            
            [iddoctors addObject:IDDoctor];
            [names addObject:NombreDoctor];
            [lastnames addObject:ApellidoDoctor];
            [maidennames addObject:Apellido2Doctor];
            [idclinics addObject:IDClinic];
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
    //escenadestino.nombreespecialidad= self.idespecialidad;
    
}


@end
