//
//  PerfilDocViewController.h
//  buscaDocapp
//
//  Created by inf227al on 19-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfilDocViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *iconDoctor;
@property (weak, nonatomic) IBOutlet UILabel *lblNombre;
@property (weak, nonatomic) IBOutlet UILabel *lblClinica;
@property (weak, nonatomic) IBOutlet UILabel *lblEspecialidad;
@property (weak, nonatomic) IBOutlet UILabel *lblLunes;
@property (weak, nonatomic) IBOutlet UILabel *lblMartes;
@property (weak, nonatomic) IBOutlet UILabel *lblMiercoles;
@property (weak, nonatomic) IBOutlet UILabel *lblJueves;
@property (weak, nonatomic) IBOutlet UILabel *lblViernes;




@property NSNumber* iddoctor;
@property NSString* name;
@property NSString* lastname;
@property NSNumber *idclinic;
@property NSString *nombreespecialidad;
@property int cantidadfilas;


@end
