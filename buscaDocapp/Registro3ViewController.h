//
//  Registro3ViewController.h
//  buscaDocapp
//
//  Created by inf227al on 24-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>
@optional

-(void)regresarLogin;
@end

@interface Registro3ViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lblUsuario;
@property (weak, nonatomic) IBOutlet UITextField *lblPassword;
@property (weak, nonatomic) IBOutlet UITextField *lblPalabraSecreta;
@property (nonatomic, weak) id <LoginDelegate> delegate;


@end
