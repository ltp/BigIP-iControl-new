package BigIP::iControl::LocalLB::SnatType;

use strict;
use warnings;

our $VERSION = '0.01';

our $map = {
	SNAT_TYPE_NONE => {
		value 	=> 0,
		desc	=> 'No snat is being used.' 
	},
	SNAT_TYPE_TRANSLATION_ADDRESS => {
		value	=> 1,
		desc	=> 'The snat uses a single translation address.'
	},
	SNAT_TYPE_SNATPOOL => {
		value	=> 2,
		desc	=> 'The snat uses a SNAT pool of translation addresses.' 
	},
	SNAT_TYPE_AUTOMAP => {
		value	=> 3,
		desc	=> 'The snat uses self IP addresses.'
	}
};

sub new {
	my($class, $args) = @_;
	my $self = bless {}, $class;
	
	return $self
}
