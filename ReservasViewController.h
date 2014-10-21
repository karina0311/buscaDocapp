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
@property NSNumber *idpatient;
@property NSString* name;
@property NSString* lastname;
@property NSNumber *idclinic;
@property NSString *nombreespecialidad;
@property NSDate * fechaseleccionada;
@property NSDate * horainicio;
@property NSDate *horafin;
@property int cantidadfilas;

@end
