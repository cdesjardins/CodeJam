#!/usr/bin/perl
#
# Solution to http://code.google.com/codejam/contests.html 
# Code Jam 2008, Round 1A: Minimum Scalar Product.
# Chris Desjardins - cjd@chrisd.info
#
use strict;

sub get_sorted_array(@)
{
    my ($v, $ascend) = @_;
    my @ret;
    my @va = split(/ /, $v);
    if ($ascend)
    {
        @ret = sort {$a <=> $b} (@va);
    }
    else
    {
        @ret = sort {$b <=> $a} (@va);
    }
    return @ret;
}

sub compute_scalar_product(@)
{
    my ($p1, $p2) = @_;
    my $ret = 0;
    my @va1 = @{$p1};
    my @va2 = @{$p2};
    my $cnt;
    
    for ($cnt = 0; $cnt < @va1; $cnt++)
    {
        $ret += $va1[$cnt] * $va2[$cnt];
    }
    return $ret;
}

sub process_test(@)
{
    my ($cnt, $num_coords, $v1, $v2) = @_;
    my @va1 = get_sorted_array($v1, 0);
    my @va2 = get_sorted_array($v2, 1);
    my $answer = compute_scalar_product(\@va1, \@va2);
    print ("Case #$cnt: $answer\n");
}

sub process_file(@)
{
    my $v1;
    my $v2;
    my $num_coords;
    my $num_tests;
    my $cnt;
    open(INFILE, "A-large-practice.in") || die("Could not open file!");
    $num_tests = <INFILE>;
    for ($cnt = 1; $cnt <= $num_tests; $cnt++)
    {
        $num_coords = <INFILE>;
        $v1 = <INFILE>;
        $v2 = <INFILE>;
        chomp($num_coords);
        chomp($v1);
        chomp($v2);
        process_test($cnt, $num_coords, $v1, $v2);
    }
}

process_file();
