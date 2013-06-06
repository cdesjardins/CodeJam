#!/usr/bin/env python
#
# Solution to http://code.google.com/codejam/contests.html 
# Code Jam 2013, Qualification Round: Tic-Tac-Toe-Tomek
# Chris Desjardins - cjd@chrisd.info
#
import sys, os

noWinner = "Game has not completed"
xWon = "X won"
oWon = "O won"
draw = "Draw"

def readBoard():
    ret = []
    for i in range (0, 4):
        line = list(sys.stdin.readline().rstrip(os.linesep))
        ret.append(line)
    sys.stdin.readline()
    return ret

def checkFour(four):
    match = 1
    result = noWinner
    first = four[0]
    if (first == 'T'):
        first = four[1]
    for i in range (match, len(four)):
        if ((four[i] == first) or (four[i] == 'T')):
            match = match + 1
    if (match == len(four)):
        if (first == 'X'):
            result = xWon
        elif (first == 'O'):
            result = oWon
    return result

def checkRows(board):
    result = noWinner
    for i in range (0, len(board)):
        result = checkFour(board[i])
        if (result != noWinner):
            break
    return result

def rotate(board):
    ret = []
    z = zip(*board[::-1])
    for i in range(0, len(z)):
        ret.append(list(z[i]))
    return ret;

def checkDiags(board):
    foura = []
    fourb = []
    for i in range (0, len(board)):
        foura.append(board[i][i])
        fourb.append(board[len(board) - i - 1][i])
    result = checkFour(foura)
    if (result != noWinner):
        return result
    result = checkFour(fourb)
    return result

def isGameDone(board):
    dots = 0
    for four in board:
        dots += four.count('.')
    if (dots == 0):
        return draw
    return noWinner

def processBoard(board):
    result = checkRows(board)
    if (result != noWinner):
        return result
    b1 = rotate(board)
    result = checkRows(b1)
    if (result != noWinner):
        return result
    result = checkDiags(board)
    if (result != noWinner):
        return result
    result = isGameDone(board)
    return result

def main(argv):
    numTests = int(sys.stdin.readline())
    for i in range (0, numTests):
        board = readBoard()
        result = processBoard(board)
        print "Case #" + str(i + 1) + ": " + result

if __name__ == "__main__":
    main(sys.argv[1:])

