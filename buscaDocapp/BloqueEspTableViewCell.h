//
//  BloqueEspTableViewCell.h
//  buscaDocapp
//
//  Created by inf227al on 23/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloqueEspTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblHoras;
@property (weak, nonatomic) IBOutlet UIImageView *imageDisponibilidad;
@property (weak, nonatomic) IBOutlet UIButton *btnReservar;


@end
