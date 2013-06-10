package BigIP::iControl::LocalLB::VirtualServer;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub get_list {
	my( $self ) = shift;
	return $self->{_icontrol}->_request( module => 'LocalLB', interface => 'VirtualServer', method => 'get_list'); 
}
