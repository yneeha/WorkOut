//
//  CSEMapViewController.h
//  LocationNavigation

//  Created by Arpit Sharma on 30/11/14.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CSEMapViewController : UIViewController<MKMapViewDelegate,MKOverlay, CLLocationManagerDelegate>

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(void) processAddress:(NSString *)address;
-(void) setAnnotationAtLat:(float)lat andLon:(float)lon withTitle:(NSString *)locTitle andSubTitle:(NSString *)locSubTitle;

@end
