#!/usr/bin/perl
#
# Solution to http://code.google.com/codejam/contests.html 
# Code Jam 2010, Round 1A: Rotate.
# Chris Desjardins - cjd@chrisd.info
#
use strict;
use Math::Round;
use Math::MatrixReal;
use sort 'stable';

sub get_input(@)
{
    my $line;
    $line = <STDIN>; 
    chomp($line);
    return $line;
}

sub sort_cmp_algo(@)
{
    my $ret = 1;
    if ((($a eq 'R') || ($a eq 'B')) && (($b eq 'R') || ($b eq 'B')))
    {
        $ret = 0;
    }
    elsif ($a eq '.')
    {
        $ret = -1;
    }
    return $ret;
}

sub read_board(@)
{
    my ($size) = @_;
    my @board;
    my $row;
    foreach (0 .. $size)
    {
        $row = join('', sort sort_cmp_algo split(//, get_input()));
        push(@board, $row);
    }
    return rotate_board(\@board);
}

sub rotate_board(@)
{
    my ($b) = @_;
    my @board = @{$b};
    my @out_board;
    my @row;
    my $row_index;
    foreach my $col_index (0 .. (@board - 1))
    {
        @row = split(//, $board[$col_index]);
        foreach $row_index (0 .. (@row - 1))
        {
            $out_board[$row_index] = shift(@row) . $out_board[$row_index];
        }
    }
    return \@out_board;
}

sub remove_scale_factor(@)
{
    my ($b) = @_;
    my @rotated_board = @{$b};
    my @out_board;
    foreach my $row (@rotated_board)
    {
        my $rowstr = join('', @{$row});
        $rowstr =~ tr/~//d;
        if (length($rowstr))
        {
            push(@out_board, $rowstr);
        }
    }
    return \@out_board;
}

sub rotate_board_45(@)
{
    my ($b, $direction) = @_;
    my @board = @{$b};
    my @rotated_board;
    my @tmp_board;
    my $row_index;
    my $col_index;
    my $size = @board;
    my $rotation_matrix = Math::MatrixReal->new_from_rows([[0.707, $direction * -0.707], [$direction * 0.707, 0.707]]);
    my $scale_matrix    = Math::MatrixReal->new_from_rows([[2, 0], [0, 2]]);
    foreach $row_index (0 .. ($size - 1))
    {
        push(@tmp_board, [split(//, $board[$row_index])]);
    }
    foreach $row_index (0 .. ($size * 5))
    {
        push(@rotated_board, [("~") x ($size * 5)]);
    }
    foreach $row_index (0 .. ($size - 1))
    {
        foreach $col_index (0 .. ($size - 1))
        {
            # take our current x,y and make them into a vector.
            my $vector = Math::MatrixReal->new_from_rows([[$row_index, $col_index]]);
            # now blow up our vector to 2x because the rotation will result in floating
            # point x,y values which if they are too close to each other they might 
            # overwrite an existing cell. (eliminate aliasing issues)
            my $scaled_product = $vector->multiply($scale_matrix);
            # now apply the rotation of plus or minus 45 degrees
            my $rotated_product = $scaled_product->multiply($rotation_matrix);
            # now get the new rotated (and scaled) x,y coords rounded to the nearest integer.
            my $x = round($rotated_product->element(1,1)) + ($size * 2);
            my $y = round($rotated_product->element(1,2)) + ($size * 2);
            # stick the value in its new home.
            $rotated_board[$x][$y] = $tmp_board[$row_index][$col_index];
        }
    }
    return remove_scale_factor(\@rotated_board);
}

sub find_k_accross(@)
{
    my ($b, $win_len, $color) = @_;
    my @board = @{$b};
    my $check = ($color x $win_len);
    foreach my $index (0 .. (@board - 1))
    {
        if (index($board[$index], $check) > -1) 
        {
            return 1;
        }
    }
    return 0;
}

sub find_k_in_a_row(@)
{
    my ($b, $win_len, $color) = @_;
    my $result;
    $result = find_k_accross($b, $win_len, $color);
    if ($result == 0)
    {
        $result = find_k_accross(rotate_board($b), $win_len, $color);
    }
    if ($result == 0)
    {
        $result = find_k_accross(rotate_board_45($b, 1), $win_len, $color);
    }
    if ($result == 0)
    {
        $result = find_k_accross(rotate_board_45($b, -1), $win_len, $color);
    }
    return $result;
}

sub get_winning_color(@)
{
    my ($key) = @_;
    my %result_hash = ("RB" => "Both", "R" => "Red", "B" => "Blue");
    if (defined $result_hash{$key})
    {
        return $result_hash{$key};
    }
    else
    {
        return "Neither";
    }
}

sub get_winner(@)
{
    my ($b, $win_len) = @_;
    my $result_key;
    $result_key = find_k_in_a_row($b, $win_len, 'R') ? 'R' : '';
    $result_key .= find_k_in_a_row($b, $win_len, 'B') ? 'B' : '';
    return get_winning_color($result_key);
}

sub process_file()
{
    my $num_tests = get_input();
    my $test_case;
    my @board;
    my $winner;

    for($test_case = 1; $test_case <= $num_tests; $test_case++)
    {
        my $line = get_input();
        my ($size, $win_len) = split(/ /, $line);
        $size--;
        @board = @{read_board($size)};
        $winner = get_winner(\@board, $win_len);
        print("Case #$test_case: $winner\n");
    }
}

process_file();
