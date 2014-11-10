//
//  MisCitasTableViewCell.h
//  buscaDocapp
//
//  Created by inf227al on 5/11/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MisCitasTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblFecha;

@property (weak, nonatomic) IBOutlet UILabel *lblHora;

@property (weak, nonatomic) IBOutlet UILabel *lblClinica;
@property (weak, nonatomic) IBOutlet UILabel *lblEspecialidad;
@property (weak, nonatomic) IBOutlet UIImageView *avatarCita;
@property (weak, nonatomic) IBOutlet UIImageView *status;

@end
