#!/usr/bin/perl
#
# Solution to http://code.google.com/codejam/contests.html 
# Code Jam 2010, Round 1B: File Fix-it.
# Chris Desjardins - cjd@chrisd.info
#
use strict;

sub split_dirs(@)
{
    my ($line) = @_;
    my @dirs = split(/\//, substr($line, 1));
    return \@dirs;
}

sub get_input()
{
    my $line;
    $line = <STDIN>; 
    chomp($line);
    return $line;
}

sub get_existing(@)
{
    my ($num_exist) = @_;
    my $cnt;
    my @dirs;
    my $full_path;
    my %existing;
    for ($cnt = 0; $cnt < $num_exist; $cnt++)
    {
        @dirs = @{split_dirs(get_input())};
        $full_path = "";
        foreach my $dir (@dirs)
        {
            $full_path .= "/$dir";
            $existing{$full_path} = 1;
        }
    }
    return \%existing;
}

sub count_mkdirs(@)
{
    my ($num_new, $exist) = @_;
    my $cnt;
    my @dirs;
    my $full_path;
    my %existing = %{$exist};
    my $mkdir_cnt = 0;
    for ($cnt = 0; $cnt < $num_new; $cnt++)
    {
        @dirs = split(/\//, substr(get_input(), 1));
        $full_path = "";
        foreach my $dir (@dirs)
        {
            $full_path .= "/$dir";
            if (!defined($existing{$full_path}))
            {
                $existing{$full_path} = 1;
                $mkdir_cnt++;
            }
        }
    }
    return $mkdir_cnt;
}

sub process_file(@)
{
    my $num_tests = get_input();
    my $test_case;
    my $num_exist;
    my $num_new;
    my $mkdir_cnt;

    for($test_case = 1; $test_case <= $num_tests; $test_case++)
    {
        ($num_exist, $num_new) = split(/ /, get_input());
        $mkdir_cnt = count_mkdirs($num_new, get_existing($num_exist));
        print("Case #$test_case: $mkdir_cnt\n");
    }
}

process_file();
