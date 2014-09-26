//
//  BusquedaGeneralViewController.h
//  buscaDocapp
//
//  Created by inf227al on 10/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusquedaGeneralViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {

    NSMutableArray *especialidad;
    UIPickerView *pickerespecialidad;
    NSMutableArray *distrito;
    NSMutableArray *seguro;
    NSMutableArray *fechas;

}

@property (strong, nonatomic) IBOutlet UISegmentedControl *SegmentedShift;

@property (weak, nonatomic) IBOutlet UITextField *lblEspecialidad;
@property (weak, nonatomic) IBOutlet UITextField *lblDistrito;
@property (weak, nonatomic) IBOutlet UITextField *lblSeguro;
@property (weak, nonatomic) IBOutlet UITextField *lblDia;



@end
