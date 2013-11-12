package BigIP::iControl::LocalLB::Rule;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	$self->{ name } = $args{name};
	$self->{ _args } = \%args;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub _create {
	my $self = new( @_ );

	my $res = $self->{_icontrol}->_request(
				module		=> 'LocalLB',
				interface	=> 'Rule',
				method		=> 'create',
				data		=> { rules => [{
								rule_name 	=> $self->{name}, 
								rule_definition => $self->{definition}
								}] 
						   }
						);

	return ( (ref $res) eq 'HASH' and defined $res->{_has_fault} )
		? do { warn $res->{faultstring}; undef }
		: 1 ;
}

sub name {
	my $self = shift;
	$self->{name} or return;
	return @{ $self->{_icontrol}->_request(module	=> 'LocalLB',
					      interface	=> 'Rule',
					      method	=> 'query_rule',
					      data	=> { rule_names => [ $self->{name} ] }
					)
		}[0]->{rule_name};
}

sub definition {
	my $self = shift;
	$self->{name} or return;

	my $rule = 
		$self->{_icontrol}->_request(module	=> 'LocalLB',
					      interface	=> 'Rule',
					      method	=> 'query_rule',
					      data	=> { rule_names => [ $self->{name} ] }
					);

	return ( (ref $rule) eq 'HASH' and defined $rule->{_has_fault} )
			? do { warn $rule->{faultstring}; undef }
			: $rule->[0]->{rule_definition} ;
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Rule - Class for operations with the LocalLB domain Rules module of BigIP devices.

=head1 DESCRIPTION

This module provides an interface to the LocalLB (LTM) Rule module of a BigIP device.

=head1 METHODS

=head3 name

	print $icontrol->ltm->rule( 'Force_SSL' )->name;
	# Prints, surprisingly enough, 'Force_SSL' which is the name of the Rule

Returns a scalar containing the the name of the iRule - this method may initially seem redundant 
but is useful when retrieving iRule for processing as an array of objects.

=head3 definition

Returns the Rule definition as a scalar containing free-form text including line breaks.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Rule


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Rule>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Rule>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Rule>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Rule/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
