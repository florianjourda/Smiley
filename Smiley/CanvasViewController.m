//
//  CanvasViewController.m
//  Smiley
//
//  Created by Florian Jourda on 2/25/15.
//  Copyright (c) 2015 Box. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (nonatomic, assign) CGPoint trayOriginalCenter;
@property (nonatomic, assign) CGPoint trayViewCenterOpen;
@property (nonatomic, assign) CGPoint trayViewCenterClose;
@property (nonatomic, assign) CGPoint newlyCreatedFaceOriginalCenter;
@property (nonatomic, strong) UIImageView *newlyCreatedFace;

@end

@implementation CanvasViewController

- (IBAction)onSmileyPanGesture:(UIPanGestureRecognizer *)sender {




    CGPoint point = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];


    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
        UIImageView *imageView = (UIImageView*) sender.view;
        self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];

        [self.view addSubview:self.newlyCreatedFace];

        self.newlyCreatedFace.center = imageView.center;

        self.newlyCreatedFace.center = CGPointMake(self.newlyCreatedFace.center.x, self.newlyCreatedFace.center.y + self.trayView.frame.origin.y);

        self.newlyCreatedFaceOriginalCenter = self.newlyCreatedFace.center;

        UIPanGestureRecognizer* panForNewImage = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanForImage)];

        [self.newlyCreatedFace addGestureRecognizer:panForNewImage];

    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(point));
        self.newlyCreatedFace.center = CGPointMake(self.newlyCreatedFaceOriginalCenter.x + point.x, self.newlyCreatedFaceOriginalCenter.y + point.y);



    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(point));

        [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
            if (velocity.y > 0) {
                self.trayView.center = self.trayViewCenterClose;
            } else {
                self.trayView.center = self.trayViewCenterOpen;
            }
        } completion:^(BOOL finished) {

        }];
    }

}


- (IBAction)onPanForImage:(UIPanGestureRecognizer *)sender {
//    CGPoint point = [sender translationInView:self.view];
//    CGPoint velocity = [sender velocityInView:self.view];
//
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
//        self.trayOriginalCenter = self.trayView.center;
//    } else if (sender.state == UIGestureRecognizerStateChanged) {
//        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(point));
//        self.trayView.center = CGPointMake(self.trayOriginalCenter.x, MAX(self.trayOriginalCenter.y + point.y, self.trayViewCenterOpen.y));
//    } else if (sender.state == UIGestureRecognizerStateEnded) {
//        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(point));
//
//        [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
//            if (velocity.y > 0) {
//                self.trayView.center = self.trayViewCenterClose;
//            } else {
//                self.trayView.center = self.trayViewCenterOpen;
//            }
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
}


- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];



    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
        self.trayOriginalCenter = self.trayView.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(point));
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x, MAX(self.trayOriginalCenter.y + point.y, self.trayViewCenterOpen.y));
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(point));

        [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
            if (velocity.y > 0) {
                self.trayView.center = self.trayViewCenterClose;
            } else {
                self.trayView.center = self.trayViewCenterOpen;
            }
        } completion:^(BOOL finished) {

        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.trayViewCenterOpen = self.trayView.center;
    self.trayViewCenterClose = CGPointMake(self.trayViewCenterOpen.x, self.trayViewCenterOpen.y + self.trayView.frame.size.height - 32);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
