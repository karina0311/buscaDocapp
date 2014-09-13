//
//  EspecialidadTableViewController.h
//  buscaDocapp
//
//  Created by Nancy Ramirez on 22/08/14.
//  Copyright (c) 2014 tesis2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EspecialidadTableViewController : UITableViewController <UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *searchResult;

@end
