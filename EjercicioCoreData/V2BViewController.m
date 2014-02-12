//
//  V2BViewController.m
//  EjercicioCoreData
//
//  Created by LLBER on 12/02/14.
//  Copyright (c) 2014 video2brain. All rights reserved.
//

#import "V2BViewController.h"
#import "V2BAppDelegate.h"


@interface V2BViewController () {
    
    V2BAppDelegate * privadoAppDelegate; // Nos creamos un objecto AppDelegate. Ponemos un prefijo delante para diferenciar los objetos privados de los públicos, por convención
}

@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *apellidos;
@property (weak, nonatomic) IBOutlet UITextField *telefono;

@property (weak, nonatomic) IBOutlet UILabel *estado;

- (IBAction)guardar:(id)sender;
- (IBAction)borrar:(id)sender;
- (IBAction)buscar:(id)sender;

@end

@implementation V2BViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    privadoAppDelegate = (V2BAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (IBAction)guardar:(id)sender {
    
    // Iniciamos el contexto. Lo usamos como singleton
    NSManagedObjectContext *contexto = [privadoAppDelegate managedObjectContext]; // Recibe toda nuestra información
    
    
    // Llamamos a nuestra entidad que hemos llamado contacto
    NSManagedObject * nuevoContacto = [NSEntityDescription insertNewObjectForEntityForName:@"Contacto" inManagedObjectContext:contexto];
    // Le estamos diciendo que dentro de nuestro contexto hay una entidad que se llama contacto ¿Para qué? para crear un nuevo contacto
    
    /*  NSManagedObject es una clase genérica que implementa todo el comportamiento básico requerido de un objeto de Core Data Model. No es posible utilizar las instancias de subclases directas de NSObject (o cualquier otra clase que no herede del NSManagedObject) con un Managed Object Context. Podemos crear subclases personalizadas de NSManagedObject, aunque esto no siempre es necesario. Si no se necesita una lógica personalizada, un gráfico de objetos completo se puede formar con NSManagedObject */
    
    // Añadimos la información al nuevoContacto. De la misma manera a como lo hacemos con un diccionario
    [nuevoContacto setValue:self.nombre.text forKey:@"nombre"];
    [nuevoContacto setValue:self.apellidos.text forKey:@"apellidos"];
    [nuevoContacto setValue:self.telefono.text forKey:@"telefono"];
    
    
    self.nombre.text = @"";
    self.apellidos.text = @"";
    self.telefono.text = @"";
    
    
//    self.estado.text = @"Contacto añadido";
//    [self.nombre becomeFirstResponder];
    
    
    // En el ApplicationWillTerminate del AppDelegate tenemos el  - [self saveContext]; - Para que nos funcione en el simulador podemos añadir aquí lo siguiente:
    
    NSError * error;
    [contexto save:&error];
    if (error == nil) {
        self.estado.text = @"Contacto añadido";
        [self.nombre becomeFirstResponder];
    }
     
     // Si fuese en el teléfono no hay problema y no lo tenemos que escribir
    
}

- (IBAction)buscar:(id)sender {
    
    NSManagedObjectContext *contexto = [privadoAppDelegate managedObjectContext];
    
    // Cogemos el contenido de la entidad. Del contexto
    NSEntityDescription * contenidoEntidad = [NSEntityDescription entityForName:@"Contacto" inManagedObjectContext:contexto];
    
    // Inicializamos la consulta y hacemos la pregunta al contenido de nuestra entidad
    NSFetchRequest * consulta = [[NSFetchRequest alloc]init];
    [consulta setEntity:contenidoEntidad];
    
    // Comparamos el texto, en base a una condición, de la consulta con nuestros elementos de la entidad
    NSPredicate * condicion = [NSPredicate predicateWithFormat:@"nombre = %@", self.nombre.text];
    [consulta setPredicate:condicion];
    
    NSError * error;
    
    // Guardamos la respuesta a la consulta en un array
    NSArray * resultadoArray = [contexto executeFetchRequest:consulta error:&error];
    
    // Si no hay ninguno encontrado le devuelvo "contacto no encontrado" y borro el texfield
    if ([resultadoArray count] == 0) {
        self.estado.text = @"Contacto no encontrado";
        self.nombre.text = @"";
    } else {
        // Y en caso de encontrar algún elemento coincidente con nuestra entidad nos los va devolviendo en orden por el índice
        NSManagedObject * contacto = [resultadoArray objectAtIndex:0];
        
        // Y rellenamos el resto de los texfields con el resultado según la key (la clave)
        self.apellidos.text = [contacto valueForKey:@"apellidos"];
        self.telefono.text = [contacto valueForKey:@"telefono"];
        self.estado.text = [NSString stringWithFormat:@"%d contactos encontrados", [resultadoArray count]];
    }
}

- (IBAction)borrar:(id)sender {
    
    // Podemos copiar desde aquí
    NSManagedObjectContext *contexto = [privadoAppDelegate managedObjectContext];
    
    NSEntityDescription *contenidoEntidad = [NSEntityDescription entityForName:@"Contacto" inManagedObjectContext:contexto];
    
    NSFetchRequest *consulta = [[NSFetchRequest alloc] init];
    [consulta setEntity:contenidoEntidad];
    
    NSPredicate *condicion = [NSPredicate predicateWithFormat:@"nombre = %@", self.nombre.text];
    [consulta setPredicate:condicion];
    
    NSError *error;
    NSArray *resultadoArray = [contexto executeFetchRequest:consulta error:&error];
    // Hasta aquí, porque es todo igual
    
    
    [contexto deleteObject:[resultadoArray objectAtIndex:0]];
    
    self.nombre.text = @"";
    self.apellidos.text = @"";
    self.telefono.text = @"";
    self.estado.text = @"Estado";
    
    [contexto save:&error];

    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
