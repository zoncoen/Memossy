package Memossy::Web;

use strict;
use warnings;
use utf8;
use Kossy;
use Memossy::Container qw/api/;

filter 'set_title' => sub {
    my $app = shift;
    sub {
        my ( $self, $c ) = @_;
        $c->stash->{site_name} = __PACKAGE__;
        $app->( $self, $c );
        }
};

get '/' => [qw/set_title/] => sub {
    my ( $self, $c ) = @_;

    my $list = api('Page')->list()->all;

    $c->render( 'index.tx', { list => $list } );
};

get '/new' => sub {
    my ( $self, $c ) = @_;

    $c->render('edit.tx');
};

post '/add' => sub {
    my ( $self, $c ) = @_;

    my $result = $c->req->validator(
        [   title => [ [ 'NOT_NULL', 'title must be defined' ] ],
            body  => [ [ 'NOT_NULL', 'body must be defined' ] ],
        ]
    );

    $result->has_error
        and $c->render( 'edit.tx', { validator => $result, } );

    my $page = api('Page')->add( $c->req->parameters );

    return $c->redirect( '/' . $page->rid );
};

get '/:rid' => sub {
    my ( $self, $c ) = @_;

    my $page = api('Page')->get( $c->args->{rid} )
        or return $c->redirect('/');

    $c->render( 'memo.tx', { page => $page } );
};

router [ 'GET', 'POST' ] => '/edit/:rid' => sub {
    my ( $self, $c ) = @_;

    my $page = api('Page')->get( $c->args->{rid} )
        or return $c->redirect('/');

    if ( $c->req->method eq 'POST' ) {
        my $result = $c->req->validator( [ title => [ [ 'NOT_NULL', 'title must be defined' ] ], ] );

        $result->has_error
            and return $c->render(
            'edit.tx',
            {   validator => $result,
                page      => $page,
            }
            );

        api('Page')->edit_or_delete( $page, $c->req->parameters );

        return $c->redirect( '/' . $page->rid );
    }

    $c->render( 'edit.tx', { page => $page, } );
};

1;

