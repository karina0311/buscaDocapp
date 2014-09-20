//
//  PerfilDocViewController.m
//  buscaDocapp
//
//  Created by inf227al on 19-09-14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "PerfilDocViewController.h"

@interface PerfilDocViewController ()

@end

@implementation PerfilDocViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iconDoctor.layer.cornerRadius = self.iconDoctor.frame.size.width / 2;
    self.iconDoctor.clipsToBounds = YES;
    
    self.lblNombre.text=[NSString stringWithFormat:@"Dr. %@ %@ ", self.name, self.lastname];
    //KARIMON :D
    self.lblEspecialidad.text=self.nombreespecialidad;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
