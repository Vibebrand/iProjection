//
//  ControladorVentanaPrincipal.m
//  projectionExample


#import "ControladorVentanaPrincipal.h"
#import "CC3OpenGLES11Engine.h"

#import "projectionExampleLayer.h"
#import "projectionExampleWorld.h"

@implementation ControladorVentanaPrincipal
@synthesize director;

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
    
    CC3Layer* cc3Layer = [projectionExampleLayer node];
	
    [cc3Layer scheduleUpdate];
	
    cc3Layer.cc3World = [projectionExampleWorld  world];
    
	ControllableCCLayer* mainLayer = cc3Layer;
    
    CCScene *scene = [CCScene node];
    
    [scene addChild: mainLayer];
    
    [[self director] runWithScene:scene];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
