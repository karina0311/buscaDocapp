//
//  DoctoresxEspTableViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 14/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "DoctoresxEspTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"
#import "CeldaDoctoresEspTableViewCell.h"

@interface DoctoresxEspTableViewController ()

@end

@implementation DoctoresxEspTableViewController

NSMutableArray *names;
NSMutableArray *lastnames;
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
    [self recuperoDoctoresporEspecialidad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
    cell = [tableView dequeueReusableCellWithIdentifier:@"celdaDoc"];
    
    ((CeldaDoctoresEspTableViewCell*)cell).lblName= names[indexPath.row];
    
    
    return cell;
}


-(void) recuperoDoctoresporEspecialidad{

    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.idespecialidad, @"idspecialty", nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
     NSLog(@"%@", consulta);
    
    [manager POST:docsxespecialidad parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        //NSLog(@"JSON: %@", respuesta);
        
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
