package Memossy::Model::Api::Page;
use strict;
use warnings;
use Memossy::Container qw/api/;
use Data::GUID;
use Smart::Args;

sub new { bless {}, +shift }

sub add {
    args my $self, my $title, my $body;

    $title =~ s/\r//g;
    $title =~ s/\n/ /g;
    obj('db')->insert(
        'page',
        {   rid   => Data::GUID->new->as_hex,
            title => $title,
            body  => $body
        }
    );
}

sub edit_or_delete {
    my ( $self, $page, $args ) = @_;

    ( my $body = $args->{body} ) =~ s/\r//g;

    if ($body) {
        $page->update(
            {   title => $args->{title},
                body  => $body,
            }
        );
    }
    else {
        $page->delete;
    }
}

sub get { obj('db')->single( 'page', { rid => $_[1] } ) }

sub list { obj('db')->search( 'page', {} ) }

1;
