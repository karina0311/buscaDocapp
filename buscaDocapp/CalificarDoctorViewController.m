//
//  CalificarDoctorViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 1/12/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "CalificarDoctorViewController.h"
#import "URLS json.h"

@interface CalificarDoctorViewController ()

@end

@implementation CalificarDoctorViewController

NSNumber * ratingCalidad;
NSNumber * ratingRapidez;
NSDictionary * respuesta;
NSDictionary * respuesta2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //RatingCalidad
    
    self.RatingCalidad.backgroundColor  = [UIColor clearColor];
    self.RatingCalidad.starImage = [[UIImage imageNamed:@"starvacia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.RatingCalidad.starHighlightedImage = [[UIImage imageNamed:@"starllena"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.RatingCalidad.maxRating = 5.0;
    self.RatingCalidad.delegate = self;
    self.RatingCalidad.horizontalMargin = 15.0;
    self.RatingCalidad.editable=YES;
    self.RatingCalidad.rating= 3.0;
    self.RatingCalidad.displayMode=EDStarRatingDisplayHalf;
    [self.RatingCalidad  setNeedsDisplay];
    self.RatingCalidad.tintColor = [[UIColor alloc] initWithRed:255.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1];
    
    //RatingRapidez
    
    self.RatingRapidez.backgroundColor  = [UIColor clearColor];
    self.RatingRapidez.starImage = [[UIImage imageNamed:@"starvacia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.RatingRapidez.starHighlightedImage = [[UIImage imageNamed:@"starllena"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.RatingRapidez.maxRating = 5.0;
    self.RatingRapidez.delegate = self;
    self.RatingRapidez.horizontalMargin = 15.0;
    self.RatingRapidez.editable=YES;
    self.RatingRapidez.rating= 3.0;
    self.RatingRapidez.displayMode=EDStarRatingDisplayHalf;
    [self.RatingRapidez  setNeedsDisplay];
    self.RatingRapidez.tintColor = [[UIColor alloc] initWithRed:255.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1];
    
    
    self.namelabel.text=self.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GuardaRating:(id)sender {
    
    double ratingAux = self.RatingCalidad.rating;
    ratingCalidad = [[NSNumber alloc] initWithDouble:ratingAux];
    double ratingAux2 = self.RatingRapidez.rating;
    ratingRapidez = [[NSNumber alloc] initWithDouble:ratingAux2];
    
    [self guardoRating];
}


/*ENVIO JSON*/
-(void) guardoRating{
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    int pat= [datos integerForKey:@"IDPatient"];
    self.idpatient = [NSNumber numberWithInt:pat];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:self.idpatient,@"idpatient",ratingCalidad,@"ratingcalidad",ratingRapidez,@"ratingrapidez",self.iddoctor,@"iddoctor",nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSLog(@"%@", consulta);
    
    [manager POST:guardaRating parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta2 = responseObject;
        NSLog(@"JSON: %@", respuesta2);
        
        
        NSString* resultado=  respuesta2[@"status"];
        
        
        if ([resultado isEqualToString:@"ok"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                                message:@"Muchas Gracias por darnos tu opinión!. Su calificación se registró satisfactoriamente. "
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
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
