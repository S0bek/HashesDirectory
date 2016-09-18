#!/usr/bin/perl -w

use strict;

#EXEMPLE 1

my $ref = { 'test' => "reussite"};
my %h = ( 'linus' => 12 , 'toto' => "coucou");

my %test = %{$ref};
print "$test{'test'}\n";#1ere methode: le hash 'test' contient le hash issu du dereferencement de $ref (qui est une reference de hash) avec ses propres valeurs. On peut donc afficher directement la valeur du hash via sa cle.
print "$ref->{'test'}\n";#2eme methode: on affiche directement la valeur contenue dans le hash reference via sa reference avec le caractere '->'


#EXEMPLE 2: STRUCTURES PLUS COMPLEXES
#On va afficher la cle contenue dans un hash, lui meme contenu dans un autre hash:

my $employe1 = { 'id' => "A579358" , 'prenom' => "David" , 'nom' => "Webb" , 'description' => "Jason BOURNE!" };
my $employe2 = {'id' => "XXXXX" , 'prenom' => "Matt" , 'nom' => "DAMON" , 'description' => "acteur du projet TreadStone"};
my %employes = ( 'employe1' => $employe1 , 'employe2' => $employe2);#On met en place un employe dans la liste des employes de la societe

#On va afficher les elements de chacun des employes:
foreach my $k (keys %employes){
	foreach my $k2 (keys %{$employes{$k}}){#Ici on a dereference pour obtenir un hash que l'on parcourt toujours de la meme facon...
		print "Valeur de $k2 donne: $employes{$k}{$k2}\n";#On a toujours une valeur a la fin, donc un scalaire obtenu via les cles parcourues
	}

	foreach my $k3 (keys %{$employes{$k}}) {
		if ($k3 eq "prenom"){
			#On affiche que les prenoms des employes
			print "$employes{$k}{$k3}\n";
		}
	}
}











