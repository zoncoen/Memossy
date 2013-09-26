#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use autodie;

print "This script is create a database table in MySQL and a config file.\n";
print "Please enter your MySQL username, password and database name.\n";
print "username: ";
chomp(my $user = <STDIN>);
print "password: ";
system "stty -echo";
chomp(my $pass = <STDIN>);
system "stty echo";
print "\ndatabase name: ";
chomp(my $db_name = <STDIN>);
print "\n";

print "Create a database table in MySQL.\n";
system "mysql $db_name -u $user -p$pass < schema.sql";

# Create config file.
open(OUT, "> Memossy.conf") or die '$!';
print OUT <<"EOF";
##### This file was created by setup.pl.

+{
    'Teng' => +{connect_info => +[
        'dbi:mysql:$db_name',
        '$user',
        '$pass'
    ]},
};
EOF
close(OUT);
print "\nCreated a config file (Memossy.conf).\n";

