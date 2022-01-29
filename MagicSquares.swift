/*
  MagicSquares.swift
  
  By Zefeng Wang
  Created January 28, 2022
   
  This program generates all the magic squares with a magical number equal to 15 
  with a recursive function.
*/

// Checks to see if the array is a valid magic square
func isMagic(square: [Int]) -> Bool {

	let length = 3

	// Convert array to 2D array
	let emptyArray = Array(repeating: Array(repeating: 0, count: 3), count: 3)
	var iter = square.makeIterator()
	let array = emptyArray.map { $0.compactMap { _ in iter.next() } }

	if square.count == 9 {

                // Check minor and major diagonals
                var majDi = 0
                var minDi = 0
                for index in 0..<length {
                        majDi += array[index][index]
                        minDi += array[index][length - 1 - index]
                }

                if majDi != minDi {
                        return false
                }

                // Checks each row and column
                for row in 0..<length {
                        var rowSum = 0
                        var colSum = 0
                        for col in 0..<length {
                                rowSum += array[row][col]
                                colSum += array[col][row]
                        }

                        if rowSum != colSum || colSum != majDi {
                                return false
                        }

                }
                return true
        }
        return false
}

// Generates the magic square
func genSquare(square: [Int], currentSquare: [Int], index: Int) {

    var mutableSquare = square
    var mutableCurrentSquare = currentSquare

    for ind in 0..<mutableSquare.count
        where mutableCurrentSquare[ind] == 0 {

        mutableSquare[index] = ind + 1
        mutableCurrentSquare[ind] = 1

        if index < mutableSquare.count - 1 {
            genSquare(square: mutableSquare, currentSquare:
                mutableCurrentSquare, index: index + 1)
        } else if isMagic(square: mutableSquare) {
            printMagicSquare(output: mutableSquare)
        }

        mutableCurrentSquare[ind] = 0
    }
}

// Outputs a formatted magic square
func printMagicSquare(output: [Int]) {
	print("\n*****")
	for count in 0..<output.count {
		if count == 3 || count == 6 {
			print()
			print("\(output[count]) ", terminator: "")
        	} else {
            		print("\(output[count]) ", terminator: "")
        	}
    	}

    	print("\n*****")
}

// Create array to store the digits for the magic square
var digits = Array(repeating: 0, count: 9)
for num in 0..<digits.count {
	digits[num] = num + 1
}

let numbers = Array(repeating: 0, count: 9)

print("\nAll Possible Magic Squares (3x3):\n")

genSquare(square: digits, currentSquare: numbers, index: 0)
