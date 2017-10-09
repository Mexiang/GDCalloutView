//
//  ViewController.m
//  GDMapCllout
//
//  Created by Dry on 2017/6/14.
//  Copyright © 2017年 Dry. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "DDCustomAnnotationView.h"

#import "DDPointAnnotaion.h"

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) DDPointAnnotaion *startAnnotation;
@property (nonatomic, strong) DDPointAnnotaion *endAnnotation;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //注意：在AppDelegate里面添加AppKey
    
    
    //初始化大头针信息
    [self initAnnotaiton];

    //初始化地图并添加
    [self setUpMapView];
    
    //将大头针添加到地图上
    [self.mapView addAnnotations:@[self.startAnnotation,self.endAnnotation]];
    
//    //调用此方法直接显示出大头针气泡，调用此方法会执行大头针的点击代理
//    [_mapView selectAnnotation:self.startAnnotation animated:YES];
//    [_mapView selectAnnotation:self.endAnnotation animated:NO];
    
    //地图移动，缩放
    MACoordinateRegion region ;//表示范围的结构体
    region.center = self.startAnnotation.coordinate;//中心点
    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.1;//纬度范围
    [_mapView setRegion:region animated:YES];
}

- (void)initAnnotaiton {
    _startAnnotation = [[DDPointAnnotaion alloc]init];
    _startAnnotation.coordinate = CLLocationCoordinate2DMake(39.90841537, 116.45969689);
    _startAnnotation.title = @"国贸";
    _startAnnotation.number = @"1";
    
    _endAnnotation = [[DDPointAnnotaion alloc]init];
    _endAnnotation.coordinate = CLLocationCoordinate2DMake(39.92000603, 116.39465332);
    _endAnnotation.title = @"故宫";
    _endAnnotation.number = @"2";
}

- (void)setUpMapView {
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.showsScale = NO;
    _mapView.showsCompass = NO;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}


#pragma mark MAMapViewDelegate
//添加大头针代理
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[DDPointAnnotaion class]])
    {
        static NSString *resuedIndentifier = @"DDMAPointAnnotationId";
        
        DDCustomAnnotationView *annotationView = (DDCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:resuedIndentifier];
        
        if (annotationView == nil) {
            annotationView = [[DDCustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:resuedIndentifier];
        }
        
        if (annotation == self.startAnnotation) {
            UIImage *image = [UIImage imageNamed:@"startgreen"];
            annotationView.image = image;
            annotationView.centerOffset = CGPointMake(0, -0.5*image.size.height);
        }

        if (annotation == self.endAnnotation) {
            UIImage *image = [UIImage imageNamed:@"endred"];
            annotationView.image = image;
            annotationView.centerOffset = CGPointMake(0, -0.5*image.size.height);
        }
        
        
        DDPointAnnotaion *ddAnnotation = (DDPointAnnotaion *)annotation;
        
        NSLog(@"********* %@ %@",ddAnnotation.title,ddAnnotation.number);
        
        annotationView.calloutView.textLabel.text = ddAnnotation.title;
        annotationView.calloutView.leftNumLabel.text = ddAnnotation.number;

        return annotationView;
    }
    
    return nil;
}

////大头针点击代理
//- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//    
//    DDCustomAnnotationView *annotationView = (DDCustomAnnotationView *)view;
//    
//    annotationView.calloutView.textLabel.text = view.annotation.title;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
