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

@interface DoctoresxDistritoTableViewController ()

@end

@implementation DoctoresxDistritoTableViewController

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
    
    names = [[NSMutableArray alloc] init];
    lastnames = [[NSMutableArray alloc] init];
    iddoctors = [[NSMutableArray alloc] init];
    idclinics = [[NSMutableArray alloc] init];
    gender = [[NSMutableArray alloc] init];
    
        [self recuperoDoctoresporDistrito];

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
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdadocDistritos"];
    
    ((CeldaDocsDistritoTableViewCell*)cell).lblNombre.text= [NSString stringWithFormat:@"Dr. %@ %@ ",(NSString*)names[indexPath.row], (NSString*)lastnames[indexPath.row]];
    
    if (((NSNumber*)gender[indexPath.row]).intValue==70) {
        ((CeldaDocsDistritoTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"female50.png"];
    }else ((CeldaDocsDistritoTableViewCell*)cell).imageView.image= [UIImage imageNamed:@"male50.png"];

    
    return cell;
}

-(void) recuperoDoctoresporDistrito{
    
    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys: self.iddistrito, @"iddistrito", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:docsxdistrito parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        
        
        for(int i=0;i<respuesta.count;i++){
            NSDictionary * diccionario = [respuesta objectAtIndex:i];
            NSDictionary * diccionario2=  [diccionario objectForKey:@"doctor"];
            NSNumber * IDDoctor= [diccionario2 objectForKey:@"iddoctor"];
            NSString * NombreDoctor= [diccionario2 objectForKey:@"name"];
            NSString * ApellidoDoctor= [diccionario2 objectForKey:@"lastName"];
            NSString * Apellido2Doctor= [diccionario2 objectForKey:@"maidenName"];
            NSNumber *IDClinic= [diccionario2 objectForKey:@"idclinic"];
            NSString *Genero = [diccionario2 objectForKey:@"gender"];
            
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




@end
