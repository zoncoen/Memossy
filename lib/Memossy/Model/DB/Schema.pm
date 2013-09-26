package Memossy::Model::DB::Schema;
use Teng::Schema::Declare;

table {
    name 'page';
    pk 'id';
    columns qw(
        id
        rid
        title
        body
        updated_at
    );
};

1;
