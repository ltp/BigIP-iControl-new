package BigIP::iControl::Common::EnabledState;

use strict;
use warnings;

use overload ( '""' => \&stringify );

sub new {
	my( $class, $state ) = @_;
	$state or do { warn 'Mandatory value required for constructor'; return undef };
	my $self	= bless {}, $class;
	$self->{state}	= $state;
	$self->{value}	= ( $state eq 'STATE_ENABLED' ? 1 : 0 );
	return $self
}

sub value 	{ return $_[0]->{value} 	}

sub state 	{ return $_[0]->{state} 	}

sub stringify 	{ return "$_[0]->{ state }" 	}

1;

__END__

=head1 NAME

BigIP::iControl::Common::EnabledState - Utility class for virtual server state representation.

=head1 DESCRIPTION

This module implements a utility class providing virtual server state representation.

=head1 METHODS

=head3 state

Returns the enabled state of the virtual server - either STATE_ENABLED or STATE_DISABLED.

=head3 value

Returns the enabled state of the virtual server as a integer value where:

	STATE_ENABLED  => 1
	STATE_DISABLED => 0

Note that this class also implements an overloaded stringification method that returns
the same output as the I<state()> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-EnabledState>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::EnabledState


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-EnabledState>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-EnabledState>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-EnabledState>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-EnabledState/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
