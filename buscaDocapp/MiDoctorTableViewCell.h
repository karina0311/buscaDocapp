//
//  MiDoctorTableViewCell.h
//  buscaDocapp
//
//  Created by inf227al on 3/11/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@interface MiDoctorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNombre;
@property (weak, nonatomic) IBOutlet UILabel *lblClinica;
@property (weak, nonatomic) IBOutlet EDStarRating *ratingDoc;
@property (weak, nonatomic) IBOutlet UIImageView *avatarDoc;


@end
