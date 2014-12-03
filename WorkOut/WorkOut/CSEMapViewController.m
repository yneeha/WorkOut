//
//  CSEMapViewController.m
//  LocationNavigation
//

//  Created by Arpit Sharma on 30/11/14.
//

#import "CSEMapViewController.h"

@interface CSEMapViewController ()
{
    BOOL _isRouteMapped;
}
@end

@implementation CSEMapViewController

@synthesize address, location, locationManager, coordinate, boundingMapRect;

- (void)viewDidLoad {
    
    self.title = @"Location";
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self processAddress:self.address];
}


-(void) processAddress:(NSString *)address
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // find the latitude and longitude of our address
    // *** This is Asynchronous ***
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        
        // did our address provide any hits?
        if(placemarks.count >0)
        {
            // what is the first (most likely) location that we found?
            CLPlacemark *placemark = placemarks[0];
            double lat = placemark.location.coordinate.latitude;
            double lon = placemark.location.coordinate.longitude;
            
            // center our map there
            [self centerMapAtLat:lat andLon:lon];
            
            //getting address name and city name
            NSString *addressName = [NSString stringWithFormat:@"%@ %@",[placemark subThoroughfare],[placemark thoroughfare]];
            NSString *city = [NSString stringWithFormat:@"%@",[placemark locality]];
            
            // drop an annotation there
            [self setAnnotationAtLat:lat andLon:lon withTitle:addressName andSubTitle:city];
            
            //current location
            float fromLat = self.locationManager.location.coordinate.latitude;
            float fromLon = self.locationManager.location.coordinate.longitude;
            
            [self getCurrentLocationAddress:self.locationManager.location];
            
            CLLocationCoordinate2D fromCoordinate = CLLocationCoordinate2DMake(fromLat,fromLon);
            
            //change our inputs into MKPlacemarks
            MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithPlacemark:placemark];
            MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate
                                                               addressDictionary:nil];
            //make map items out of the placemarks
            MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
            MKMapItem *toItem   = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
            [self findDirectionsFrom:fromItem
                                  to:toItem];
        }
    }];
    
}

/*!
 *setting region on map
 */
-(void) centerMapAtLat:(float)lat andLon:(float)lon
{
    // when we define a rectangle we need a point and a width/height
    // mapping rectangles use the center point instead of top-left though
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(lat, lon); MKCoordinateSpan span = MKCoordinateSpanMake(.1, .1);
    // transform our rectangle pieces into a real rectangle!
    MKCoordinateRegion visibleRegion = MKCoordinateRegionMake(center, span);
    // tell the map view to move to this new location and animate the movement
    [self.mapView setRegion:visibleRegion animated:YES];
}

/*!
 *Setting annotation to location
 */
-(void) setAnnotationAtLat:(float)lat andLon:(float)lon withTitle:(NSString *)locTitle andSubTitle:(NSString *)locSubTitle
{
    
    CLLocationCoordinate2D center   = CLLocationCoordinate2DMake(lat, lon);
    MKPointAnnotation *annotation   = [[MKPointAnnotation alloc] init];
    annotation.coordinate           = center;
    // set these to custom data, possibly send an additional property
    annotation.title    = locTitle;
    annotation.subtitle = locSubTitle;
    [self.mapView addAnnotation:annotation];
}

/*!
 *Get address of current location and adding annotation to it
 */
- (void)getCurrentLocationAddress:(CLLocation *)loc
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finding address");
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            
            //getting address name and city name
            NSString *addressName = [NSString stringWithFormat:@"%@ %@",[placemark subThoroughfare],[placemark thoroughfare]];
            NSString *city = [NSString stringWithFormat:@"%@",[placemark locality]];
            
            // drop an annotation to current location
            
            float fromLat = self.locationManager.location.coordinate.latitude;
            float fromLon = self.locationManager.location.coordinate.longitude;
            
            [self setAnnotationAtLat:fromLat andLon:fromLon withTitle:addressName andSubTitle:city];
        }
    }];
    
}
- (void)findDirectionsFrom:(MKMapItem *)source
                        to:(MKMapItem *)destination
{
    MKDirectionsRequest *request    = [[MKDirectionsRequest alloc] init];
    request.source                  = source;
    request.destination             = destination;
    request.requestsAlternateRoutes = YES;
    MKDirections *directions        = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         
         if (error) {
             NSLog(@"error:%@", error);
         }
         else {
             MKRoute *route = response.routes[0];
             [self.mapView addOverlay:route.polyline];
             
             
//             //Giving route information
//             NSLog(@"Rout Name : %@",route.name);
//             NSLog(@"Total Distance (in Meters) :%f",route.distance);
//    
//             NSArray *steps = [route steps];
//             
//             NSLog(@"Total Steps : %d",[steps count]);
//             
//             [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                 NSLog(@"Rout Instruction : %@",[obj instructions]);
//                 NSLog(@"Rout Distance : %f",[obj distance]);
//             }];
         }
     }
     ];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.lineWidth = 5.0;
    renderer.strokeColor = [UIColor purpleColor];
    return renderer;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *recentLocation = [locations lastObject];

    //Draw the route when get the current location of device through location manager
    if (!_isRouteMapped)
    {
        _isRouteMapped = true;
        
        [self processAddress:self.address];
    }
    
    NSLog(@"Recent Location : %@", recentLocation);
}

@end
