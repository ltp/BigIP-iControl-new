package BigIP::iControl::LocalLB;

use strict;
use warnings;

use BigIP::iControl::LocalLB::VirtualServer;
use BigIP::iControl::LocalLB::Class::StringClass;
use Scalar::Util qw(weaken);

sub new {
	my( $class, $icontrol, %args ) = @_;
	my $self = bless {}, $class;
	weaken( $self->{_icontrol} = $icontrol );
	return $self;
}

sub string_class {
	my( $self, $name ) = @_;
	my $members = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class', 
				method		=> 'get_string_class', 
				data		=> { class_names => [$name] } 
			) }[0] ;
	print "foo\n";
	
	my @values = @{ $self->{_icontrol}->_request(
				module		=> 'LocalLB', 
				interface	=> 'Class',
				method		=> 'get_string_class_member_data_value', 
				data		=> { name => $name, class_members => [$members] } 
			) }[0];
	
	my %members;
	@members{ @{ $members->{members} } } = @{ $values[0] };
	my $string_class = BigIP::iControl::LocalLB::Class::StringClass->new( $name, $self->{_icontrol}, %members );
	return $string_class;
}

sub string_class_list {
	my( $self ) = @_;
	return $self->{_icontrol}->_request(module => 'LocalLB', interface => 'Class', method => 'get_string_class_list') 
}

sub virtual_server {
	my( $self, $name ) = @_;
	my $virtual = BigIP::iControl::LocalLB::VirtualServer->new( $self->{_icontrol}, $name );
	return $virtual
}

1;

__END__

=head1 NAME

BigIP::iControl::LocalLB - Class for operations with the LocalLB module of BigIP devices.

=head1 DESCRIPTION

This module provides an interface to the LocalLB (LTM) module of a BigIP device.

=head1 METHODS

=head3 string_class

=head3 string_class_list


=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl-LocalLB>.  
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc BigIP::iControl


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=BigIP-iControl>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/BigIP-iControl>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/BigIP-iControl>

=item * Search CPAN

L<http://search.cpan.org/dist/BigIP-iControl/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Luke Poskitt.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
