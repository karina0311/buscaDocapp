//
//  CalificarDoctorViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 1/12/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "CalificarDoctorViewController.h"

@interface CalificarDoctorViewController ()

@end

@implementation CalificarDoctorViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
