//
//  RegistroSeguro.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 19/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistroSeguro : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {

    UIPickerView *picker;
    NSMutableArray *seguros;
    
}

@property (weak, nonatomic) IBOutlet UITextField *seguro1;

@property (weak, nonatomic) IBOutlet UITextField *seguro2;

@property (weak, nonatomic) IBOutlet UITextField *seguro3;

@property (weak, nonatomic) IBOutlet UITextField *seguro4;


@end
