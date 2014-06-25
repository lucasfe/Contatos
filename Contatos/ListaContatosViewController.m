//
//  ListaContatosViewController.m
//  Contatos
//
//  Created by ios4357 on 19/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController

-(id)init {
    self = [super init];
    if(self) {
        self.title = @"Contatos";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm:)];
        self.navigationItem.rightBarButtonItem = btn;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.linhaSelecionada = -1;

    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer * gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(exibeMaisAcoes:)];
    [self.tableView addGestureRecognizer:gr];
}


-(void)exibeMaisAcoes:(UILongPressGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint ponto = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:ponto];
        contatoSelecionado = self.contatos[indexPath.row];
        
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:contatoSelecionado.nome delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Ligar", @"Email", @"Mostrar mapa", @"Abrir site", nil];
        [actionSheet showInView:self.view];
        
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self ligar];
            break;
        case 1:
            [self enviarEmail];
            break;
        case 2:
            [self mostrarMapa];
            break;
        case 3:
            [self abrirSite];
            break;
        default:
            break;
    }
    
}


-(void) ligar {
    UIDevice * device = [UIDevice currentDevice];
    if ([device.model isEqualToString:@"iPhone"]) {
        NSString * urlStr = [NSString stringWithFormat:@"tel: %@", contatoSelecionado.telefone];
        [self abrirAplicativoComURL:urlStr];
    }
    else {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Pobre!" message:@"Compre um iPhone" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [av show];
    }
}

-(void) mostrarMapa {
    NSString * urlString = [[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", contatoSelecionado.endereco] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self abrirAplicativoComURL:urlString];
}

-(void) abrirSite {
    [self abrirAplicativoComURL:contatoSelecionado.site];
}



#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

-(void) enviarEmail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * mail = [[MFMailComposeViewController alloc] init];
        [mail setToRecipients:@[contatoSelecionado.email]];
        [mail setSubject:@"Teste"];
        mail.mailComposeDelegate = self;
        [self presentViewController:mail animated:YES completion:nil];
    }
    else {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Email Error!" message:@"Sem conta configurada" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [av show];

    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)abrirAplicativoComURL:(NSString *) urlStr {
    NSURL * url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)exibeForm:(id)sender {

    FormularioContatoViewController* form = [[FormularioContatoViewController alloc] init];
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
    //[self presentViewController:form animated:YES completion:nil];

}

-(void)contatoAdicionado:(Contato *)contato {
    [self.contatos addObject:contato];
    self.linhaSelecionada = [self.contatos indexOfObject:contato];
}

-(void)contatoAlterado:(Contato *)contato {
    NSLog(@"Contato alterado: %@", contato);
    self.linhaSelecionada = [self.contatos indexOfObject:contato];

}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.contatos count];
}

-(UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pool = @"pool";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:pool];
    }
    
    Contato* contato = self.contatos[indexPath.row];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.email;
    
    return cell;
}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Contato* contato = self.contatos[indexPath.row];
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato:contato];
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
    
    NSLog(@"Contato selecionado: %@", contato.nome);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.linhaSelecionada > -1) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.linhaSelecionada inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
        self.linhaSelecionada = -1;
    }
}

@end
