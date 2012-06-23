#!/usr/bin/perl
#
# Solution to http://code.google.com/codejam/contests.html 
# Code Jam 2012, Qualification Round: Speaking in tounges
# Chris Desjardins - cjd@chrisd.info
#
use strict;
my %letter_map = ();
sub build_hash()
{
    my $in = "ejp mysljylc kd kxveddknmc re jsicpdrysi rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd de kr kd eoya kw aej tysr re ujdr lkgc jvqz";
    my $out = "our language is impossible to understand there are twenty six factorial possibilities so it is okay if you want to just give upzq";
    my @in = split(//, $in);
    my @out = split(//, $out);
    my $index = 0;
    foreach my $key (@in)
    {
        $letter_map{$key} = $out[$index++];
    }
}

sub print_hash()
{
    foreach my $key (sort keys %letter_map)
    {
        print("'$key' => '$letter_map{$key}',\n");
    }
}

sub get_input(@)
{
    my $line;
    $line = <STDIN>; 
    chomp($line);
    return $line;
}

sub get_result(@)
{
    my ($line) = @_;
    my @char_list = split(//, $line);
    my $result = "";
    foreach my $char (@char_list)
    {
        $result .=  defined($letter_map{$char}) ? $letter_map{$char} : "\n\n\nNOT DEFINED $char\n\n\n";
    }
    return $result;
}

sub process_file()
{
    my $num_tests = get_input();
    my $test_case;

    for($test_case = 1; $test_case <= $num_tests; $test_case++)
    {
        my $line = get_input();

        printf("Case #$test_case: %s\n", get_result($line));
    }
}

build_hash();
process_file();
