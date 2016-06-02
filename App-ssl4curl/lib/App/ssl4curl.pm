package App::ssl4curl;

use warnings;
use strict;

use Cwd;
use Config;
use open qw<:encoding(UTF-8)>;

BEGIN {
    require Exporter;
    our $VERSION = 1.0;
    our @ISA = qw(Exporter);
    our @EXPORT_OK = qw( get_ca install_ca );
}


my( %option, $mozilla_ca_path, $mk_ca_bundle_script ) = ();
my $CURL_CA_BUNDLE = '';

# setup cpan
$ENV{PERL_MM_USE_DEFAULT}=1;

#sub install_ca {
    my $install_ca = sub {
# use cpan to install Mozilla::CA
        system("perl -MCPAN -e 'install Mozilla::CA'");
    };
#}

sub get_ca {
    #my $option = shift;
    my $get_ca = sub {
# find Mozilla::CA installed path 
        open my $pipe,"-|", 'perldoc -l Mozilla::CA';
        while(<$pipe>){ $mozilla_ca_path = $_ }
        close $pipe;

# find path to mk-ca-bundle.pl
        $mk_ca_bundle_script = $mozilla_ca_path;
        $mk_ca_bundle_script =~ s/(.*)(\/CA\.pm)/$1/;
        $mk_ca_bundle_script = $1;
        $mk_ca_bundle_script = "$mk_ca_bundle_script" . '/' . 'mk-ca-bundle.pl';

# execute mk-ca-bundle.pl to download certificates
        open $pipe,"-|", "$mk_ca_bundle_script 2>&1";
        close $pipe;

# find path to created cacert.pem
        my $cwd = getcwd();
        chomp $mozilla_ca_path;
        $mozilla_ca_path =~ s/(.*)(\.pm)/$1/;
# make export string
        $CURL_CA_BUNDLE = $mozilla_ca_path . '/' . 'cacert.pem';
    };
    return $CURL_CA_BUNDLE unless $get_ca->();
}


=head1 NAME 

=over 12

=item ssl4curl

=back

=head1 SYNOPSIS

=over 12

=item Download and setup Mozilla certificates for curl SSL/TLS

=item aka fix for error bellow

curl: (60) SSL certificate problem: unable to get local issuer certificate

=back

=head1 INSTALLATION

=over 12

=item clone repository

git clone https://github.com/z448/ssl4curl

=item initialize from command line as root or use sudo

sudo ssl4curl -i

=back 

=head1 USAGE

=over 12 

- add to ~/.bashrc to check/download and setup certificates on start of every session

C<export `ssl4curl -p`>

- execute on command line to check/download certificates and list export string. You can add output string into your ~/.bashrc in which case certificate setup will be skiped on start of session.

C<ssl4curl>

- print this pod

C<ssl4curl -h>

=back

=cut





