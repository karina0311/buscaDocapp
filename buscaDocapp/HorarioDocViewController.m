//
//  HorarioDocViewController.m
//  buscaDocapp
//
//  Created by inf227al on 23/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "HorarioDocViewController.h"
#import "DIDatepicker.h"
#import "BloqueEspTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "URLS json.h"

@interface HorarioDocViewController ()



@end

@implementation HorarioDocViewController
NSDictionary *respuesta;
NSMutableArray *respuesta2;
NSString * fechajson;



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
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.datepicker addTarget:self action:@selector(updateSelectedDate) forControlEvents:UIControlEventValueChanged];
    [self.datepicker fillDatesFromCurrentDate:14];
    [self.datepicker selectDateAtIndex:0];
    
    
    
    //[self.datepicker fillCurrentWeek];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//ESTE METODO SIRVE CUANDO SE SELECCIONA UNA FECHA
- (void)updateSelectedDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"dd/MM/yyyy" options:0 locale:nil];
    

    fechajson = [formatter stringFromDate:self.datepicker.selectedDate];
    NSLog(@"JSON: %@", fechajson);
    if (fechajson != nil) {
        [self cargaBloquesporFecha];
    }

}

//METODOS PARA EL TABLE VIEW CONTROLLER

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"celdaBloque";
    BloqueEspTableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:MyIdentifier];

    return cell;
}



-(void) cargaBloquesporFecha{
    
     NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:fechajson,@"fecha", self.iddoctor,@"iddoctor",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:bloquexhorario parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        
        for(int i=0;i<respuesta2.count;i++){

            
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

@end
