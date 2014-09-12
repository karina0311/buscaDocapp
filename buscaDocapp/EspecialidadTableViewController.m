//
//  EspecialidadTableViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 22/08/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "EspecialidadTableViewController.h"
#import "CeldaListaEspecialidades.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface EspecialidadTableViewController ()

@end

@implementation EspecialidadTableViewController

NSMutableArray *titulos;
NSMutableArray * respuesta;

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
    titulos = [[NSMutableArray alloc] init];
    [self recuperoListaEspecialidades];
    
    //Carga la lista de Especialidades por Orden Alfabetico
    
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
    // Return the number of rows in the section.
    return (titulos.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaEspecialidades"];
    
    ((CeldaListaEspecialidades*)cell).lblEspecialidad.text=titulos[indexPath.row];

    return cell;
}


//METODO PARA OBTENER TODAS LAS ESPECIALIDADES, ENVIADO DESDE BACKEND


-(void) recuperoListaEspecialidades{
    
    NSDictionary * consulta;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaespecialidades parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);

        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = [respuesta objectAtIndex:i];
            NSDictionary * diccionario2=  [diccionario objectForKey:@"specialty"];
            NSString * NombresEspecialidades= [diccionario2 objectForKey:@"name"];
            
            [titulos addObject:NombresEspecialidades];
        }
        [self.tableView reloadData];
        NSLog(@"JSON: %@", titulos);

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
