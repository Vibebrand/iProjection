//
//  ControladorVentanaPrincipal.m
//  projectionExample


#import "ControladorVentanaPrincipal.h"
#import "CC3OpenGLES11Engine.h"

#import "projectionExampleLayer.h"
#import "Mundo3D.h"
#import "QuadCurveMenu.h"
#import "QuadCurveMenuItem.h"

@implementation ControladorVentanaPrincipal

@synthesize representacionModelos3ds;
@synthesize tablaDatos;
@synthesize director;

@synthesize delegadoNavegacion;

@synthesize celdaModelo3D;
@synthesize cellNib = _cellNib;

-(void)dealloc
{
    self.representacionModelos3ds = nil;
    self.tablaDatos = nil;
    self.celdaModelo3D= nil;
    
    [_cellNib release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.cellNib = [UINib nibWithNibName:@"CeldaModelo3D" bundle:nil];
    self.director = [CCDirector sharedDirector];
    
    _glView = [CC3EAGLView viewWithFrame: [[self view] bounds] 
                             pixelFormat: kEAGLColorFormatRGBA8
                             depthFormat: GL_DEPTH_COMPONENT16_OES
                      preserveBackbuffer: NO
                              sharegroup: nil
                           multiSampling: NO
                         numberOfSamples: 4];
    
	[_glView setMultipleTouchEnabled: YES];
    
    _glView.backgroundColor = [UIColor clearColor];
    _glView.opaque = YES;
    [CC3OpenGLES11Engine engine].state.clearColor.value= kCCC4FBlackTransparent;
    
	[self.director setOpenGLView:_glView];
    
    [[self view] insertSubview:_glView atIndex:0];
    
    [self setupMenu];
    
    CC3Layer* cc3Layer = [projectionExampleLayer node];
	
    [cc3Layer scheduleUpdate];
	
    cc3Layer.cc3World = [Mundo3D  world];
    
    //Inyeccion
    Mundo3D *mundo3D = (Mundo3D*)cc3Layer.cc3World; 
    [self setDelegadoNavegacion:mundo3D];
    [mundo3D setDelegadoReresentacionNavegacion:self];
    
	ControllableCCLayer* mainLayer = cc3Layer;
    
    CCScene *scene = [CCScene node];
    
    [scene addChild: mainLayer];
    
    [[self director] runWithScene:scene];
}

-(void)setupMenu
{
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    QuadCurveMenuItem *starMenuItem1 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem2 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem3 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage 
                                                        highlightedContentImage:nil];
    QuadCurveMenuItem *starMenuItem4 = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed 
                                                                   ContentImage:starImage 
                                                        highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    [starMenuItem1 release];
    [starMenuItem2 release];
    [starMenuItem3 release];
    [starMenuItem4 release];

    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds menus:menus];
    //menu.startPoint = CGPointMake(20.0, 284.0);
    menu.rotateAngle = 0.0;//M_PI/3;
	menu.menuWholeAngle =2.0;//M_PI *2;  //M_PI;
	menu.timeOffset = 0.2f;
	menu.farRadius = 180.0f;
	menu.endRadius = 100.0f;
    menu.nearRadius = 50.0f;
    [[self view] insertSubview:menu atIndex:1];
    
    
    [menu release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark Table view datasource methods


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if(self.representacionModelos3ds)
        return [self.representacionModelos3ds count];
    return  0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identificador = @"Entidades3D";
    CeldaModelo3D *celda;
    celda = (CeldaModelo3D *)[tableView dequeueReusableCellWithIdentifier:identificador];
    
    if (celda == nil) {
        [self.cellNib  instantiateWithOwner:self options:nil];
        celda = [self celdaModelo3D];
        self.celdaModelo3D = nil;
    }
    
    if(self.representacionModelos3ds)
    {
        UIImage *representacionModelo3D = [self.representacionModelos3ds  objectAtIndex: [indexPath row] ];
        [[celda imagen] setImage:representacionModelo3D];
    }
    return celda;
}

#pragma mark -
#pragma mark Table view delegate methods

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"";
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[self delegadoNavegacion] mostrarModelo3DenPosicion:indexPath.row];        
}

#pragma mark iDelegadoRepresentacionNavegacion

-(void)actualizarBarraNevegacion:(NSArray*)representacionModelos3D
{
    [self setRepresentacionModelos3ds:representacionModelos3D];
    [[self tablaDatos] reloadData];
}

@end
