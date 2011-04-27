//
//  MapViewController.h
//  CodeStock
//
//  Created by Brice Wilson on 4/24/11.
//  Copyright 2011 Brice Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class MKMapView;
@class Location;


@interface MapViewController : UIViewController <MKMapViewDelegate>
{
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSArray *allLocations;
@property (nonatomic, retain) Location *centerLocation;


@end
