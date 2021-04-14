//
//  ViewController.m
//  TestObjCTeam
//
//  Created by Marcela Rodriguez on 4/12/21.
//

#import "ViewController.h"
#import <HomeTurf/HomeTurf.h>
#import <TestObjCTeam-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)enterHomeTurf {
    HomeTurfWebViewController *webVC = [[HomeTurfWebViewController alloc] init];
    TeamHomeTurfAuth0Service *auth0Service = [[TeamHomeTurfAuth0Service alloc] init];
    [webVC setAuth0ServiceWithAuth0Service:auth0Service];
    [[self navigationController] pushViewController:webVC animated:NO];
}

@end
