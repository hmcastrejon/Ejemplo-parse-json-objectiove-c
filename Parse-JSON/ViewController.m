//
//  ViewController.m
//  Parse-JSON
//
//  Created by MacBook P on 13/04/13.
//  Copyright (c) 2013 MobileStudio. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
#import "Continente.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize arregloContinentes;

- (void)viewDidLoad
{
    self.arregloContinentes = [[NSMutableArray alloc] init];
    
    [NSThread detachNewThreadSelector:@selector(parserJSON) toTarget:self withObject:nil];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)parserJSON
{
    NSString *ruta = [[NSBundle mainBundle] pathForResource:@"continentes" ofType:@"json"];
    
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:ruta];
    
    NSLog(@"Data %d", [JSONData length]);
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoder];
    NSDictionary *resultadoJson = [jsonKitDecoder objectWithData:JSONData];
    
    NSDictionary *continentesDic = [resultadoJson objectForKey:@"continentes"];
    
    NSDictionary *continenteDic = [continentesDic objectForKey:@"continente"];
    
    for (id item in continenteDic)
    {
        static NSString *kID = @"id";
        static NSString *kNombre = @"text";
        
        NSDictionary *continenteNuevoDic = (NSDictionary *)item;
        
        Continente *continente = [[Continente alloc] init];
        
        continente.StrID = [continenteNuevoDic objectForKey:kID];
        continente.StrName = [continenteNuevoDic objectForKey:kNombre];
        
        [self.arregloContinentes addObject:continente];
        
    }
    
    NSLog(@"cuenta json %d", [self.arregloContinentes count]);
    
    [self.mainTable reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arregloContinentes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"idCell";
    UITableViewCell *celda = [tableView dequeueReusableCellWithIdentifier:idCell];
    
    if (!celda)
    {
        celda = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idCell];
    }
    
    int fila = indexPath.row;
    Continente *continente = (Continente *)[self.arregloContinentes objectAtIndex:fila];
    
    celda.textLabel.text = continente.StrName;
    
    return celda;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Continente *continente = (Continente *)[self.arregloContinentes objectAtIndex:indexPath.row];
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"ParseJON" message:[NSString stringWithFormat:@"IdContinente %@", continente.StrID] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alerta show];
    [alerta release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
