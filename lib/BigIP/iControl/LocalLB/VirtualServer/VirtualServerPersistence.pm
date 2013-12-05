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

=head1 NAME

BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence - Class for operations with virtual server persistence records.

=head1 DESCRIPTION

This utility class facilitates operations with LocalLB (LTM) virtual server persistence records.

=head1 METHODS

=head3 profile_name

Returns the name of the virtual server persistence profile.

=head3 default_profile

Returns the name of the default virtual server persistence profile.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB-VirtualServer-VirtualServerPersistence>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl::LocalLB::VirtualServer::VirtualServerPersistence


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl-LocalLB-VirtualServer-VirtualServerPersistence>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl-LocalLB-VirtualServer-VirtualServerPersistence>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl-LocalLB-VirtualServer-VirtualServerPersistence>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl-LocalLB-VirtualServer-VirtualServerPersistence/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
