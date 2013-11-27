package BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence;

use strict;
use warnings;

our $VERSION    = '0.01';
our @ACCESSORS  = qw(profile_name default_profile);

{ no strict 'refs';
        foreach my $attr ( @ACCESSORS ) { 
                *{ __PACKAGE__ ."::$attr" } = sub { return $_[0]->{ $attr } } 
        }   
}

sub new {
	my( $class, $args ) = @_;
	my $self = bless {}, $class;
	$self->{profile_name} = $args->[0]->{profile_name};
	$self->{default_profile} = $args->[0]->{default_profile};
	return $self;
}


1;

__END__
