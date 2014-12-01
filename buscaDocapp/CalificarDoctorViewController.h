//
//  CalificarDoctorViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 1/12/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@interface CalificarDoctorViewController : UIViewController<UIAlertViewDelegate, EDStarRatingProtocol>
@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet EDStarRating *RatingCalidad;
@property (weak, nonatomic) IBOutlet EDStarRating *RatingRapidez;

@property NSNumber* iddoctor;
@property NSString* name;

@end
