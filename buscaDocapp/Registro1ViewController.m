//
//  Registro1ViewController.m
//  buscaDocapp
//
//  Created by Nancy Ramirez on 8/09/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "Registro1ViewController.h"

@interface Registro1ViewController ()

@end

@implementation Registro1ViewController

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
    // Do any additional setup after loading the view.
    
    //self.botoncito.layercornerRadius = self.botoncito.frame.size.width / 2;
    
    self.botoncito.clipsToBounds = YES;
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
