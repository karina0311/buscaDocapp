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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
