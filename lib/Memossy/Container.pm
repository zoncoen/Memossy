package Memossy::Container;
use Object::Container::Exporter -base;
use Config::PL;

register_default_container_name 'obj';

register_namespace api => 'Memossy::Model::Api';

register conf => sub {
    my $config = config_do 'Memossy.conf';
};

register db => sub {
    my $self = shift;
    $self->load_class('Memossy::Model::DB');
    Memossy::Model::DB->new( $self->get('conf')->{'Teng'} );
};

1;
