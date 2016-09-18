#!/usr/bin/perl -w

use strict;

#On va afficher des valeurs comme s'il s'agissait de donnees d'un serveur OpenLDAP
#On aura une liste de netgroups qui contiendront des groupes avec leurs attributs et des hosts avec leurs attributs

my %netgroups;
my %hosts;
my %groups;

#On peut utiliser les references de hash comme des objets contenant des donnees stockees dans leurs attributs
my $host = {'cn' => 'zeq330mz' , 'ou' => "dc=erdfdistribution,dc=fr" , 'description' => "Serveur de qualif"};
my $group = {'cn' => "sip" , 'description' => "Groupe permettant d\'utiliser les commandes root"};

#On lie le serveur au groupe via le netgroup en question
my $netgroup = {'cn' => "_sip" , 'description' => "Lien de rattachement du groupe sip au serveur zeq330mz" , 'group' => $group , 'host' => $host};

#On rajoute dans la liste des netgroups, le netgroup permettant de lier le groupe sip a la machine zeq330mz:
%netgroups = ('netgroup1' => $netgroup);#on pourra en rajouter d'autres par la suite, la logique reste la meme

#On affiche ensuite toutes le nom du serveur et le nom du groupe contenus dans le netgroup, contenu dans la liste des netgroups:


my ($hostcn , $groupcn);
my @hostinfo;

foreach my $netgrp (keys %netgroups){
	foreach my $attr (keys %{$netgroups{$netgrp}}){
		#On extrait le groupe associe
		if ($attr eq "group"){
			$groupcn = $netgroups{$netgrp}{$attr}->{'cn'};

			#Cette alternative marche aussi:
			#my %grp = %{$netgroups{$netgrp}{$attr}};
			#$groupcn = $grp{'cn'};
		}

		#On extrait le serveur associe
		if ($attr eq "host"){
			$hostcn = $netgroups{$netgrp}{$attr}->{'cn'};
			#On peut aussi aller recuperer les autres donnes via un slice:
			@hostinfo = ($netgroups{$netgrp}{$attr}->{'ou'},$netgroups{$netgrp}{$attr}->{'description'});
			#$hostdesc = $netgroups{$netgrp}{$attr}->{'description'};
		}
	}
}

print "Le nom du groupe recherche: $groupcn\n";

print "Informations sur  serveur recherche:\nNom: $hostcn\nou: $hostinfo[0]\ndescription: $hostinfo[1]\n";
