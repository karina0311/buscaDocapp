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
#import "DoctoresxEspTableViewController.h"

@interface EspecialidadTableViewController ()



@end



@implementation EspecialidadTableViewController

NSMutableArray *titulos;
NSMutableArray *ids;
NSMutableArray * respuesta;
//Para el resultado de los filtros


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
    titulos = [[NSMutableArray alloc] init];
    ids = [[NSMutableArray alloc] init];

    [self recuperoListaEspecialidades];
    
    //Carga la lista de Especialidades por Orden Alfabetico
    
    self.searchResult = [NSMutableArray arrayWithCapacity:[titulos count]];
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return (self.searchResult.count);
    }
    else
    {
        return (titulos.count);
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CeldaEspecialidades";
    CeldaListaEspecialidades *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil )
    {
        cell = [[CeldaListaEspecialidades alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.lblEspecialidad.text= self.searchResult[indexPath.row];
    }
    
    else
    {
        cell.lblEspecialidad.text=titulos[indexPath.row];
    }
    

    
    return cell;
    
    /*UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaEspecialidades"];
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        ((CeldaListaEspecialidades*)cell).lblEspecialidad.text= self.searchResult[indexPath.row];
    }
    else
    {
        ((CeldaListaEspecialidades*)cell).lblEspecialidad.text=titulos[indexPath.row];
    }*/
    
    
    

    return cell;
}

//METODO PARA EL FILTER

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [titulos filteredArrayUsingPredicate:resultPredicate]];
    
    //lNSLog(self.searchResult);
    
    //[self.tableView reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [self filterContentForSearchText:searchString scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [self.searchDisplayController.searchBar scopeButtonTitles][searchOption]];
   
    return YES;
}


//METODO PARA OBTENER TODAS LAS ESPECIALIDADES, ENVIADO DESDE BACKEND


-(void) recuperoListaEspecialidades{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaespecialidades parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);

        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"specialty"];
            NSString * NombresEspecialidades= diccionario2[@"name"];
            NSNumber *IDSpecialty = diccionario2[@"idspecialty"];
            
            
            [ids addObject:IDSpecialty];
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

//PARA MANDAR A LA SIGUIENTE PESTAÑA

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    DoctoresxEspTableViewController *escenadestino = segue.destinationViewController;
    NSIndexPath *filaseleccionada = [self.tableView indexPathForSelectedRow];
    escenadestino.idespecialidad= ids[filaseleccionada.row];
    escenadestino.nombreespecialidad = titulos[filaseleccionada.row];
    escenadestino.cantidadfilas=titulos.count;
    
}

//PARA EL SEGMENTED CONTROL

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
