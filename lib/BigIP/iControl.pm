package BigIP::iControl;

use strict;
use warnings;

use Carp qw(confess croak);
use SOAP::Lite;
use MIME::Base64;
use Data::Dumper;
use BigIP::iControl::Deserializer;
use BigIP::iControl::LocalLB;

our $VERSION = '0.01';

sub new {
        my( $class, %args )	= @_;
        my $self                = bless {}, $class;
        defined $args{server}   ? $self->{server}   = $args{server}   : croak 'Constructor failed: server not defined';
        defined $args{username} ? $self->{username} = $args{username} : croak 'Constructor failed: username not defined';
        defined $args{password} ? $self->{password} = $args{password} : croak 'Constructor failed: password not defined';
        $self->{proto}          = ($args{proto} or 'https');
        $self->{port}           = ($args{port}  or '443');
        $self->{_client}        = SOAP::Lite->proxy( $self->{proto}.'://'.$self->{server}
							.':'.$self->{port}.'/iControl/iControlPortal.cgi' )
				  ->deserializer( BigIP::iControl::Deserializer->new );
        $self->{_client}
             ->transport
             ->http_request
             ->header( 'Authorization' => 'Basic ' . MIME::Base64::encode( "$self->{username}:$self->{password}" ) );

        eval { $self->{_client}->transport->ssl_opts( verify_hostname => $args{verify_hostname} ) }; 

        return $self;
}

sub _request {
        my ($self, %args)= @_;

	my @params;

	foreach my $param ( keys %{ $args{data} } ) {
		my $value = $args{ data }->{ $param };
		push @params, SOAP::Data->name( $param => $value )
	}

        $self->_set_uri( $args{module}, $args{interface} );
        my $method      = $args{method};
        my $query       = $self->{_client}->$method(@params);
	$self->_unset_uri;
	return $query->fault ? do { $query->fault->{_has_fault} = 1 ; $query->fault } : $query->result;

        $query->fault and confess('SOAP call failed: ', $query->faultstring);
        $self->_unset_uri();                     

        return $query->result;          
}

sub _set_uri {
        my( $self, $module, $interface ) = @_;
        $self->{_client}->uri("urn:iControl:$module/$interface");
        return 1
}

sub _unset_uri {
        undef $_[0]->{_client}->{uri};
}

sub ltm {
	my $self = shift;
	exists $self->{_ltm} or $self->{_ltm} = BigIP::iControl::LocalLB->new( $self );
	return $self->{_ltm}
}

#$icontrol->add_ltm_virtual_clone_pool
#$icontrol->ltm->virtual->add_clone_pool( virtual_servers => qw[ apps_f ], clone_pools => 
#my $data_group = $icontrol->ltm->data_group( 'WWW_Redirects' )->member( '/about' )->value;
#virtual->_clone_pool( virtual_servers => qw[ apps_f ], clone_pools => 

#$icontrol	->ltm
#		->virtual
#		->add_clone_pool

1;

__END__

=head1 NAME

BigIP::iControl - The great new BigIP::iControl!

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use BigIP::iControl;

    my $foo = BigIP::iControl->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 AUTHOR

Luke Poskitt, C<< <ltp at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-bigip-icontrol at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=BigIP-iControl>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




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

