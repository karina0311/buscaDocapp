//
//  ListaClinicasTableViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 22/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "ListaClinicasTableViewController.h"
#import "CeldaListaClinicasTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface ListaClinicasTableViewController ()

@end

@implementation ListaClinicasTableViewController

NSMutableArray *titulos;
NSMutableArray *ids;
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
    ids = [[NSMutableArray alloc] init];
    
    [self recuperoClinicas];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return (titulos.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaClinicas"];
    
    ((CeldaListaClinicasTableViewCell*)cell).lblNombre.text= titulos[indexPath.row];
    

    
    return cell;
}

-(void) recuperoClinicas{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:listaclinicas parameters:nil success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = [respuesta objectAtIndex:i];
            NSDictionary * diccionario2=  [diccionario objectForKey:@"clinic"];
            NSString * Distrito= [diccionario2 objectForKey:@"name"];
            NSNumber *IDDistrito = [diccionario2 objectForKey:@"idclinic"];
            
            
            [ids addObject:IDDistrito];
            [titulos addObject:Distrito];
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
