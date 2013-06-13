package BigIP::iControl::LocalLB::Class::Member;

use strict;
use warnings;
use overload ( '""' => \&_stringify );

use Scalar::Util qw(weaken);

sub new {
	my ( $class, $name, $value, $class_name, $type, $icontrol ) = @_;
	my $self		= bless {}, $class;
	$self->{name}		= $name;
	$self->{value}		= $value;
	$self->{class_name}	= $class_name;
	$self->{type}		= $type;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub name { 
	my $self = shift;
	return $self->{name} }

sub value { 
	my ( $self, $value ) = @_;

	return $self->{value} unless $value;
	
	if ( $self->{type} eq 'string' ) {
		$self->{_icontrol}->_request( 
					module		=> 'LocalLB',
					interface	=> 'Class',
					method		=> 'set_string_class_member_data_value',
					data		=> {
							class_members	=> [ 
									     {	name	=> $self->{class_name},
										members	=> [ $self->{name} ] 
									     }
									   ],
							values		=> [
									     [ $value ]
									   ]
							}
					);
		return $self
	}

}

sub _stringify {
	my $self = shift;
	return $self->{ value }
}

1;
