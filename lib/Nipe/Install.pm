#!/usr/bin/env perl

package Nipe::Install;

use Nipe::Device;

sub new {
	my $operationalSystem = Nipe::Device -> getSystem();

	system ("sudo mkdir -p /etc/tor");

	if ($operationalSystem eq "debian") {
		system ("sudo apt-get install tor iptables");
		system ("sudo cp .configs/debian-torrc /etc/tor/torrc");
	}
	
	elsif ($operationalSystem eq "fedora") {
		system ("sudo dnf install tor iptables");
		system ("sudo cp .configs/fedora-torrc /etc/tor/torrc");
	}

	elsif ($operationalSystem eq "centos") {
		system ("sudo yum install epel-release tor iptables");
		system ("sudo cp .configs/centos-torrc /etc/tor/torrc");
	}

	else {
		system ("sudo pacman -S tor iptables");
		system ("sudo cp .configs/arch-torrc /etc/tor/torrc");
	}

	system ("sudo chmod 644 /etc/tor/torrc");

	if (-e "/etc/init.d/tor") {
		system ("sudo /etc/init.d/tor stop > /dev/null");
	}

	else {
		system ("sudo systemctl stop tor");
	}

	return true;
}

1;