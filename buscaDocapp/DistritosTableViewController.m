//
//  DistritosTableViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 19/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "DistritosTableViewController.h"
#import "CeldaListaDistritos.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "DoctoresxDistritoTableViewController.h"

@interface DistritosTableViewController ()

@end

@implementation DistritosTableViewController

NSMutableArray *titulosdistritos;
NSMutableArray *idsdistritos;
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
    titulosdistritos = [[NSMutableArray alloc] init];
    idsdistritos = [[NSMutableArray alloc] init];
    
    [self recuperoDistritos];
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return (titulosdistritos.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaDistritos"];
    
    ((CeldaListaDistritos*)cell).lblDistritos.text= titulosdistritos[indexPath.row];


    return cell;
}


//METODO PARA LISTA LOS DISTRITOS DE LIMA

-(void) recuperoDistritos{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listadistritos parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = respuesta[i];
            NSDictionary * diccionario2=  diccionario[@"district"];
            NSString * Distrito= diccionario2[@"name"];
            NSNumber *IDDistrito = diccionario2[@"iddistrict"];
            
            
            [idsdistritos addObject:IDDistrito];
            [titulosdistritos addObject:Distrito];
        }
        [self.tableView reloadData];
        NSLog(@"JSON: %@", titulosdistritos);
        
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
    
    DoctoresxDistritoTableViewController *escenadestino = segue.destinationViewController;
    NSIndexPath *filaseleccionada = [self.tableView indexPathForSelectedRow];
    escenadestino.iddistrito= idsdistritos[filaseleccionada.row];
    escenadestino.nombreDistrito = titulosdistritos[filaseleccionada.row];
    escenadestino.cantidadfilas=titulosdistritos.count;
    
}

@end
