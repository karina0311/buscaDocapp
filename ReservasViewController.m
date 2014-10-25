//
//  ReservasViewController.m
//  buscaDocapp
//
//  Created by inf227al on 21/10/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import "ReservasViewController.h"

@interface ReservasViewController ()

@end

@implementation ReservasViewController

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
    self.iconCita.layer.cornerRadius = self.iconCita.frame.size.width / 2;
    self.lblNombreDoctor.text= [NSString stringWithFormat:@"Dr. %@ %@ ", self.name, self.lastname];
    self.lblEspecialidad.text= self.nombreespecialidad;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss-zz:zz"];
    
    NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
    [dateFormat3 setDateFormat:@"HH:mm"];
    
    //NSDate *fecha = [dateFormat dateFromString:Date];
    
    NSDate *date = [dateFormat dateFromString:self.horainicio];
    NSTimeInterval secondsInEightHours = 29 * 60 * 60;
    NSDate *dateEightHoursAhead = [date dateByAddingTimeInterval:secondsInEightHours];
    
    
    
    NSString *horai = [dateFormat3 stringFromDate:dateEightHoursAhead];

    
    
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
