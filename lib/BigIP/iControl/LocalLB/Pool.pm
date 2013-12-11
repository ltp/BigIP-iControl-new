package BigIP::iControl::LocalLB::Pool;

use strict;
use warnings;

use Scalar::Util qw(weaken);

our $VERSION = '0.01';

sub new {
	my( $class, $icontrol, $name, %args ) = @_;
	my $self = bless {}, $class;
	$self->{name} = $name;
	weaken( $self->{_icontrol} = $icontrol );
	return $self
}

sub get_member {
	my ( $self, $pools ) = @_;
	
	my @members = map { BigIP::iControl::Common::IPPortDefinition->new( $self->{_icontrol}, $_ ) }
		@{ @{ $self->{_icontrol}->_request(module	=> 'LocalLB',
						interface	=> 'Pool',
						method		=> 'get_member',
						data		=> { pool_names => $pools }
						)
		}[0] };

	return @members
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB::Pool - Class for operations with LocalLB Pool inetrface.

=head1 DESCRIPTION

This module provides an interface to LocalLB pool management capabilities.

=head1 METHODS

=head3 foo


=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-Pool>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::Pool


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-Pool>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-Pool>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-Pool>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-Pool/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
