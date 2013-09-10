//
//  TCPlacesService.m
//  TCGoogleMaps
//
//  Created by Lee Tze Cheun on 9/3/13.
//  Copyright (c) 2013 Lee Tze Cheun. All rights reserved.
//

#import "TCPlacesService.h"
#import "TCPlacesServicePrivate.h"
#import "TCPlacesAutocompleteService.h"
#import "TCGoogleMapsAPIClient.h"

@interface TCPlacesService ()

/**
 * The API key parameter used for all Google Places API requests.
 */
@property (nonatomic, copy) NSString *APIKey;

/**
 * The sensor parameter used for all Google Places API requests.
 */
@property (nonatomic, assign) BOOL sensor;

/**
 * The service object to access Google Places Autocomplete API.
 */
@property (nonatomic, strong, readonly) TCPlacesAutocompleteService *autocompleteService;

@end

@implementation TCPlacesService

@synthesize autocompleteService = _autocompleteService;

+ (TCPlacesService *)sharedService
{
    static TCPlacesService *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[TCPlacesService alloc] init];
    });    
    return _sharedService;
}

+ (void)setAPIKey:(NSString *)APIKey sensor:(BOOL)sensor
{
    TCPlacesService *sharedService = [[self class] sharedService];
    sharedService.APIKey = APIKey;
    sharedService.sensor = sensor;
}

- (TCGoogleMapsAPIClient *)APIClient
{
    // Use the default shared API client, if no custom API client is given.
    return _APIClient ?: [TCGoogleMapsAPIClient sharedClient];
}

#pragma mark - Places Autocomplete Service

- (TCPlacesAutocompleteService *)autocompleteService
{
    if (!_autocompleteService) {
        _autocompleteService = [[TCPlacesAutocompleteService alloc] initWithAPIClient:self.APIClient key:self.APIKey sensor:self.sensor];
    }
    return _autocompleteService;
}

- (void)placePredictionsWithParameters:(TCPlacesAutocompleteParameters *)parameters completion:(TCPlacesAutocompleteServiceCallback)completion
{
    NSAssert([self.APIKey length] > 0,
             @"You must provide the API key to use Google Places service. "
             "Call setAPIKey:sensor: to provide the required API key and sensor parameters.");

    [self.autocompleteService placePredictionsWithParameters:parameters completion:completion];
}

#pragma mark - Place Details Service

- (void)placeDetailsWithReference:(NSString *)reference completion:(TCPlaceDetailsServiceCallback)completion
{
    NSAssert([self.APIKey length] > 0,
             @"You must provide the API key to use Google Places service. "
             "Call setAPIKey:sensor: to provide the required API key and sensor parameters.");
    
}

@end
