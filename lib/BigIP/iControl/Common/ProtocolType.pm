package BigIP::iControl::Common::ProtocolType;

use strict;
use warnings;
use overload ('""' => \&_stringify );

our $VERSION    = '0.01';

our %DATA = (
	PROTOCOL_ANY		=> 0,
	PROTOCOL_IPV6		=> 1,
	PROTOCOL_ROUTING	=> 2,
	PROTOCOL_NONE		=> 3,
	PROTOCOL_FRAGMENT	=> 4,
	PROTOCOL_DSTOPTS	=> 5,
	PROTOCOL_TCP		=> 6,
	PROTOCOL_UDP		=> 7,
	PROTOCOL_ICMP		=> 8,
	PROTOCOL_ICMPV6		=> 9,
	PROTOCOL_OSPF		=> 10,
	PROTOCOL_SCTP		=> 11
);

sub new {
        my( $class, $protocol ) = @_; 
        my $self		= bless {}, $class;
        $self->{ protocol }	= $protocol;
        $self->{ value }	= $DATA{ $protocol };
        return $self
}

sub protocol { return $_[0]->{ protocol } }

sub value { return $_[0]->{ value } }

sub _stringify { return "$_[0]->{ protocol }" }

1;

__END__

=head1 NAME

BigIP::iControl::Common::ProtocolType - Utility class for working with ProtocolType objects.

=head1 DESCRIPTION

This module implements a utility class for representation of ProtocolType objects.

=head1 METHODS

=head3 protocol

Returns the protocol numerical identifier (see iControl documentation for allowed values).

=head3 value

Returns the protocol member value (see iControl documentation for allowed values).

B<Note> that this class also implements an overloaded stringification method that returns
the output of the I<protocol> method.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-Common-ProtocolType>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::Common::ProtocolType


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-Common-ProtocolType>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-Common-ProtocolType>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-Common-ProtocolType>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-Common-ProtocolType/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
