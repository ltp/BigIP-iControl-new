package BigIP::iControl::Common::OperationFailed;

use strict;
use warnings;

our $VERSION = '0.01';

sub new {
	my ( $class, %args ) = @_;
	my $self = bless {}, $class;
	$self->{ primary_error_code } = $args{ primary_error_code };
	$self->{ secondary_error_code } = $args{ secondary_error_code };
	$self->{ error_string } = $args{ error_string };
	return $self
}

sub primary_error_code {
	print $_[0]->{ primary_error_code };
}

sub secondary_error_code {
	print $_[0]->{ secondary_error_code };
}

sub error_string {
	print $_[0]->{ error_string };
}

1;
