//
//  ReservasViewController.h
//  buscaDocapp
//
//  Created by inf227al on 21/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservasViewController : UIViewController

@property NSNumber* idblock;
@property NSNumber *idschedule;
@property NSNumber * idpatient;
@property NSNumber * iddoctor;
@property NSString* name;
@property NSString* lastname;
@property NSNumber *idclinic;
@property NSString *nombreespecialidad;
@property NSDate * fechaseleccionada;
@property NSDate * horainicio;
@property NSDate *horafin;
@property int cantidadfilas;


@property (weak, nonatomic) IBOutlet UIImageView *iconCita;

@property (weak, nonatomic) IBOutlet UILabel *lblNombreDoctor;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha;
@property (weak, nonatomic) IBOutlet UILabel *lblHora;
@property (weak, nonatomic) IBOutlet UILabel *lblEspecialidad;
@property (weak, nonatomic) IBOutlet UILabel *lblNombreClinica;
@property (weak, nonatomic) IBOutlet UILabel *lblDireccion;
@property (weak, nonatomic) IBOutlet UILabel *lblTelefono;

@end
